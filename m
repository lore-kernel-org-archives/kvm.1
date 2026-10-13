Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCCF313267;
	Tue, 13 Oct 2026 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917176; cv=fail; b=Gn5xOvPa7Ez5VtLBLgB1UFBopmiHyKi6uG1bG3MkUgb7iFl0vqdmTo+qgkRbmTnG/JlaCuVyK7wwv/MbnDM52rScZFDxTaAGcKC4DRxRnpRnFaDkIH3RwxpZdJuw4+Uhd04DQmE8TxY3hBd5Ge0o3yehkVcvCVdRQrffgP/xnVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917176; c=relaxed/simple;
	bh=+AR/HyRgNKEI4apiRQX2VmYqRuCyxrkmgTei+9IeIqc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=shX1/BwSLhrl1rgFKLGz4b/HWPv96xAgH/1mdkbxTTQiQHlSZ4uOQxN9oayocblNXdMv422dxwjpfO5+0fVQhoML9doVcyp60lvBypxcl1eek7y86roMs8NC+HLSbTYC1BWcbJ+lhQ69Ak5G0tuWNhGGBVKHHooOg14QmFPi4Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewvSd0AD; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewvSd0AD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791917175; x=1823453175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+AR/HyRgNKEI4apiRQX2VmYqRuCyxrkmgTei+9IeIqc=;
  b=ewvSd0ADCuZ7rJCsUqmyFxU9ig2JoAn+bW+RPtR7OMKtikwAQteltmtx
   E8dAyVAu+Ur5os/GheoPcEFP2BcM7rPM5RHWBTJ8qx1IVLovSD7ZlKhwS
   5Ev+lvEr34OUbsAWIiuiV7fUpgvcsDU1g28W52jdXA0TppFDwFu8nEvA6
   RVeoPKKw+P0UZmmxJnSHYYmJhZFDLQ9x+mbTANT/IZQJyvN06cr2iSWAX
   j3CNmwJHAslTdg+hPC9nxvPccwCdGyY+if79JCeHovlnMtJy0t5ACcZuN
   F6whVu8ZD0msuBsPmDGLtlr8ouFNjutpb3D9G2Is2ylKPeVBaRnFf1lVa
   g==;
