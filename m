Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395A739D6C8;
	Mon, 20 Jul 2026 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572462; cv=fail; b=jLGSvw3VBAq29kb8x0EnqRdwMZYlGzjGPzo0mhvj4JIiv1bwJp2CFfI7ByUjJpChM2BsZsCbkddw0NAKbYExeOwOwZaDGebSHFRCMGrgkn7FcQJmtQC5F/iEng+H3gAztAjnOE5t20PHOIvf0btbyC0LZemeyqTLqJReC9Bz2pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572462; c=relaxed/simple;
	bh=nGmiWURkazbx8rbCwoINGGMSPNFoFOruikO7IX0K2kg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GNqoLZNT3R0EUszDWMjqL/0i4rPPaVF9tnI8w3BvBnGKz3S0BO2I+JxyBd/IeYjky11K8gXEgPcditdh+H3fI88Esoyv6+srvC0wT0Mv7wOIJUek8TaDJoo8KSSmW8GnKZk1SCzTXfYAouqo7+zeGQYBnZy32rL53MXiKGcja8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKu9Y0g1; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKu9Y0g1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784572460; x=1816108460;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nGmiWURkazbx8rbCwoINGGMSPNFoFOruikO7IX0K2kg=;
  b=SKu9Y0g1t4IO6rkXkKaWUCiJkC9FDGCSpSdwQwlkh97g8WrtsXH5vVPa
   jIwpf/tzet7MdGA5u52mS9+ZtwyjtvxUowazemD33EnBKJO/GWnxobEFG
   i30Ff80BOUvsggGRW3EUVnBJa0yzGsavDMvBknE2VmZKq3zF4FJc8KIWp
   Hle6GgCVQFXVLqTrpcPlesypYIouOBU59JBRRkjNa0acfzymWWsUBF278
   DPwlXLM0frhzCAukoXcySAjV+x/mYQMvSStCfQpdVQpzbmrp7sm0Nfaez
   MhqaHSAKurQU7P5TEYncMXT42svf6z7773o5vljmopRCn9TutLp5jkxjl
   g==;
X-CSE-ConnectionGUID: QsmeZnOZRgiroWPRFCT+kA==
X-CSE-MsgGUID: CPwMIA2KQiKcWD7l7iZNxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85257889"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85257889"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 11:34:20 -0700
X-CSE-ConnectionGUID: pKOMsFY5TraeCL0gfBQQpg==
X-CSE-MsgGUID: ziRqj/qkQqCdGPT168Du+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="261805427"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 11:34:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 11:34:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 11:34:19 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 11:34:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJonYHEzG5ab6EL2JJkkAHfUmnM+TaiBdPnhGTD7xJAoQ7ay9ql/5FNjsOA9x/wQS9TuFdc5df5vZ1A/TaWZWEGDYaUk2jOeOZddCoo57/o6LGQgw+xGDktRgVBvX4LfBl+hZmaJvtDMwA+xvBJH8Ag3a2p2FNPv2Q2O7HomFZdwngVEfBNFLnYO+7qR5b+A9lPcBY3EniCSQJhTd0CWZcEz9H2oCMr82zScYAnhYxnxWT0cRQQkUMiPbXaErTkSBaBfjMeFHyBylIWeufgYvU2amg2VM7Y62Im5VHgLcMVgQgSACIwe+u6jh74UrFj7JOH7U2hrK/ysW/WN4hlhow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGmiWURkazbx8rbCwoINGGMSPNFoFOruikO7IX0K2kg=;
 b=Nq128MQYty7sTXhWGHE995SfiXf4/48cMpoowDAjIkkrFg9svE53LyZBFsyShWbaZGW55/UAJ8AyA7gJ1y9kd8QnZwlKJNTy+UhgvCPgGlliNOND4SxBkBnpYuQ/DKOU5kZrEaQ+udTK/Kb37n9M5bNXi98SfzHc49QK5kbwruokbT2YzY8h8kSXCrDSVIyMhkJkrbD4wdMXURVXFoJdyB92Sjajbr30Emt2L+xOtj+zXouWLCkc55Mr34hQPxU+O4X4wvZzJ7dIG/mAr9XLMPvgfylRz6e7I4ZCkf+rbodoUYKC+jL7DooSrdnRmcNvAWAcodR4c9OvGSRGXA0w9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 18:34:09 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 18:34:09 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Wu, Binbin"
	<binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v7 09/11] x86/virt/tdx: Enable Dynamic PAMT
