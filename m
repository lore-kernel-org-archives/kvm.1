Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF495397E68;
	Tue, 31 Mar 2026 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951208; cv=fail; b=f/pfnbFCrzvwpFYbSjcrAunqDN4ctKzDlpkDnhvrz949jDSDP3FSC+VFJT2ye2hDbSCOcIFrLQu2NPZZaYetGWc+i3rpPjk1Mm4B36IUvfQIWMlKA5pHBZKygX6oPCfrWG++jYfsmYH6LEBYAMuL7wP00rTLQNovVl96ewax2Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951208; c=relaxed/simple;
	bh=MXHL7coXv5ONenRYI28CHDljtFpMy5vcYvtNGYup0Ak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pa6WeUQFbnTYKPRZS+XM2OuJRMT3BL4UhnzpBBNWmFiG5CyqoNyTNEN3/AT6l5lykGASTDkGu8oPPoEAiam5CSkZ/yETDMlrLpRJ+PebCSMtjXEO7hiCoSw5bVpPrHTmJb+vB8kZ2KaM34Ku8IBYATfmMJdl4IQ1t3mmIrK+Sw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMmgRAPo; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMmgRAPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774951205; x=1806487205;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MXHL7coXv5ONenRYI28CHDljtFpMy5vcYvtNGYup0Ak=;
  b=RMmgRAPoYHEh3VZWj6VzxTNeUkXcxRtTlfM828DeXbgG76XYEgz/9m3E
   JgbEmt5kgrSsDZfT5/nc5nQLvaZv6HIcGQst14BzeTrDMCvt4nxsK4vDo
   M6pRaO2Xv/PhJADQL2NNmnZFtpePI9sedzW3OPM+2jLhaJN7yxWB35wIf
   sK2s7SW+4vqelNDU16qPOFZ3b0D/3wKwsRdWRafeywNPJOKGOuPEMOfcQ
   PJlcxUei3MTKze9YH/P5FNtEAO/xkvUmUoIVmBdeD31Ea+q9Ei/atyYyY
   ZENQ/Zf9Y3xA70CSqHRWJr1O08Mz4Ha4B/0UMe+b5ciURjS7v4wAPuCoM
   Q==;
