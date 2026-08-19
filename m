Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94633D34BB;
	Wed, 19 Aug 2026 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166514; cv=fail; b=BQ/eblSsJMsIxNVCs/oeF/51MsmlGtNTy992V83PIRMYk2u7BvHm7k7LxjJxqFw3FViicsHjQOMxfVsrADxqno6361xHjeO5cE9DgyV3VyH1iyJ36k7+DkMRECmTj2SSXW+dMPs5Ug8e8dAq3Fe/Vg9I23/hDilatG46nGYqusc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166514; c=relaxed/simple;
	bh=RFwNEhsFi3qJnANLx8oapSAAg/YF+HnvO2P50Nv5DrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VUtBbuyotoKBcTyRuOML4BTi6ihYLdF2AeX6p4vk+5NWKM9WbZpYocklcprJktiuz5JPUbIAzmIC3qdPrlE2jTiIaaoiqx779mrvOdT825vsWl4KGED3DZFt8ZxnXkMtPVMj1yCoUMR3VeQZLXuK7KoKgRoOoetLfXhcDxWUZe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C67zFs7x; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C67zFs7x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787166513; x=1818702513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RFwNEhsFi3qJnANLx8oapSAAg/YF+HnvO2P50Nv5DrA=;
  b=C67zFs7xtoXjjNy8lnjN8CVBGstiCWskq6qXb5tFnReiFBxQed6zCbI4
   LfG0Zm6385Q3OqYJKM+Rzv8CGfb7kFbNqT57qRbf+HKPmc2mofZdEfjwk
   674dGxcGOTIK2LXPl07qnlF83TBID7d1iaA0y7BGCG+rkrZWV5WBCtjmU
   SMRxiVp//lsXHBfDBuQD7P3PJZO2Jx0LPp9tiz/enkSG/Hea+xrNasEwA
   15/OsX/A3Sjwflr066rV/D4CxjYMJzEWPEAH3xF6A0LPYsz4YxqTkY/hg
   qoRbB72wuDqT99tM2D078AlfmclvM5rtCSPeOhUB+u/VIZicoiskG6pxR
   w==;
X-CSE-ConnectionGUID: aYcXWjuiRA+JjLbQES6iQA==
X-CSE-MsgGUID: /h0/z2gUSluigxB0YE1qEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87812591"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87812591"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 12:08:32 -0700
X-CSE-ConnectionGUID: fG4hI2ykS4inaMeyGuQvGw==
X-CSE-MsgGUID: nmYWjwwYS7mwjPul5eEofw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="270851509"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 12:08:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 12:08:31 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 12:08:31 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 12:08:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjqZrOomCJb/dUaIvOFzYxHbcdiuGiT4M7209MqijdAKqVxifMo2yBbmLGPBOKBG5xTmZtfS2cOjTAaW/CLBsazYGu2xoqQjplXmvG5/hjDBCbQ7gw7LgY3VMO5CeYsK4GCr9agUF5Qj3VVrB28Bxn+Brty1q3C/uH9so/eBDBN5p014cbtX/RBKeSyEQEQFGruSkPWH+Pi1iaYWbSVvDAu6lyDE3f1cDcV+AsJeZ9RJiaGQe1IiaVAktr2E3OSwSLzW1Qmdqsq+eNcVklQgIA4G89j0yQk8m+PrHIc8hhta4HtFN4ZGCOwaTQOPbRMuSKrkFmpGoA8lKoA1KpoqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFwNEhsFi3qJnANLx8oapSAAg/YF+HnvO2P50Nv5DrA=;
 b=RlKXX7bfPOfSknL7UYu8Oh3G2HJb3aGl/TddmvVYjFS0ob2fHIpPJEC2bfHTwu1XrQY4yTaKbBKGcRLqbWp4jdMmWuqPBDlSLr46KegzcCZM/xkL2cp1V4EfzrFTAE2pE81GKftAu7APKaLqxGXcUHJPzVsnzp8CBOzhfX352N/xQ4C0gWjxto7lluTYS7u/xrJcgpxZgh17cO+AlHFV4lgLQTLedCBko5VDkk1gPzYwQHExWWR87DAZPZE0YR/q3xxGmbz12FpsiErjSmAms53be0baAM8+sDoiNddQrLDTSQwqm8FAEk2QuvIW/8AwgobxCd0MJpNHSmrSWGpOxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MW3PR11MB4570.namprd11.prod.outlook.com (2603:10b6:303:5f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 19:08:27 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 19 Aug 2026
 19:08:27 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH v4 5/9] KVM: TDX: Update exit_reason on wait_for_sept_zap
 return