Thread-Topic: [PATCH v7 09/11] x86/virt/tdx: Enable Dynamic PAMT
Thread-Index: AQHdFlcfgKwTJHhexkC7ZJEpYB14krZyhJoAgAQ7awA=
Date: Mon, 20 Jul 2026 18:34:09 +0000
Message-ID: <7660627be8046a2d568a453d4526ea2c3a8dce1b.camel@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
	 <20260718014500.2231262-10-rick.p.edgecombe@intel.com>
	 <20260718015627.21D9F1F000E9@smtp.kernel.org>
In-Reply-To: <20260718015627.21D9F1F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA3PR11MB9136:EE_
x-ms-office365-filtering-correlation-id: 4d5162a6-2407-4b60-5925-08dee68d7d04
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|38070700021|6133799003|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: gLyda7CIA3slQzXhLf5Pt4QEOkNcZoXZbONNFcf3l/e7gWLsW7QFQvxh+J7GW0xna0YpgZuF6pkaO6p7VxFVT1f3j8gP/03LuZNWjLJdAAF1g5oVsnrjlOIPhPmei/OlZiTJl1Ga1cavXXs/jkAoAOAG1oFdDloELNQ+PfT7FM/NJiqR0yTcp7nBBCaETh3oLXjGHsVP5rZjpyyWWcSffnp3kLXB7m987hNsc2VWmBdFJutKuGFApcMQws15/B5Ldg/h7CMJqlftfN/jUIbwKmYZ1dI7FWVX9cnQr+B7qZOtTv9sFrWrxFuHqd3UNG90QMIkkQ61FDV8iGtDPlWw3YIQkFmD85ph+2Pi6W5aoQ5LDbkL4NkaImIVy5V5+q9DS0dsrCQ8YPsQZrn3HBBV2uxxuLm1U2V3VFUISFtii3k3rTC6Klw+WaMiOIttW3HM7ZX6hvDKQq/Z1fUshfHfjBv8MNhu+OmviIIf2OjhbxIsda/RHBJgSepH3PWHAclkQGYr6nzcbf0+XZ4zzd7sFPzGBZrvmxAprTK4NfBX0CpAr4nB6XPjGwwj0H9/hP91EHZvonK9bAa7zKX4zWBVCScIBUIZ4evfZlI0oUHcvP1pAgWIZ0P6OeyOfigfFAIvKu9t52Wlaxd+yucoTOUP8yR3FK13hzKIbCpAqdx8AjPqha7Kl38g9diQ58n9X0eNsIOHqUdvzTd/tPCCth6rhd0/eJQEfLTPDOP345PXXZ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(38070700021)(6133799003)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzJ6blo2OFJBSXZBMXZFMm1Mb3pmUG1nZ1l2RzVjcWZDeXgvS2R2MS9kNUt2?=
 =?utf-8?B?V0o3aHVnY3BCRmp6amNxWU04TnpOdXpTUFJEODZBMDhrVEpkNG5XWmhMU2M3?=
 =?utf-8?B?NEFxcEkreTZlcG5pV2txaVVtZlhuUFR2WCszYmhsMVdqQnVSWkpFczY1WHQ4?=
 =?utf-8?B?SkN6eVFDb2VjNDVtajhlV2dGWFZCaExVY2E2M3RNUDlMeUJBV1htM2NtUS8v?=
 =?utf-8?B?YjhabDNuZnNmL0FnUERhNEFIQ1c3VE9VMUVCeUg4dVJwNU9ZZFRNN0g1NTVa?=
 =?utf-8?B?L3o1ZFNLUjY4VDJzYTdUS09EWlppbktKVkgvdjlOa0MxSWN5OGJlcHd0N3dK?=
 =?utf-8?B?RkdTSkRkdXBFY1BsamNQTzVaUS9nRjdEaU1INThCb2xpNExtWmY2Z1BzTjUr?=
 =?utf-8?B?cEJheEV4ZnVQWm16Y2lXcjZzNnVNaHpyT01FbEdVbWtFS1Qrb3psRXNEN3g1?=
 =?utf-8?B?Y1NLZDNycWVuWEVuOHVtc3F2MnNRY3JhelZGSnRHUG5xYXNHMmxxN0RDVGk5?=
 =?utf-8?B?Uk4rdkMvTzc2QVZWSlI5L1JvcjNET3BEeklLNmNzekpJTTFOcHByQnFmSXQ2?=
 =?utf-8?B?RlNMOEgzcEFqdks4WTRhQUdYKzNzSVVnSkpoMVZDNDEvZnlzYVNwcm1iRDdq?=
 =?utf-8?B?WlZlVUtBcXBXdXUzR0VjOXZUNmJ3RmhIbGdVUXVibFBvcVBLSy95Z08vOHlL?=
 =?utf-8?B?NnJYTC9jd0R6Q0Z6UnZMWnpRaEhKNm9kQWZjbmgzRldiNXV1T3l6aVA2Sjgr?=
 =?utf-8?B?aldCaTNvTytuZVcyL2pRTUlIaUNydkZ1a3dES0t4R1RQZzZCNnJzWTV2bkJ0?=
 =?utf-8?B?aEw0cnBKYWZXTWJIU2trdzgrSC9MQ3ltZHlMcGZzOVpaVmlKYnErSyt3S0xJ?=
 =?utf-8?B?Y2JTWHpKS3lrNUhUR1V0Rnh0SjlJalpZTS9jSXd6UzcyVlo3enJVOG1UM3py?=
 =?utf-8?B?SlpmN254OUg0WThtUXlSbkthNUFkc3RhKzJsVlMvR20zTWJoRUczbytVQ09L?=
 =?utf-8?B?dzBnNzJYeHdiTzhZM2U2OTR1K24rZjY1S3V5WVhzN0hidTJzTTd2NWl3K1NU?=
 =?utf-8?B?NkIxQTViUStLMmh1RElDNVB4emtTeEdBU003djdnYkJydFRuNGpWSlpJZlJ3?=
 =?utf-8?B?eTBnbXpIbGp5LzAxYzhyVkYrSWEyOWhNZ0ZNcmhZTkhNQjhENjdTellhenB4?=
 =?utf-8?B?eFd4anhKQjJDMzZ6TmUwRlJudmovaTllblJEZnJYdVhTdjhWdXBGYW9KRk1m?=
 =?utf-8?B?YTZJZ3MxcmJtMG92bEFJNHduQ1U5YWtNZWpUSWhPcmdUTk4xamJWMURnTTJN?=
 =?utf-8?B?cmVDamRQSHJCcG1IenB5ckN2TDlCSTVIYmdONWNEdWRWL1Z1N1ZwdkdraGsy?=
 =?utf-8?B?enJSSlRaYStodW5LeG9EN2loMzI2anpPL2J5SFp5bDE5U2E2MU5tUHJEOFI0?=
 =?utf-8?B?MEs5WmlPVWZjRUw4QkoyeThmZXBmTzdqbE0yeFQrMW5KdnhTMElvNWpNbjZR?=
 =?utf-8?B?aXZqdFhqRitWL3Y5VFk0d2RkNmF4RXRvd0ZBamVDclp6elFHa3p1NTVFVmla?=
 =?utf-8?B?QlpNYk8xVTZ4QmZnVGpUdzZhQkc3RFNoRVRGbVpYSlhvYmlzUm1jVHlGd3VY?=
 =?utf-8?B?YUdoNWNXTzhtaDRWQW9sajFRdG1JMElWOC9pc2hUSXF3ZTVML2JrR2Z3SnRz?=
 =?utf-8?B?S0FRN0JLMXhSdElKVjJhclo5V2picVd5TlpkeFlMTlZOSm1ubDhJcEp6dzVz?=
 =?utf-8?B?Y1Y2UCt4MDlQMDNFeEtDYjBadlcxNUtHOXBROWsrNW1WOGlzTkRTZ3h2Wng0?=
 =?utf-8?B?clNvd3MvZDBXNEEyVUQ3cVZicThkem0rM25QVDcwSEZxc3lYblFUZjlwck5x?=
 =?utf-8?B?Zkk0Q2g2ZUtqQ0l4a29nRGNUN0xsNnBIZzlQbUJhdGNUaVlCN3Bpem9OdWdK?=
 =?utf-8?B?K2hMOVBrbDVvZlFoY2pHN2g1VW4xRVYxYnhnWDRFQnNYampnTGgxVk1zVHN4?=
 =?utf-8?B?ZWtzMDMwUTlxSEhhR2RVajBjRmhxVFFoSjZZSGRDdmxUS29GTFZma1BmbzNF?=
 =?utf-8?B?Y2I2ZklMVEcwbDlzYmVlMzVQZjN5dTh2d2JmL1RBNWQ3TzJnbzNUaEVvdkNI?=
 =?utf-8?B?dk14Q3Z3Y0E5dXVqQVFBcGVQaVREYm1GNXNyanpMdDRlR3M5Wk5xS3hLVUxT?=
 =?utf-8?B?bS9vVkhJaVJ0VXR0UDhWVExacHk1THZ6dnBvVVp1RjBXbDc5b0VvVlN4UmlZ?=
 =?utf-8?B?aXJTL0UvcEh0OERuK0ZDWXZ5MGlRZXg5cmI0bjFtcnJvaUJvL2dmUHVoMXhj?=
 =?utf-8?B?WUsxYmJjU2J4N0ZEUzhMdzI5bmk5ZEFmZ1NzNVBFeXBKVm5Sdit5NHdQRVBL?=
 =?utf-8?Q?4vY428tivSwDj6Pw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <330DCF64FF333745B5476C2A7D3C6414@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tLicN29h0IFuswS5hmicVZXuMoFi7y5xfkugRh283dgfd3sv3J6t+hT7HRnKKthPNZsM5NwAnxEFF9KzkhW08Gnp80j+MuTUPLviaOD62AQXRAWo1fd+hpP/8CY+nrF7Kk24cKF+aOj/EbGXC0pkjMwAICWUGkD19WlJzCn5NM2cNgX42eagn/hkWytnwL83tpNYNv0J6AOD1rXIiu24+/7sxTUyLdsZsZvLsKlrvisPZxO/Ksq3GMqoQtQArU2MVqTFN0d5iYCSb4kOOO25HIluz2P1Gqbi2MBq0f04ZKPtH/fkCSi6ULZe3zdtLDTk72bCGdFPh1/Vpd/nj7Sssg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5162a6-2407-4b60-5925-08dee68d7d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 18:34:09.5377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0wIWPIKYnNMT8DLdPZGdzrgOo4ahomiftm44ZZXKosaZvElxly7dyrzLag4Dw7BORCkpC0//nZX+0cCxzMdDk50krl7PV+XUPL9fxzaxhFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9136
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTA3LTE4IGF0IDAxOjU2ICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiA+IFRoYW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24hIFNhc2hpa28gQUkg
cmV2aWV3IGZvdW5kIDEgcG90ZW50aWFsIGlzc3VlKHMpIHRvIGNvbnNpZGVyOg0KPiA+IC0gW0xv
d10gVGhlIGdsb2JhbCB2YXJpYWJsZSBgdGR4X2VuYWJsZV9kcGFtdGAgaXMgZGVmaW5lZCB3aXRo
b3V0IHRoZSBgc3RhdGljYCBrZXl3b3JkLCBwb2xsdXRpbmcgdGhlIGdsb2JhbCBuYW1lc3BhY2Uu
DQo+ID4gLS0NCj4gPiANCj4gPiAtLS0gUGF0Y2ggWzldOiBbUEFUQ0ggdjcgMDkvMTFdIHg4Ni92
aXJ0L3RkeDogRW5hYmxlIER5bmFtaWMgUEFNVCAtLS0NCj4gPiBjb21taXQgYTVlMDU3MDM1NTcz
YTE5MWE4ODc1NzJkYWNkMjVmM2ZhYTc5MTEyZA0KPiA+IEF1dGhvcjogS2lyeWwgU2h1dHNlbWF1
IDxrYXNAa2VybmVsLm9yZz4NCj4gPiANCj4gPiB4ODYvdmlydC90ZHg6IEVuYWJsZSBEeW5hbWlj
IFBBTVQNCj4gPiANCj4gPiBUaGlzIGNvbW1pdCBlbmFibGVzIER5bmFtaWMgUEFNVCBmb3IgVERY
IG1vZHVsZXMgdG8gcmVkdWNlIG1lbW9yeSB1c2FnZQ0KPiA+IGR1cmluZyBtb2R1bGUgaW5pdGlh
bGl6YXRpb24uIEl0IGludHJvZHVjZXMgYSBrZXJuZWwgY29tbWFuZCBsaW5lIHBhcmFtZXRlcg0K
PiA+ICJ0ZHhfZHBhbXQiIHRvIGFsbG93IHVzZXJzIHRvIG9wdC1pbiB0byB0aGlzIGZlYXR1cmUg
d2hlbiBzdXBwb3J0ZWQgYnkgdGhlDQo+ID4gaGFyZHdhcmUuDQo+ID4gDQo+ID4gPiA+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgYi9hcmNoL3g4Ni92aXJ0L3ZteC90
ZHgvdGR4LmMNCj4gPiA+ID4gaW5kZXggZTMxYjYyZjM2MzAwZC4uNjk4MzRiMGQzZTYwMiAxMDA2
NDQNCj4gPiA+ID4gLS0tIGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ID4gPiA+ICsr
KyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYw0KPiA+ID4gPiBAQCAtNDcsNiArNDcsOCBA
QA0KPiA+ID4gPiDCoCAjaW5jbHVkZSAic2VhbWNhbGxfaW50ZXJuYWwuaCINCj4gPiA+ID4gwqAg
I2luY2x1ZGUgInRkeC5oIg0KPiA+ID4gPiDCoCANCj4gPiA+ID4gK2Jvb2wgdGR4X2VuYWJsZV9k
cGFtdCBfX3JvX2FmdGVyX2luaXQ7DQo+ID4gDQo+ID4gW1NldmVyaXR5OiBMb3ddDQo+ID4gU2lu
Y2UgdGR4X2VuYWJsZV9kcGFtdCBpcyBvbmx5IHVzZWQgd2l0aGluIHRoaXMgZmlsZSwgc2hvdWxk
IGl0IGJlIG1hcmtlZA0KPiA+IGFzIHN0YXRpYz8gTGVhdmluZyBpdCBnbG9iYWxseSBleHBvc2Vk
IGNhbiB0cmlnZ2VyIGNvbXBpbGVyIHdhcm5pbmdzIGxpa2UNCj4gPiAtV21pc3NpbmctZGVjbGFy
YXRpb25zIHdoZW4gYnVpbGRpbmcgd2l0aCBXPTEgYW5kIHVubmVjZXNzYXJpbHkgcG9sbHV0ZXMN
Cj4gPiB0aGUgZ2xvYmFsIG5hbWVzcGFjZS4NCg0KU2lnaC4gWWVzIHRoaXMgaXMgdmFsaWQuIEkg
Zm9yZ290IHRvIG1ha2UgaXQgc3RhdGljIGFmdGVyIGRlY2lkaW5nIHRvIG1vdmUNCnRkeF9zdXBw
b3J0c19keW5hbWljX3BhbXQoKSBvdXQgb2YgdGhlIGhlYWRlciBpbnN0ZWFkLiBUaGVuIGl0IGRp
ZG4ndCBuZWVkIHRvDQpyZWZlcmVuY2Ugb3V0IG9mIHRoaXMgZmlsZS4gRG9oLg0KDQpTZWVtcyBt
YXliZSBzb21ldGhpbmcgdGhhdCBjb3VsZCBiZSBmaXhlZCB1cCB3aGVuIGFwcGx5aW5nIGlmIHRo
ZSByZXN0IG9mIHRoZQ0Kc2VyaWVzIGxvb2sgb2s/DQo=