X-CSE-ConnectionGUID: TwHaUlhJSdqA50vCp338lQ==
X-CSE-MsgGUID: OdQHTXlsT5mCCeLIlHyHBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="685578"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="685578"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:46:14 -0700
X-CSE-ConnectionGUID: +oAZdtv2TB6ktxOifddzrw==
X-CSE-MsgGUID: 9aTrhuyQRxec4u62Dzn8VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1324942"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:46:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 11:46:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 11:46:13 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 11:46:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TY6meAeRrsXYbu739EHgxjt+LDiaHnZGOjghOjo2KylYzV1kcfCIdRQwoK/0jzOAiJDqzy+umlfrfaOeudnC4hnBKt53v9kH0LAVv+hcTXlPcyrwAoreJb9zEf+UByPOm7OVm1h9l9DrozQ0XthNGeCZet1LO8POt7UnlyGeVAx3+1Y5ijIGRZeCRmBnkSQrXQmjUi/0RbK3Q1lBM9JqCLFdFO0uN1lAbZiim/tsjYFbZ+vS/QryjodsVxYGWemG0KIvJSMA2ftBD8LQAs9BN4cARtNo1sxpoZf1Lpx6zBL4FIuZ0I+ZK/Lvco14kP0SQS+NGHP6d21tCxggc0kwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AR/HyRgNKEI4apiRQX2VmYqRuCyxrkmgTei+9IeIqc=;
 b=ypDaTjNMfbsi8GOFD06qBfcIsg0t9Q37mz8gMI1FHkY+ec4IugvQ65cR9OJw9yJFFv99e77U44sFmPohPwOhdr+mGRZbNTFMofsgfWPFKh3Z3Frc+DVnGfgOqSDcMnJZNfJrayx030tSn8CQdL8syIxALiCMWdmRkdfYPuhGD27uSxEVG2+cXwYFWnJ+TvUDmRJCnfTpLWj7DokkSJgIHwyPSdECBxdexzzqRyHUsVy4KdEfJPJz7A3Zkzg5nnlzlT0jpBiAJxHlqHi/zsYP+Eej7PyuZQq8k98EMp3N9urA3AcE2QCftkN1+ad8Td4IqQGXHht+a7zB5dd7JPkW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by LV2PR11MB719417.namprd11.prod.outlook.com (2603:10b6:408:413::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 18:46:12 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 18:46:11 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Xu,
 Yilun" <yilun.xu@intel.com>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>
Subject: Re: [PATCH v4 3/6] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Thread-Topic: [PATCH v4 3/6] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Thread-Index: AQHdWyhFTNJTz9rN10eK1lJZytMkobb7z+qA
Date: Tue, 13 Oct 2026 18:46:11 +0000
Message-ID: <6a3998e4e4f58995a0d78b5d69b593c2963b7e0a.camel@intel.com>
References: <20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com>
	 <20261013-tdx-module-ext-v4-3-de5ffac65470@linux.intel.com>
In-Reply-To: <20261013-tdx-module-ext-v4-3-de5ffac65470@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|LV2PR11MB719417:EE_
x-ms-office365-filtering-correlation-id: f7a3d7f2-4cb5-4105-83d8-08df295a40a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|6133799003|10067099003|18002099003|22082099003|11063799006|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: 38TB+5jLBOm0ff1fN+0sftSLwY6MUa4j+icOUlOTDeV3/RIFyud79R6ow6K+etlKda899oi8jRL9B0XUM6crrj4ksaRvYQb1uiSKZKka8VRrxDzOajb9UIjpo4E/KBsEctzvfo41rYxDCkZ/mRILgWj5cN0afPucJYed+jcZ+gowMFO9qZYnyWnfSJm7rO7igM0Ch24EWZXNE+drwzFQqIFJWiyBSoTpaiuUCRq0yhtHnCmicrdsutBF+jP/GabawfClIQndyEdcK32Oy4TlUd4gsBX0CvsHJXalvqDGH/so6VnTtqgslsO7zJo31qtq2eev2bQxd+akxQwVl5faq5ZoqZpwMy/p7E8GSAP3EsuCQbX6qODRNYaCSN07NHg2hbXeRSGHq7ulGXp2hTwANZagAJG7b+X8oOtAkKTJfMMb16xzxLbkrylKv7LBqXz7lC9s0M6GKZmKp6eCUWPGeAL9Crsy2YaJESFJesVJrXrNu/MbLqO5QnB7tS45uZXlcqVur/Cs+sAKEeJvfVJbVr/9SU1jbrMjiz6xPMKvTevtrIJfosJpWvmM9GC5BFzO7aiZR1GpSl6ExJkfA4I12rBVI+XO7CUz6E/ljRUkSpgTc53ja2/9ae4cokL+5UAc6J5um45CHUeCQtXLhNKLaX7ncO3auUoHeNGLpQvYo8eCBeD7jkFaFpBCJkJFe8tXHRRDT6Ijp6Bm/gMMx9pdfScj9+u+0wLNwLvbfhUlsd8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bS9TdW5waS9yazNuc3lmTWVnMmY2SUl4bTRCRE9kcExKSXRlbGtsS0Z2YUh4?=
 =?utf-8?B?REhJL1J3bEpBc2NyUy8wVUo4amxOM0Y3bU5oVWxKRi9SbUFKdEJ4NEl4L3pK?=
 =?utf-8?B?VklmTTVRSEZ3UnZJRWZ6YVZiMDdaVEZ1OUdaTVhDT1JGQmEza0JKUUg2ek1l?=
 =?utf-8?B?WFJ5VzUrMjFMQTdzUWJGTGVhRkJ2QkVxc2dlS1Y0ZUpOeEc3dzVNVEdRdWlP?=
 =?utf-8?B?R0hKQWhIbXZnUy9nQ3NEZTdlSkxjMGRuV3FreFNCS2tobll1Vi9YTnpuQXl3?=
 =?utf-8?B?V1FFMmtKc2NzdGhtYzF4WW15STRlWi9oRFExWGtQcW9UeFNYMGFNQzErVkc4?=
 =?utf-8?B?OU9ZQ1c5aDE3bEJ0TzlnUVduQTE1MEJoUVVRWm1lR0VaS3VWOGxWZG56VC9G?=
 =?utf-8?B?OUZPWDZHclV2eTd3MzQ2emQ3c1dadDVPbUpBSm0wellCaGhUc0RUWDYxZFc0?=
 =?utf-8?B?ZkMyanczMlpLNGc1QWN4WmEzWURXd2E1VWdzUUdKdWJMT3AzRjMvYWNhMW9w?=
 =?utf-8?B?NVYyaVQ0NytibDByQXlLVXNLY0ZNc3ZMQ3d0SFRDWTh3RDNtV3R2aUtpMlU4?=
 =?utf-8?B?RzJvOENWVjZpV3RLZ2pGbkc3dkdzZ1NSb2l5ZlhUMFU3Z252Ty9lYTZqVThB?=
 =?utf-8?B?N3ZINmZDVGZZSEpzaDk2MEJCcWJaN1Rra1RPV29mdnJPbEljUDRsZE5yMmk0?=
 =?utf-8?B?U1czeVBiWGxzRlg4QkxWNXFuTDJ3TGt2cnhESUkzbjJ1ZDVyL09wekFYN2RU?=
 =?utf-8?B?T3V6OW1pV1N0UkR4UUtvU3ZuYlpBbjd1Nk1XYUtFTDNpZEhmRWs4MHFocTRS?=
 =?utf-8?B?eVl2bGY2REhnVk5xcUFYU2pCdkVzS0FlaGszY2E2UTZLdUcwWXhUN2hDS0dF?=
 =?utf-8?B?eUppZCtISFVpaDdobTZwRENXaXYwNzJVWVZNOThwdFpuRDBnM1hEY2pkZFVO?=
 =?utf-8?B?enpFcUlIWGhEQlRHNGNBc0l0Yk5id1dKOVNOeU44YmRoY1p6OXRNaDUxY0Ft?=
 =?utf-8?B?K0NtbWd0TzdXOHRDR2FPajZlNmErOFd0M0crV0RidHZsWHRmanpNVkQ0TVJE?=
 =?utf-8?B?bnY2cEVHQ2FwSjZyWWVjMUl5Uk5hRDg2QXZKOGs4Sk83d2F4SVE5UFE4eUx4?=
 =?utf-8?B?L0FEdEk5WnVoRkRRRnlQYSt6MzZmMkx0c1NBbUpEbWE4WisvYXVhdS9kTTVW?=
 =?utf-8?B?V1VmdG9KTmxlcENUanNKeTQyY08wWFV6ZUFISFVIMFFMNFBBb1dDUnZCOURZ?=
 =?utf-8?B?eFFiSEdMeG40USsxVEtBTnBLN1pzN0Y0bDFpbWdqL3BsSi8vQTg0WkZrMmRP?=
 =?utf-8?B?NkRXZjlXMWpGV29KN2M1Z2VLdzhGWHFRNUtHR1VrL1FjOGRxKzAwSzRzWlgx?=
 =?utf-8?B?OXptSmRjK1UvTWNwVkhtUjdQNVlVbmtqSnRKb00rVjdMbXA1emhDd2h2MW5Y?=
 =?utf-8?B?SVo3Qk5odXJ5SUk1RUFyQWovWmlWeVFISE5Kdys2Mm1RclZ1R2VHb0ZYUGx4?=
 =?utf-8?B?dG16ZDVZMFkzVHAwSHhacG5pMEFyd2l3WnJLbnJJdTZ6UENPeC9DblNhVjhw?=
 =?utf-8?B?U21oS1ROQTl2NWozOTBxWkZNSkVCbGtqL29xOHAydEdJUmJWdFhYVDRDUTc1?=
 =?utf-8?B?MGFPYWtPT1hrZWswZTgrMXVrZnVEaTByOGpIV0FoWGt1UTl0bEVPZnBlV0N3?=
 =?utf-8?B?SWhxMzV6ajFRaUxtRzQzTGVGQWRyOS8wbDJObVllVFlUSGYwcE5ibEF0K292?=
 =?utf-8?B?S2JSZ2orTS9jMWpmMTRuZnZRUFFYU2NmVUZ5OHdETzEzVlNXd1kyMkY0QTE5?=
 =?utf-8?B?Vm1pWWUwNFh0MnBJbVloOXEyR3dsUjMySTBjclkxSXVWcUc2Z0hnUUFLWFpm?=
 =?utf-8?B?S0FpSHBmdXFpazNsSExEbml1YVJFUnI0U1VsdGZYQW9ZT01Mam4vdzNNTWtj?=
 =?utf-8?B?aHVDazBjb0FXU1YvRXdUcDFlaW80bFVmUllzbVhuRUlXa2JKT0d3TVpPUXRP?=
 =?utf-8?B?ZUc3V1I0SjJRNEpHc3JwWklXNG5PbitzMjNqUEtHZzdITE1mUEo4TDVwaGRn?=
 =?utf-8?B?RW5lNnU3SlZBcHMxV2QxbTVmcUJzZEdHOFZoTzZKNkdjYnhyaFFBNUVuNmlw?=
 =?utf-8?B?R2N0ZEFJcUh4RDBTZXBsV1N0Vm83dk90NkZHQS93TzdHNFJLNkNVVnV0VEJ1?=
 =?utf-8?B?bHBnVGQ1SUFiNmU4YTFpdnVOK0NvY1lwYTM4MURONTNHb3JZNk9PWVRxUmNn?=
 =?utf-8?B?VFMrRWhQUWNENEJ5RllPT2JGOTlpNTRKNzNhc1c0N1JHL2VKNDlObnRGZUcx?=
 =?utf-8?B?cTkzU3JGSmFEL0NGSjVJWGdRbTZjeGZ4REgwVURWTTVYekd5U1N2TUVTM2Qy?=
 =?utf-8?Q?W3VE6V4NCLcqxD+4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ABE2DB4C65FE84688D60BCDF8AF112D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ds4mN/ivwBLlDE8VDU8rgLRhSAugetxVxyOikH4em/cUDLmezSn98f43qbdv+XZ2NKT675YBmceWaBEL+koYvVuB6nL45jsnPKLiCg2dkO7Mh8AAsuRwguVfbDpzxNvhRVO8lvSyooZbD1WPV9n5IzzHWKxUwdfJN3KwJ++4+aTmc99S4gVcEe5MnBfzRElVao6wMIc39FMhOSMrmxMohyCUEUefh4GBxkeMPBFratXQT7i8ZttIGUMX2UV0BStGiUVSt/TnBvB6jHYZBkMh6e0sj+Ix10Ea7ZkTbx5H4bltuBQwELF/p7pztiYSucAmWVy7PzAX0GnVCZwnB53hLQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a3d7f2-4cb5-4105-83d8-08df295a40a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 18:46:11.7940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ORtsPPKwOXRL9HAAn1Cg4VMRNVhqKeCx2eIAneb13iXeac5Mk1heKLOsu+HMmYIHUgJ3LadEaeiSI+MfYZzdmJ8UPqLchuSO1YTDuvfFLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB719417
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTEwLTEzIGF0IDIzOjI4ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gVERY
IG1vZHVsZSBleHRlbnNpb25zIG5lZWQgbWVtb3J5IGZvciB0aGVpciBleGVjdXRpb24gZW52aXJv
bm1lbnQgdG8NCj4gc2VydmUgU0VBTUNBTEwgbGVhZnMuIFRoZSBURFggYXJjaGl0ZWN0dXJlIGlt
cGxlbWVudHMgdGhlIGV4dGVuc2lvbnMNCj4gaW4gc3VjaCBhIHdheSB0aGF0IHRoZXkgdXNlIHRo
ZSBtZW1vcnkgb3V0c2lkZSBvZiBTRUFNIHJhbmdlLCBzbyB0aGUNCj4ga2VybmVsIHNob3VsZCBh
ZGQgdGhlIG1lbW9yeSB1cGZyb250IGF0IGluaXRpYWxpemF0aW9uIHRpbWUuDQo+IA0KPiBJbnRy
b2R1Y2UgYSBuZXcgbWVtb3J5IGFkZGluZyBwcm9jZXNzIGJhY2tlZCBieSBhIG5ldyBTRUFNQ0FM
TCBsZWFmDQo+IFRESC5FWFQuTUVNLkFERC4gVGhlIGtlcm5lbCBxdWVyaWVzIFREWCBtb2R1bGUg
aG93IG11Y2ggbWVtb3J5IG5lZWRlZCwNCj4gYWxsb2NhdGVzIGl0LCBhZGRzIGl0IHRvIHRoZSBt
b2R1bGUsIGFuZCBuZXZlciBnZXRzIGl0IGJhY2suDQo+IA0KPiBUaGUgVERYIG1vZHVsZSBhY2Nl
cHRzIHRoZSBtZW1vcnkgaW4gdGhlIGZvcm0gb2YgYW4gSFBBIGFycmF5LiBUaGlzDQo+IGFycmF5
IGlzIHBhc3NlZCB2aWEgYSBzaW5nbGUgNjQtYml0IFNFQU1DQUxMIGxlYWYgcGFyYW1ldGVyLCB3
aGljaA0KPiBlbmNvZGVzIHR3byB2YWx1ZXM6IHRoZSBQRk4gb2YgdGhlIGNvbnRhaW5lciBwYWdl
IGhvbGRpbmcgdGhlIGFycmF5LCBhbmQNCj4gdGhlIG51bWJlciBvZiBlbnRyaWVzIGluIHRoZSBh
cnJheS4gQ3JlYXRlIGEgaGVscGVyIHRvIGVuY29kZSB0aGlzDQo+IGZvcm1hdCBhbmQgbmFtZSBp
dCBhZnRlciB0aGUgVERYIG1vZHVsZSB0ZXJtOiBIUEFfTElTVF9JTkZPLg0KPiANCj4gVERYIG1v
ZHVsZSBleHRlbnNpb25zIGNvbnN1bWUgdGVucyBvZiBtZWdhYnl0ZXMgbWVtb3J5IHRoYXQgd2ls
bCBuZXZlcg0KPiBiZSByZXR1cm5lZCB0byB0aGUgaG9zdC4gVXNlIGNvbnRpZ3VvdXMgcGFnZSBh
bGxvY2F0aW9uIHRvIGlzb2xhdGUgdGhlc2UNCj4gbGFyZ2UgYmxvY2tzIGVudGlyZWx5LiBUaGlz
IGlzIGEgc2ltcGxlIHdheSB0byBhdm9pZCBwZXJtYW5lbnQgbWVtb3J5DQo+IGZyYWdtZW50YXRp
b246IHJlcXVpcmluZyB0aGUgZnVsbCBzaXplIHRvIGJlIGNvbnRpZ3VvdXMgaXMgbW9yZQ0KPiBl
eHBlbnNpdmUgdGhhbiBuZWVkZWQgYnV0IHNob3VsZCBiZSBnb29kIGR1cmluZyB0aGUgYm9vdCB0
aW1lLiBQcmludCB0aGUNCj4gYWxsb2NhdGlvbiBhbW91bnQgb24gVERYIG1vZHVsZSBleHRlbnNp
b25zIGluaXRpYWxpemF0aW9uIGZvcg0KPiB2aXNpYmlsaXR5Lg0KPiANCj4gVGhlIFREWCBtb2R1
bGUgcHJvdmlkZXMgYSBtZXRhZGF0YSBmaWVsZCAicmVxdWlyZWRfcGFnZXMiIHRvIGluZGljYXRl
DQo+IHRoZSByZXF1aXJlZCBtZW1vcnkgc2l6ZS4gVGhpcyBtZXRhZGF0YSBpcyBwcmVzZW50IG9u
bHkgd2hlbiB0aGUgbW9kdWxlDQo+IHN1cHBvcnRzIHRoZSBleHRlbnNpb25zIGFuZCBpcyBtZWFu
aW5nZnVsIG9ubHkgYWZ0ZXIgdGhlIGFkZC1vbiBmZWF0dXJlDQo+IGNvbmZpZ3VyYXRpb24uIERv
bid0IHJlYWQgYW5kIGNhY2hlIHRoZSBtZXRhZGF0YSBpbiB0ZHhfc3lzaW5mbyBhdCB0aGUNCj4g
dmVyeSBiZWdpbm5pbmcgb2YgVERYIG1vZHVsZSBpbml0aWFsaXphdGlvbi4gSW5zdGVhZCByZWFk
IGl0IHJpZ2h0DQo+IGJlZm9yZSBhbGxvY2F0aW5nIG1lbW9yeSBmb3IgdGhlIGV4dGVuc2lvbnMs
IHdoZW4gaXQgaXMgZ3VhcmFudGVlZCB0byBiZQ0KPiB2YWxpZC4NCj4gDQo+IEFJIHdhcyB1c2Vk
IHVuZGVyIHN1cGVydmlzaW9uIHRvIHJldmlldyBjb2RlIGFuZCB3b3Jrc2hvcCBsb2dzLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogWHUgWWlsdW4gPHlpbHVuLnh1QGxpbnV4LmludGVsLmNvbT4NCj4g
UmV2aWV3ZWQtYnk6IFRvbnkgTGluZGdyZW4gPHRvbnkubGluZGdyZW5AbGludXguaW50ZWwuY29t
Pg0KPiBSZXZpZXdlZC1ieTogS2lyeWwgU2h1dHNlbWF1IChNZXRhKSA8a2FzQGtlcm5lbC5vcmc+
DQoNClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5j
b20+DQo=