X-CSE-ConnectionGUID: r7kVVIjKTRiMpa1Qg4jiDQ==
X-CSE-MsgGUID: d8UT0S6dTQGDQpUX8yzOrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="74992150"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="74992150"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:00:02 -0700
X-CSE-ConnectionGUID: Eb/s5VcWTpq+YX/sLARZRA==
X-CSE-MsgGUID: DZvoLsbeQum3qymY1PzWzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="264258792"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 02:59:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 02:59:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 02:59:57 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.15)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 02:59:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgkR1vdXPHxkJC+ZhBpz3qKcoUMSbl8f/25nLNwrkJFcLorD6/vnUbPc2s5QFsn4lnIij8kfLZg70roNUnFiQlcgoDaPOaqRhzqJGmEJ202LoGzoK58C4FS7RsvVAZE/Uny/E+vdQHYin9qWLWAd+QKFKdyEp5flif5PLs7ddbEBR6lz9mj5CuTmlnUlGSA8CPPBjUt7qY49k5HvBA7psjk/1bfdCaVWDmvaxpSfHirk6v/SoYTrXTxZh5Lu/PFv6Fw0dcglxSmI7l0ZQkxZka/f/Op5Ux0dv6qNbPfv0oOjCdbjalRjLnLn9ifZIG05IrvaGwhIHhUe7yIurx9Uag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXHL7coXv5ONenRYI28CHDljtFpMy5vcYvtNGYup0Ak=;
 b=Z41nlLPIm5vu4fzj9OUwHAK4JD7gBbekDzpj3KFx/DJxiXrHpXWPvmE0Iz3UEd+fkzFWRAGIKVVV7ga8ssX+SpWzUEXAZDMYRW+l2Z9Anrq+Nz1zE6BZvCcdFZuQU1Qc80ltz4g0T7fcovRSKi4kC8r7bi+eclcvZYn2D+2CGd6QmX2bN43ak7WHRhg1yoe95ZWLwBhDAivIQlFHEgKYHEb/It0Dk2lJqdTMzqsvYKA5j/mbZCj2eVbI0nvMQqhtH/fG1C0Kcf2GVBT07b5fuHsRUpgCfc6ld6G70BUS9WHKQbKqRON+4LgJYyKrqHOxR0+SzZ6NlZrzcxzlkKIIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SJ1PR11MB6082.namprd11.prod.outlook.com (2603:10b6:a03:48b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Tue, 31 Mar 2026 09:59:54 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Tue, 31 Mar 2026
 09:59:54 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>, "kas@kernel.org"
	<kas@kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: [PATCH 02/17] KVM: x86/mmu: Update iter->old_spte if cmpxchg64 on
 mirror SPTE "fails"
Thread-Topic: [PATCH 02/17] KVM: x86/mmu: Update iter->old_spte if cmpxchg64
 on mirror SPTE "fails"
Thread-Index: AQHcviZZFnrZqGY3+0mCqCraMGJG57XIaneA///3jwCAAAvogA==
Date: Tue, 31 Mar 2026 09:59:54 +0000
Message-ID: <9d1078b85571e7400905217622b5aaf2ebd6eb84.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-3-rick.p.edgecombe@intel.com>
	 <49cdf35c32e064ef5d6ca24bd4bb9d8b26bc2202.camel@intel.com>
	 <acuRGgIEeXZ6ng0h@yzhao56-desk.sh.intel.com>
In-Reply-To: <acuRGgIEeXZ6ng0h@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SJ1PR11MB6082:EE_
x-ms-office365-filtering-correlation-id: 54b3fa6a-c280-4464-d540-08de8f0c4202
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: ndyLdu248r7yb2+NvegDxU2g188mZ999rhs8L5ZBfaJpbcUos6/286Kt+4369NiTUoixYs0xljsSb9EQzE+/3I8iIjsEGujZhH3qLpfGzBwea2Ua//PzSc8sVt4E3OvnRoByQ9vchOq3tsED9J5p4nidU3kA/mkXy5/dWMFvnRfulJI+PsrRRhP2BnQmeYe3/FI2AwoUmSWv7S0kM9hgap3jBWEBXMoW0R7IHn4KPggGEELkvA4fr45NfsP7Q+ljbM0Wcw/JnOzQckr+GvZRBOqzmkE25HsH0wrWStZuAwLnIZvXJ/UIqwkrudJSGEQufJVhqESLxZqJLYOGdVWCMe1fGClSU2M3VJXEKw59AAuG8l3nW4d2FvVSaYfcLeNXtTWPFr1xL9VOe8XDWMUtL8iLZMlHrwO99fXl6f2T6ZjkMCPjiGCR1k8ag70rglqVGqrutM4Rbaaj1VqHFkeGwya9CssskGzhL4tTiSevdhggi8UWyQDZPrfhidCKOsO8ma7sjCG5EsT4/IiulrjDslkmcLV9xgTxqOTQ6JbpkULNh9AbjPwJSDV1jn87mjSkenpu7FQg5htHR0URPVBuzMDaRkshKByRQD73IPumKOOcFDnKOZg3CN379qXpbMC/5n2cdTKIlB/XrQCd9Lk+QNk3XDCAHLTX+ZwPeHVz2ApxQ5coT0/aLw5cMWnitRIiKFAepmjwDTfYSY2pac2NapiR/BWIMYS/T62xCUA7gqBLJQOiFeEw0aiunLv09PCKzo7/SZ1hnDVcfkbA20zrjNU49V+siG1PL+G47s5yjH8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEpOQ1l6RXlDN2MrdU1idFh0dGpyQ1BqZWh1amlid0lGUW5vOG1obmlZYzhX?=
 =?utf-8?B?UG9Wd2RtcUxIdFQxbnF2a2xBakxrTHRPcDVyRUhEbzN2SC9hMnE5ZjNUeFNG?=
 =?utf-8?B?d0FSbzhYeWhmUFA0VTdmb2tUc082ZGxtUFNpeXJyeGpHQWZJeGZMWE1NNjFv?=
 =?utf-8?B?bnIwRDhjU2ZGWHpmVU43aEpHeHVPMnJ6NzJDbmUvektTQ3cxL2V3alhOenY5?=
 =?utf-8?B?ejFoK2R1RUxzdUNqZFl2NTRsS0ZvMjU2WEJtdVlJRnFXZnZnYXl3bE0vUDZ2?=
 =?utf-8?B?cnRlN3hVNHFrRVo3VmtjSUZkcGx3VjB1aEtERnBnbklKS2pYZU5nT1I2TnlY?=
 =?utf-8?B?cmJnY1hGbWx4T2lWdE1LYTR0MUtvelhudU81MUhQQ1lueFk3cU5qam16bk5r?=
 =?utf-8?B?Y2s0M3ZFQUd3WUNWeEhveDBtTjVYRExHVDBxdGcwMkJEVlIvRVZkZWt0T2pT?=
 =?utf-8?B?TGZWSDl6cTdTTHA1NDVWK2NQWEQ3WFp4VmlBYytzbFIwVXRhbkpsK1NuVWFi?=
 =?utf-8?B?WFJScTRveGhHdmFyRzBzaE9icytDZituaTRZbGFWb25aYmpYRllnZWUxM2JZ?=
 =?utf-8?B?eXVibElMZVk2bUtaangzUHVBR2x5YTFyNHlNTkZHdzNGaFROYWVHZDEweDlB?=
 =?utf-8?B?VmJncitEVU5DcU04YWZrN2o3S29iUVdNTDBxYmJ5SVZPRzFSZkE2ZFRzczRW?=
 =?utf-8?B?SURQb0c2WmhySnZKVjlObkk0bjdBY2o5WDRsWkxGa0oyQkNaZ1MrQldlc0pv?=
 =?utf-8?B?cDhBNGJxL25WSHNlMk1FSkNKdFNmOWZaeHVZVzVFK3F4THlrU0d2ZlFJSndU?=
 =?utf-8?B?M2VWQklyYTd0NTNCZER1Z2FSdEFnNzcvTHU0RkE4RkNRU3FPMXpvdGVReVB4?=
 =?utf-8?B?clZHMEZqMFZEUjVzWGNLV25xNHk0Y2pyMGhmT09ZeGtwWHVnZ0gyNXp4aDBn?=
 =?utf-8?B?Vm5pN25mRngxMU9kNHJ3bmpDR2pGVHV2VmRvTHlTazFtcDNWZ2c5RW9Ndlox?=
 =?utf-8?B?MVFYRmdrcXNFbERLdVFTcWU3MzlSQW43bW4rM1V6RkRpSFRzWURjYUVQL2d5?=
 =?utf-8?B?NmhFWnQ2ZjQwQ2NRWW15REFnTUZKN05yU3Z5c1pnVmJ2UTVid2lxNW4vbmRI?=
 =?utf-8?B?V21EeGx1UTh5eTBMVzczS1c4Zlh3UC82emJzY2xrYzlIU0FkT0FNbkpKQy85?=
 =?utf-8?B?K29sUk5ZbG8wRG50OFEyc2loKzZIeTZGaEdZZ1RzVmM3cGwydHJmY2ttQXpM?=
 =?utf-8?B?bTMzTEJuVW1XWDQyUXdyMjB5a2pFei9ycW1RVjJYdmVWc0tZa3NoY3Z5ZEFl?=
 =?utf-8?B?ZEg4ZEoxL0ZPeUlTSU9POXNjM3JZZVlSRHBTcEVYYVVtMFVheVV5a1VaWTBw?=
 =?utf-8?B?cWIwdVdsYXNobS9BQnVDZS9OTjlYMDVqY0V4SXRvNGJlZ01xNSt2NGpIcnhr?=
 =?utf-8?B?cHA2K3NUSDZKcWRKTzBYRjlkakdzVFBWZVJnMmNqVysvVm5hNERtL0dYay8y?=
 =?utf-8?B?QTNINXNrandFajdhS2s0REtaOXhwRC9Obmg3ZWNhd21Vb2s4MXRYTXFqN254?=
 =?utf-8?B?MU9YSVYxaVlucEEycmI3Q0FyeGZkTHFVYXVVdjk4ck5ucjg5ZTNKNUdId0dn?=
 =?utf-8?B?YkU0VFpYZFhYdXppa3NlbzExbDVuaXlLbFJTYWZGQkdMd1lJOC9GYVk3U3Yz?=
 =?utf-8?B?ZE9WUi9qa1pHUkVoc0g3YXNFa2cxUDVmZjY1cTFtTEZTakJzbUtMYXcxZDJE?=
 =?utf-8?B?aHNpU3ZRR2ZuVCsvOU9oK0cvSGNxNnJidktoQUxoUk1idTZXaUJuUG9LKzdW?=
 =?utf-8?B?SVJWTW5aL3lnOFMzN2xUc1dZSUlRZEhUUWlqQzIxNm1UY1I2NFJVZHM2aXlE?=
 =?utf-8?B?T1N4N0lFU3JpME14clJBL3JQeW1RQ3FDRDc0MjhVQ0ROclRpMHkrZlNUZTBY?=
 =?utf-8?B?cVVEdEJTZ2VHbUorZ250K0hmb3NSbHFUOHVJYUZKcG9pOEpLby9aUWROSUdy?=
 =?utf-8?B?RUFlNlhvSUFlUjFXdHpYdkNLRGpPanNjVEF5Y21hZHg5Tk5qU1IxSkUzVWw2?=
 =?utf-8?B?eUtKWnM4NnNiM2R6bXpDRWZjTGltbUU3WWl0TUd3VnR3TUU2bVpNZ050NnZF?=
 =?utf-8?B?bjB6dXMxWDlRV1d1OWtSekliNFRlMkZIOEQ1WklZRVRReWpJc1gyK0E4d3I5?=
 =?utf-8?B?b1IzS0dsMlJrQVRqa0NnS2g0UGo2N2MwTXZINitlQ2ZZaytEeGdqV0hhMzVH?=
 =?utf-8?B?N3dOWEVENFVUZjZwTGJhQ211MmdLRGtnUmVJdi9JNWlVeXF6ODh2eHhVUms0?=
 =?utf-8?B?a3JSazdTSDF3NlhRK0lBdGpINU9zZzh2U2djd3BWWTVFVExPTDNhdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0485A09F796D4241B88D45EBADF70C9C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RPcY8W5x+GfjxgeNnp50g3zDxQc0NzD0nmt30QY0FN7OKmcZhRi7hS9RnEgmodUpI+x/TfQ9iVUB0kW1KiEbmHFErg1Yg/oSMbzbLmAYhLdEjgwhRAr2pVUiONheACIfrp+exgGhrP/qcnVDeeTXNHvmhKyPh6ewqt/uZuzqdT2EDmCQmreYPt7ywFoem3mNPR3Af4ZqKLnpw0jue5RF3vYaOtIgLFF1ngGZh+IhwdqgOaUMHjafGQYXjQqkj2gt7RvnOmR9hUnDGFv/BuiJCZuLUtQnkb4iU/4ano2xiP+AxHrzGP9AOjl/UB3HvLa+lSAsxysDE7hKpkVcQ5fLhw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b3fa6a-c280-4464-d540-08de8f0c4202
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 09:59:54.2583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwK+KgpbnMyEATNjSYtXLKhbdkrcbmVyclSPteGR1Q2oEHH88zq642dfYlIdRej/eVjSoG9b1mixGOHeNb9Ngw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6082
X-OriginatorOrg: intel.com

PiA+IA0KPiA+IFRoZSBfX3RkcF9tbXVfc2V0X3NwdGVfYXRvbWljKCkgaGFzIGEgV0FSTigpIGF0
IHRoZSBiZWdpbm5pbmcgdG8gY2hlY2sgdGhlDQo+ID4gaXRlci0+b2xkX3NwdGUgaXNuJ3QgYSBm
cm96ZW4gU1BURToNCj4gPiANCj4gPiAgICAgICAgIFdBUk5fT05fT05DRShpdGVyLT55aWVsZGVk
IHx8IGlzX2Zyb3plbl9zcHRlKGl0ZXItPm9sZF9zcHRlKSk7DQo+ID4gDQo+ID4gVGhpbmtpbmcg
bW9yZSwgSSBfdGhpbmtfIHRoaXMgcGF0Y2ggY291bGQgcG90ZW50aWFsbHkgdHJpZ2dlciB0aGlz
IFdBUk5JTkcNCj4gPiBkdWUgdG8gbm93IHNldF9leHRlcm5hbF9zcHRlX3ByZXNlbnQoKSB3aWxs
IHNldCBpdGVyLT5vbGRfc3B0ZSB0bw0KPiA+IEZST1pFTl9TUFRFIHdoZW4gdHJ5X2NtcHhjaGc2
NCgpIGZhaWxzLg0KPiA+IA0KPiA+IENvbnNpZGVyIHRoZXJlIGFyZSAzIHZDUFVzIHRyeWluZyB0
byBhY2NlcHQgdGhlIHNhbWUgR0ZOLCBhbmQgdGhleSBhbGwgcmVhY2gNCj4gPiBfX3RkcF9tbXVf
c2V0X3NwdGVfYXRvbWljKCkgc2ltdWx0YW5lb3VzbHkuICBBc3N1bWluZyB2Q1BVMSBkb2VzIHRo
ZcKgDQo+ID4gDQo+ID4gCWlmICghdHJ5X2NtcHhjaGc2NChyY3VfZGVyZWZlcmVuY2Uoc3B0ZXAp
LCBvbGRfc3B0ZSwgRlJPWkVOX1NQVEUpKQ0KPiA+ICAJCXJldHVybiAtRUJVU1k7DQo+ID4gDQo+
ID4gLi4gc3VjY2Vzc2Z1bGx5IGluIHNldF9leHRlcm5hbF9zcHRlX3ByZXNlbnQoKSwgdGhlbiB2
Q1BVMiB3aWxsIGZhaWwgb24gdGhlDQo+ID4gdHJ5X2NtcHhjaGc2NCgpLCBidXQgdGhpcyB3aWxs
IGNhdXNlIGl0ZXItPm9sZF9zcHRlIHRvIGJlIHVwZGF0ZWQgdG8NCj4gPiBGUk9aRU5fU1BURS4N
Cj4gPiANCj4gPiBUaGVuIHdoZW4gdkNQVTMgZW50ZXJzIF9fdGRwX21tdV9zZXRfc3B0ZV9hdG9t
aWMoKSwgQUZBSUNUIHRoZSBXQVJOSU5HIHdpbGwNCj4gPiBiZSB0cmlnZ2VyZWQgZHVlIHRvIGlz
X2Zyb3plbl9zcHRlKGl0ZXItPm9sZF9zcHRlKSB3aWxsIG5vdyByZXR1cm4gdHJ1ZS4NCj4gDQo+
IFRoZSBmYWlsZWQgY2FsbGVyIG5lZWRzIHRvIGNoZWNrICJpZiAoaXNfZnJvemVuX3NwdGUoaXRl
ci5vbGRfc3B0ZSkpIiBiZWZvcmUNCj4gcmV0cnlpbmcsIGFzIGluIGt2bV90ZHBfbW11X21hcCgp
Pw0KDQpJdCdzIHBvc3NpYmxlIHRoZSB2Q1BVMyBpcyBhbHJlYWR5IGFib3V0IHRvIGdvIGludG8N
Cl9fdGRwX21tdV9zZXRfc3B0ZV9hdG9taWMoKSB3aGVuIGl0ZXIub2xkX3NwdGUgYmVjb21lcyBG
Uk9aRU5fU1BURS4NCg==
