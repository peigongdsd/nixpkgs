{ lib
, buildPythonPackage
, fetchpatch
, fetchPypi
, poetry-core
, pythonOlder
, aiohttp
, backoff
, fastavro
, importlib-metadata
, requests
, urllib3
}:

buildPythonPackage rec {
  pname = "cohere";
  version = "4.32";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-OAd0e+mE8hHc6RHBM1vXE68qwrcPcpZ4OB5v9uRQ5oE=";
  };

  patches = [
    # https://github.com/cohere-ai/cohere-python/pull/289
    (fetchpatch {
      name = "replace-poetry-with-poetry-core.patch";
      url = "https://github.com/cohere-ai/cohere-python/commit/e86480336331c0cf6f67e26b0825467dfca5b277.patch";
      hash = "sha256-P1Ioq5ypzT3tx6cxrI3ep34Fi4cUx88YkfJ5ErN3VHk=";
    })
  ];

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    aiohttp
    backoff
    fastavro
    importlib-metadata
    requests
    urllib3
  ];

  # tests require CO_API_KEY
  doCheck = false;

  pythonImportsCheck = [
    "cohere"
  ];

  meta = with lib; {
    description = "Simplify interfacing with the Cohere API";
    homepage = "https://docs.cohere.com/docs";
    changelog = "https://github.com/cohere-ai/cohere-python/blob/main/CHANGELOG.md#${builtins.replaceStrings ["."] [""] version}";
    license = licenses.mit;
    maintainers = with maintainers; [ natsukium ];
  };
}
