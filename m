Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C447359A68;
	Fri, 14 Aug 2026 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786720504; cv=fail; b=QE9zszq/aC3ODwYoZWc9kLWeZIiij6np287dH2I3KqorJtwNZroKc/9Zje431cVjRoAlNSG96G0ChRC0pRsMptCWPJTFmtlsr4xuiHgw+z2l1U1Ik/pKqhuJzKoW2zqeDWzwfA3qExatP09PtEvYoJAAZOlH2atJO5lq+pgRWTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786720504; c=relaxed/simple;
	bh=iKkgCATS2X3Ij7H5vJPOcUSQfO07hMWb4BiKUO39kQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XszO49CEHAR+6/aXEs/1KjeZl0H/K8zBNXt7fC0RBYmgAR9j/TQyiXZeYoZu7FQaHJho1hKPVuMJLtZX/LgoS5IEcPz6/7BYFPr23jHHmo3V/BpBvjN6Q3LzkjubFCixNt+3OnTqzWlS/t9L+lgPQLnj7dszZ/h64POLz+jq5wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kS3gMWNu; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kS3gMWNu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786720503; x=1818256503;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iKkgCATS2X3Ij7H5vJPOcUSQfO07hMWb4BiKUO39kQg=;
  b=kS3gMWNuc7EzGEPacfb1wVqsgLt0fNqXxYm9xRDdi9nViD8njXwhGuhQ
   BD7vKBwCuqjtXXw4F4bzmheQmcpP8Ai1LopY6QaOuvmVpaz+sMYyMrhzm
   1IW4ux7hLxNMFNHrfpwMAoYboWy9OqSxuaQlFEzClf5y37i8Ap8dyJ9sr
   4mN8GGB9PQVEOMdUzAKFz6SLe02z7d/mteQ5ngcLXNGBEOvf9SjR/F4pj
   kQ11NU3CwnJ6+TfoqsO11TGgBEER4DccC0HrypwUOo6SFSRQqTPazuOIu
   pgyPahT85/ERm3WsPo8ioRTl9SrEU46FSxXrIkzHcomlsHUAk8RWnt6Jn
   w==;
X-CSE-ConnectionGUID: aO7qO2QlSKOYSOWg44NjZQ==
X-CSE-MsgGUID: 9bkztgQGSVqkxnNIWhVosg==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87160574"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87160574"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 08:14:59 -0700
X-CSE-ConnectionGUID: WJHf8bJSS0aqU3rpN5sL9g==
X-CSE-MsgGUID: CMJgcoBZRnWHEL8CoR3TMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="268104369"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 08:14:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 08:14:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 08:14:58 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 08:14:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDgseKprJCjaubz85VuWl0oJPBJMAaPDn72wH0DvanmezMRQg2R1SfcWH7lQttGsiLbwIYTfeksq/1JEZWCOt9pvNNGKzdWsNpLq/O2S+6TknNjHlx2ZNwXYtoF7vN+flYClrZHeChJY3HDRJMVWXLxJXSVzd006AVXsOMMtpEIVX8OWZcK5uxLod3r1RmVVdUejkm0/ICVeo4ZOIX8KtimEUxdHXxVH3+9eJcPu4PWBL3aGH6K4K4GjBQrZm9Cjjh7zTkg9fbUvLh7XVMwQ3CegsYJHFjG8tzr54mibbb0+T7oImfVCuC3em3Zx2rO1giWrKEu+qmh8YDUe5gT8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKkgCATS2X3Ij7H5vJPOcUSQfO07hMWb4BiKUO39kQg=;
 b=OY6B3nA31HyOooca3TLaI/zY3/ITvdA5iDX354RP7X+ZuL9plqu8lMLP8QfR2tYy9BZLU0gDyYGzp0SCKJrSajlxkGyTWPEOtSWzu8OSjOxYorlkFG9eq0tXWpA6YubMk1ZTjhJedZY4KqmXwQMTV+9kxouMGlV6RruHWgJFPkh4Z5QtJkYZ+3ObL88ZB9S9zPCDWFvrpD+1L4m+5xvwYbDFfuVrynQOYdnjNc/Fw9Smpr3XLo3WxGryJPHks/TNqT8QjGOieVaSeHe48+3LS5q+2suHuvC9yvdPCcemP14f38G5n48o8ihmp+droXWtMIiXO8Qy5dzXmbB9av95dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS4PPF2D9C959A2.namprd11.prod.outlook.com (2603:10b6:f:fc02::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 15:14:51 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 15:14:51 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Aktas, Erdem" <erdemaktas@google.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"afranji@google.com" <afranji@google.com>, "kas@kernel.org" <kas@kernel.org>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "oupton@kernel.org"
	<oupton@kernel.org>, "wyihan@google.com" <wyihan@google.com>,
	"sagis@google.com" <sagis@google.com>, "Gao, Chao" <chao.gao@intel.com>,
	"Wang, Roger" <runanwang@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "jmcrey@google.com" <jmcrey@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v14 09/22] KVM: selftests: Expose functions to get default
 sregs values