Thread-Topic: [PATCH v4 5/9] KVM: TDX: Update exit_reason on wait_for_sept_zap
 return
Thread-Index: AQHdL8DGMrRouChNnUKJrZirf9jVSbalvbIA
Date: Wed, 19 Aug 2026 19:08:27 +0000
Message-ID: <ce22e1fdeca28d5319a80cc9f1cb312c570924d8.camel@intel.com>
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
	 <20260819094903.3060020-6-xiaoyao.li@intel.com>
In-Reply-To: <20260819094903.3060020-6-xiaoyao.li@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MW3PR11MB4570:EE_
x-ms-office365-filtering-correlation-id: 85f3febb-503e-4446-0999-08defe25401b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: a7Dshnq4i4pdWlIAtYTtuYMPFVIGPqv2JpcJrYKOX8KuoBVUe2eYWUL8bK8+mR1XqPq1XMkBFi41AwRMe5/sMcv5MOQT+x971RSt4OkLxTmoRXmslluekoVKdIp4wfBFd3mZCx782Ut8B693OGgr8dVTpukbsqzF/rF74w/zq2R2VTjLSp+4KL2B8eErOByihdK7bXt1o1ktF5kjtaMZPM2ExXbare9VjKnS7g3CeyTfwKh3504Kyh69D//GcVfQoTk0iLR1+97HFVgFhMKEaeNLNMHOsAjpxMxVjg5NKMlxm5li4tb/fD5jNZPbfI8INBtjUbbDAjFl/5IUH7CfAlQI/2P3ZiUXcQf6zfelhH8QYuII1SxuS/VCe1B3T3gpY2wMzb/97HI5fwox2Dy4APAGWpikELLwjSHUol3fIC1GNCL5hv7BEWjn3LV43Hdg1CNJPWaxPcBfjBqGRuDRQe4iAu1jP+isIXBhTRUd3fcAufpKHwSCCaji0UWrMG4X5+nkZs4RkZj3dyFjseS9uUKXQTiwx/WA+pfC6PglZuJnJgJ7/BU1GnHqfaJ+l9LmINd337CkfEeOV4AFHZFyCtEhsiZL1Uw2ZMFqN93DKQRHil8TSiWuMX/jAKsMDX5Enrd0EpSbfj4/hfZrFbQ0C3COLyyQwunfPMiwMtt3W7EKYiwSYUZj5BnbuL9LRkjRXqx1h8rUJLGOzuNvLNHphrYpnMmAHgWlbVskRb1zgGc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEp0RWFZdEpER21IbjBHckIxSno0dEREUFMrR0h3dkFNVkJDb3lmaGZHQTNt?=
 =?utf-8?B?LzNXWkMxeTcwVi8xMmpHeHJBd0FFN1hneDJvbzNtU2ZzWkdPSGxFZ2paWUxL?=
 =?utf-8?B?TkpHK1hJaWkrM2p5bjFpeHZkdkZEbmkwTUlNRUttbEpaam5OeEEwZXpVM2Vj?=
 =?utf-8?B?cmFmb29oa04yTVV3d0tWeGlrTmlUSkxXYWIvMTIwUzNRNEx4K21TMkRHRmFs?=
 =?utf-8?B?R1RFSFJpUUZwWkQ5eEVuc1NESElEYnRUQlU2YnMyUG1RYXl0ekN5WXFTejJu?=
 =?utf-8?B?SjZrd0pLRm01aDl6aFdhVVlCT3VmUUJQMk1iTXVQUmtFUzlOaTFFaUtNRnJk?=
 =?utf-8?B?S0FmRzJ2MWgxZ2EwSkNEKy9pOFFqejM2NzdrZkFzYnBYWXRTeDIzUDhSYTRB?=
 =?utf-8?B?VmZsQktSY0dBU1dNdmlTUndMazAybTJlUzZqaStsSXVXMUd0TWZqcEphRTBN?=
 =?utf-8?B?UVVkRENnR3grbG5qNjJuL1pvQUdiRFFMZTN2U3ZXV0czejBNTndDcGxnZm1E?=
 =?utf-8?B?UlZ3VXdzQ2tLbFlNOGdmSXhsd3Z4M1BnTGJNWDltbjB4TDlLZDM4dDhEN2ds?=
 =?utf-8?B?eUN2UlZHNzNuM0JtbEx0bllQVzRwKzBGTU9OcXlQQVMzL1VPRDRRUEtaS3R2?=
 =?utf-8?B?VUtBWUlyK0J0ekFTLzNxYURNSTRCZlRBVHY1N3Q4Qzc5N2EyRkNOQkNOdStn?=
 =?utf-8?B?TFZXYXdJU1h2dmxwRzU2NnNVOFVkYkJnZG1OVEJ0ODRvQVdVZkdmVmhpSDhq?=
 =?utf-8?B?UVorbUZOcmQ2TW8xREVlMUQwZnRVVzQvcXJxUEczSDhVb2t6QnVGU1M5R0xU?=
 =?utf-8?B?ekdkN2lvT2JIVEVWTkdyc25Gb3JweFRtdU52S2l4M3dZSVVPQ3Rqbjh3akds?=
 =?utf-8?B?RWh3NUZ0S3NPMkZZeEprVHdQQmFjKzdIWjIvVEg3VTloZjkvOUpMdlBXcFNO?=
 =?utf-8?B?eENLZFJmODNiRCtwTU1NclRzdlpxNk5jRzIvSnpiYzBpbmZ4WEhIZ1NaRDFU?=
 =?utf-8?B?dk9YVHZncEJkS2FNVDVoanRQYi9tQzhoNk9CbUErblR2ZzByUCtxdnI5ekM5?=
 =?utf-8?B?SG5FTEVFSkcxQkE5REtJNDhGUFd5ZGM4YlpsNCs4QXVrei9NbTNqeVdUbUxn?=
 =?utf-8?B?Y0RYVnp1dFROcG1HUTJISllMLzZSeXRNMnJaVVZ0aVdYQTBsSzNjcnA2OFVx?=
 =?utf-8?B?RUxZcGl5MURZeU1TYmFVdDFXYzFlN3VMNFY5cFR5dkFEWHZNdVhnK29COEtV?=
 =?utf-8?B?RTZ6bUxzRHFRS25BTDNkN1lKeHJxMDVuamdwYjZ1alB0NTU2TE9Pa0xzSlZz?=
 =?utf-8?B?aUhRRk1sSFIzcVRnL0pFcEtlODRWN1Z0NXJHQnllTDdYSFQ3NUZxMkd0NGZP?=
 =?utf-8?B?c1V1S0lyeHR1RWpvcGV6UnZPSy9GVkNvSWo0SVBmRzR5a0RaRWdEZFVuY0ds?=
 =?utf-8?B?ODZRSmNmdGNsWnpxYnBDeGZtZXJESkRvMlpuMUVhZG4wNzlmZkRzR2VJa2RT?=
 =?utf-8?B?dVc4L2xhalJwZFErNTRONGgyR1A2SnVHQi9xa0o2ZnpzSVc1OWR1RGdrL2w2?=
 =?utf-8?B?YWtOWS9XOEFabTlsa0hIK0l4em1OaGtZNFBXN24yVmNNbncvQ1Rhc0hCS2g4?=
 =?utf-8?B?YUNGWGgrMlFCWitkdUdvOGlWOVh4U1pab0VzNHozNEtkL2lwZXhRcU4wbEpy?=
 =?utf-8?B?NTZha01la0RleWQ3cTdoS0JUTStMMUttcGpUSjA1ZTBVVzdReE9PSEIzRGFY?=
 =?utf-8?B?SElPZDNvV01nYTNxN3NjdW9rSFQzTW1tcWZPVlorL3JiR05MWDFnVnFKUnF0?=
 =?utf-8?B?RTRWaExiY1BRMk9YSmxWanF6WjZaZnB6Zm9sejBCb1dveGxVQjBFVm8vNmRa?=
 =?utf-8?B?Z0x1RWJjTnRiWDA5VXJNeG9TdnROa1VGOU5CT1p4RExoVVNJMjFDT2RIRk1G?=
 =?utf-8?B?LzhZUFlEb0tLeXRxZHpIa21VejdHVURGRWJXeXVCeW9zNWdzSmRkdWVSQ0Ev?=
 =?utf-8?B?eEFFTkE2NXVwNFdqRkdoTSt1M2JrTUNNZHVDMmZKSWoxVzhRWG5ydG9UK2Z1?=
 =?utf-8?B?UnpBRFlrTGhiZVl4Q1gvaGtybEdSYUUyNVIyWU1CdTh5Rm1nZ2RxZjk4dGQz?=
 =?utf-8?B?ZXRiUzZBL1NwMk0wYXdsSHB3Njd2THBleExjT0tNY3h2alZCcUJyTUl2RmtG?=
 =?utf-8?B?TnJPaENscXJjT0xNY3k1TEI1WVkwdmovazg4Y1ZBN2U0TGpDcjZ6MXVtbzBF?=
 =?utf-8?B?YUlMRlIvWlRsTHg0K2tqU3ZURnJFb05VblBBcUU4VVFCWVE5alFXdGE3TWN2?=
 =?utf-8?B?OGc3Vk5QeGFEbU1vMXhoTENsSktFd2pucWhFUVJDNW9Gek9OMUNjRWFtN1ow?=
 =?utf-8?Q?8yi41sknmwNK7IOk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9377EDA3A47FA84781902E937B569753@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XHlnwhlJokbJJFf/nUB2Ik0gNVKnBOtYr05K2Bdsl+zQ6cxXGbqqPoEjCfSovImTwLCfQYwPpgpIWppgXy+8J1+mobYv+yX65PWNQcoY16iYGeRmz6puSsZd4zs1Aa0edHt0ADABitrzziPfXQ2llEDzG/vCIrdOsH4KhoRU2Qeb9cZGHYS5P9yLHKE5fTHhp76XBGtycXNHXEzkLFzpkszteSAOCfYiLCTDCDD3Iu+tPzTLBWMCgYLkXVNzBYe8u7WMLXajm9IkLvgNXn+edAuhXs+/4hZBeySrHmrMeFHBL9jCs3ozeM1zCmyeIsmR8QgV7VfdL4ZX1H3A0yyf+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f3febb-503e-4446-0999-08defe25401b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 19:08:27.5579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42FVS6b1I5PvWWyMoBR6waPP0Pr4GJp3b+siO84X8KrnhymLCnCki5E+rUCcE6CYICNyz1Szmyan4OggoXETFeZw5ebals30zuO1j3RIEBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4570
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTE5IGF0IDE3OjQ4ICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiBV
cGRhdGUgZXhpdF9yZWFzb24gdG8gYSB2YWx1ZSB3aXRoIGJpdFszMToxNl0gY2xlYXJlZCBhbmQg
Yml0WzE1OjBdDQo+IHNldCB0byBURFhfSU5WQUxJRF9FWElUX1JFQVNPTiB3aGVuIGl0IG5lZWRz
IHRvIHJldHVybiBlYXJseSBkdWUgdG8NCj4gd2FpdF9mb3Jfc2VwdF96YXAgaW4gdGR4X3ZjcHVf
cnVuKCkuwqAgVGhpcyBhdm9pZHMgdGhlIHN0YWxlIGV4aXRfcmVhc29uDQo+IG9mIHRoZSBwcmV2
aW91cyBFeGl0IGJlaW5nIGNvbnN1bWVkIHR3aWNlLg0KDQpXb3VsZCBiZSBuaWNlIHRvIGRlc2Ny
aWJlIGEgYml0IG1vcmUgb24gdGhlIGZhaWx1cmUgbW9kZS4NCg0KPiANCj4gRml4ZXM6IDRiMmFi
YzQ5NzEyYiAoIktWTTogVERYOiBLaWNrIG9mZiB2Q1BVcyB3aGVuIFNFQU1DQUxMIGlzIGJ1c3kg
ZHVyaW5nIFREDQo+IHBhZ2UgcmVtb3ZhbCIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQo+IFNpZ25lZC1vZmYtYnk6IFhpYW95YW8gTGkgPHhpYW95YW8ubGlAaW50ZWwuY29tPg0KPiAt
LS0NCj4gQ2hhbmdlcyBpbiB2NDoNCj4gLSBuZXcgcGF0Y2g7DQo+IC0tLQ0KDQpDb2RlIHNlZW1z
IG11Y2ggY2xlYXJlciB0byBtZSB0aGFuIHRoZSBzaW5nbGUgYml0IGNsZWFyLg0K