Thread-Topic: [PATCH v14 09/22] KVM: selftests: Expose functions to get
 default sregs values
Thread-Index: AQHdGi/hxauQmPt6b0+OMtPNB7dFw7ac19uAgAAfQYCAANTKgA==
Date: Fri, 14 Aug 2026 15:14:51 +0000
Message-ID: <ed157f3d29d1830aa4664db565879c4da945fc48.camel@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
	 <20260722-tdx-selftests-v14-9-15ad654a50db@google.com>
	 <b7f7ad93360d7e0fe59ab7f3b0ed6fa79375001f.camel@intel.com>
	 <7782f61a-1384-4960-85c3-5613fbf27729@intel.com>
In-Reply-To: <7782f61a-1384-4960-85c3-5613fbf27729@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS4PPF2D9C959A2:EE_
x-ms-office365-filtering-correlation-id: 1de02cd6-6cf8-4748-9972-08defa16c9d2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006|921020|38070700021;
x-microsoft-antispam-message-info: YpxuMnlo3kwk/S1N4lSw946N35rnDiSUqS5Dde3sOEm31x1vxDjU16iOiWRAaHE4rXoulKCUpv5Cyk74B8sDEosXEig4BZxFvWjVkWIle3d6uBvaBF/N72Flq0sOJl6m9jrwTIWLKjMJ5b2RYL/3J4CXboV4UKo50GFIiX9fJzjzAcOXVuEX9EQQ8J1zAg4EiygQef6ojpm3hBU55M1sGK6/dtvygiqwmHKJsQkPrmrZ7NyxvAb3iY63DKiY/RRAWm9Qvbf/rBSeASm7qc9bbIkVuAxYknwkYux+JA4NokfN4RND7xf8vhMWCgR9ZtNL9GGHiSuw+X8xGdloBuFN3HyC/7sQ8oQjIdEJzcX0l19HRikR5cSKbOAma+Lc0JTTtkx2o5h3qRaGoXJKNvfTPnNnoqDtWN4l82A7sOLXc5S1yWOBQCTXKlyOAALzEbiWhV/7HTw0AMs/ut82tT8HO7WZ6wEFCHzyLGtez6i2KJLMguILQVucnKz/IgH59wdWf6IGK0Gx7x5+eOugPZIjmR00JBXOpSirwRT2esfpShyQzLmusQERRhMCJCoLwhELIoalLheYkytnYm+0w5zwtHHvP57Tes9qpgcqUyixzvVA9HcucEn7wXw2slK/p5+gqDOnuUlQsTUS5c0H6lOQiaquRLmHvzJAjp2aRyiTJYkcaB1iWa5dRG+ufiJJHcXjmG66nzB1N5u3nsLmP7VOGFdw+H5QZClwjohjb9SkQtTEM/HUuG/a94ZwGZ111jYy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEdXT2hGWlFsb1pwTHJlMDZpbFFjOHBQRzdHZVNKVDVOZnREUUdwSjBZV1My?=
 =?utf-8?B?bnVOb3FDZFNra1JyUk85RUkrVjlHdTlyMVcvVWkwbUhuQzB0RTRZU1l5TzVh?=
 =?utf-8?B?RW9CVkpORVhhbFNzYkszMVlYalRWQlJwb29ybGhMVFJ4MXUxMFJQV0ZjZ2hx?=
 =?utf-8?B?WFo4RUVpVnJxcmQ0Rk9lOU1kKzZGc3hvQ0l4YVFGTVBKWFBpUHlPSndRM2ZN?=
 =?utf-8?B?eitSb1U2VitnZHB0QWxPT3hRN0JYM2g3VlplYitybFZEVDkwQ0V3ZGZ6K29P?=
 =?utf-8?B?QncwTkdhWTVVUlNKZmRjb2JBN25BWjZtWTgzUWJIaklSalkvSWlxRkxXUWpr?=
 =?utf-8?B?RlBFUStGdWlVTkRvV3ZaV0tSU0RWdjgwTW12Q3Vob2VkNWp1MGQ3b21MRi9P?=
 =?utf-8?B?TklFWVpEcHQ5UDNPSFNqaWxvQlFnTjgxNEdPWDUzdklleGFOZVVZU0szWld1?=
 =?utf-8?B?YWsvWGhCZE9MMnk1SFBOWHBTMW5YaFc3T2pxbTR2RkRxT2JVMXVNRHJXdXRF?=
 =?utf-8?B?cGtMckRUNlc1RWZGNCs4d2l0SURpRjlrSWw5QUdCNVc4OUk1RlFQMXd5WTU5?=
 =?utf-8?B?NGZKZ253SmZQeWo5M0djTHRGN2NWNEpxRHF6M1VvTmxCd2dqYU9TUXVyR1pD?=
 =?utf-8?B?dVBzditYRUUyL3Z1WVMrQkd4LzFybEZIc0Z6cmdlVVFJUnVPZ3JmUEJJOGVs?=
 =?utf-8?B?enBxdCtzUGMrVG84akNmaFU5MU1JaGxxQWlyazFMSjJxQ3Ftbkp3Sy9wQ2JQ?=
 =?utf-8?B?ZXpJVjR1U3FxN0dacnI1SU5oSU0vNmI1VEsvR1RwZmU3TW5OTFUzcHNrK1Jn?=
 =?utf-8?B?QXlXcTRIY0ZCS3VtOXRmSkkra3lWNkN2VnJ0eXpGd1JHNHpwR2NITXZRTCtQ?=
 =?utf-8?B?eDZPdUE4MjN5Z3UyUjNjNHJKb0N4TDRqd0wxUDRCMlBVNUYyWERyb3dhVWhk?=
 =?utf-8?B?MlZyUC9URFMya3VGeEdVRXB2VHkrZWVsRHVhc05yMFNvNHZlbHZPNEthU0kr?=
 =?utf-8?B?ZWdtcHBreGtINFJHTk85QnhCeW11eWRjNlRyK1hjOG9zOW4xRldsQmMrRDZk?=
 =?utf-8?B?TmY1RC9VSDFPMTJ0bTZ5dGg0V1AvMHRoNTViVUwrREUzSzVSYXZFbXFabFJB?=
 =?utf-8?B?ajlTajBkU0dkM1ZPRFVTZjNtWkxmdVJGTUJPYXhYYlVDbWFmRWg3L2VCL1Np?=
 =?utf-8?B?ejJOdEYwWHBqVCsvckZqOGYwNWhBU2pGR2pjUExrbzlMSExab3JmaWZoVnFx?=
 =?utf-8?B?dU9iZkFQR0NXc3o5a1VXYmZWNklVOU5TNWRxOXlpK2pvbkVBSU11RVpoTzlH?=
 =?utf-8?B?QjRqU3hKcGhRVXQvNlE0elZ4Sm5Bam1rbFZ2SHpZblpxSDlIQjI4QlZqRkcr?=
 =?utf-8?B?cHVuWWs5dlJKblhTK2k5UFZGZXU4UXpiM2p4RkN4NXZYejk5SXNuNVlwZDlR?=
 =?utf-8?B?cGtFRkZqd1FNekJmVUpJK1BuRWNKaHZKQStKMjlKQXZZQzBtMHoxdS9HRzdl?=
 =?utf-8?B?SldKbUdCb3RHL3hsU0ZheHdwUG95YWhNMTBzcFgyYWhkelkzaTN0RkFvTjBK?=
 =?utf-8?B?dWQyZHdhZkFWQkZXcG1HT0ZQVHBQWDg0TDE2SDZPZEdxZDNyLzBqMzdnajhV?=
 =?utf-8?B?d2ZYZ1hNSE1nN3lKUVI5MTNMOUxoOFZxeWlwM2RWTnJiZ3hPaXJYS0FEVXV3?=
 =?utf-8?B?d0ZVQ2VxUU1ZU3V1cEVpMmFoSnh5VW1zdjFBbEZIOE1OZi80bE9SbnRCbTN1?=
 =?utf-8?B?RnduTCtES2JGc2s4c0VOcDJLQVdJdnRpcGNoRVNSSjdvVEI5dkVkUEx6eXNy?=
 =?utf-8?B?dXllc3VQL2JYTDg0UXBIUFZpWG1hSk0vYzBCUjhqMloxY2JHZEppWGtEaU95?=
 =?utf-8?B?SS83cE1GRk5EQTcwZ1BneWgzVnByWWUvZUlEUWFSTStxMnFZY3pyRjlkaHBq?=
 =?utf-8?B?czlhR0ZKWUthdEYzekczTXkyamhNbFpNY0hiemo1NFNzQUZiUnlONGFnSisv?=
 =?utf-8?B?S3RmbDZHTkJNZnQ3MmtYYnBsKzZLTDdkM0VwbVpvVGZXeFFFa0lxcUk3dDhj?=
 =?utf-8?B?bnVmVTcvdEVoZ3prbXl4ZGw4WVZtY0ttak1nd1ZuSWNHbEVmTjNHL3NNTWxq?=
 =?utf-8?B?VHBvc2F4ck9PZFk1SC9OdFRMazlXWWJaSFo1SDRsM2hSaHlEaWREU1ZGSHNH?=
 =?utf-8?B?eElab3pwNlQvbkwxQkI2dGFMenhjR1E0ZHEwSHRrdVZIWHhuWEVoQlBYUzNs?=
 =?utf-8?B?NUppekVFQlA4eDdhOXcwd0ZjaEZRVittemZDTzdwMDFqUytUN2EvaFM1clFh?=
 =?utf-8?B?MnZTVnZiM0pXaFhwaXZGNU0rTldUUktML2Y4Rm9PbEJlMlk5aGJnMkVZR0g4?=
 =?utf-8?Q?ACnH/Ug0+Je1Z6fI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53439F1A65A1944FBB7C57D4A718AA12@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eewdsQi+xeCia54sytNCkpxv3epNMr5fN2cDccN1r7WC0GGkiq/Gv2KH8zuPER/HLHN5eppbWbxJEcaBmcnC3a/Ad1DCTnAMyStE2y+e2YRGzryBPisvk6X/smbGoEnZwtSUkk8WqgADXbGVdS1IQ66TOFv8DzeX1sVuYZAtbZtfZl0MHHuO4VNv1k/FuVdhtF2xtAqxukr3cwo+YXNQ7jPk67i8+1nCdZt0pCND0SYSH4+nFsO6fgIQi/B9oVvcp/19esGylJrpBRLpHXUGIm4XLC7njwnHfjv7bntJslRukWVtCBnaiKs4QeOjdIuvWlB7nsfdcdzBQuRl3Hgfxw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de02cd6-6cf8-4748-9972-08defa16c9d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 15:14:51.5182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0aGO74QsvDgehNju37FvlUXyxC9FNcUOr00k1BEl3jzwdxZWc1yS0gKXUQ48WglCkt+24MY5PUkU5+3V4WfsCENNu0SZ4v7hRzShei44lK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2D9C959A2
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTE0IGF0IDEwOjM2ICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiA+
IElzIHRoaXMgbmVjZXNzYXJ5IGZvciB0aGlzIHBhdGNoPyBJIHNlZSB3aHkgdG8gZXh0cmFjdA0K
PiA+IGt2bV9nZXRfZGVmYXVsdF9pZHRfbGltaXQoKSBiZWNhdXNlIG5vdyBpdCdzIHVzZWQgdHdp
Y2UuIEJ1dCB3aHkgZXh0cmFjdA0KPiA+IHRoaXMNCj4gPiBkZWZpbmUgdG9vPw0KPiANCj4ga3Zt
X2dldF9kZWZhdWx0X2lkdF9saW1pdCgpIHVzZXMgTlVNX0lOVEVSUlVQVFMsIGFuZCANCj4ga3Zt
X2dldF9kZWZhdWx0X2lkdF9saW1pdCgpIGlzIGV4dHJhY3RlZCBhcyBhIGhlbHBlciBmcm9tIC5j
IGZpbGUgdG8gLmggDQo+IGZpbGUuIFNob3VsZG4ndCB0aGUgZGVmaW5lIG9mIE5VTV9JTlRFUlJV
UFRTIGJlIG1vdmVkIHRvZ2V0aGVyPw0KDQpFcnIuIHllcy4gTXkgYmFkLiBUcnlpbmcgdG8gZG8g
dG9vIG1hbnkgdGhpbmdzIGF0IG9uY2UuDQo=
