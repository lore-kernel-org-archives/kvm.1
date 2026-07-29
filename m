Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D943C7AB
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785362776; cv=fail; b=K2Qu3z8qx+v/l4+/z/BYL1XASdy2sTctMAPHoaNXfb9aHC5sIDsi5F6weXRqZFU3w7vBDFtpJPN8P0WXi64soe3LBwi8nL6sKLBEoUJCuhUbXFUDOx43mmwFSLdfsmNzboPpupqhbw4FtdH/HxyKnLQ66YpUEPccefscUqBwlcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785362776; c=relaxed/simple;
	bh=tOrMWAvxl+Tgr2SSPTMip/tm2B4yl5V+fC6LPToJtJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jDGrT7BzapPmApqGARgJGJUOpYmyWaq6M3XkZmf/ggPxVmfCmPmRS/iOcIlDOPdYR2BsZw1oqwi01Y14Od1XVi7IFuVU7pWVc56C4PqsPjRshoPK+B8fnzYElbgEfHjA/6efFnRokPddOQsDbHFcPGLivQ1qFK7NIlZJkDg3Q/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2DjU7qp; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2DjU7qp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785362767; x=1816898767;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tOrMWAvxl+Tgr2SSPTMip/tm2B4yl5V+fC6LPToJtJM=;
  b=m2DjU7qp3ggB/mJ1Znpq1WxScc81XCLrJKxVkqxeK1JrTcDl5jnfVkf+
   rWbMiZ13hfEFyiBPG27Wu4xK2uEHpYQPV0QcTm8CATlq2tP2YCN3eQmJZ
   DmcswEf2WZSnLaSl48dHmVcr0vDM4m/v8hEHtTH1u21y7TMxBrLPBaeXl
   JRIo3CNSPE8p+V44r797pZ8jwvmMX5HhtzmXivm5NX0knESjIoxLkq/k0
   U/XdlLm74pXNlaxzQA4bTLduYJUfaLJoyDKDeZpurIoH5b6Y5TFMyJxIc
   k7ylruri9ePD0TPVb8TzOs0jaiV2G6kdkHFt2yN5dqyfL9a9Eh69cwgYd
   Q==;
X-CSE-ConnectionGUID: ZCsCqoZETdG06lXclZ8v5Q==
X-CSE-MsgGUID: vqRl0BkKThumBFQYv84Kxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85742714"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="85742714"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 15:06:03 -0700
X-CSE-ConnectionGUID: 3Djr8hvsQ7+hAgwOEjWzmQ==
X-CSE-MsgGUID: w3Nq7QhmRamg6iJ2lpTLXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="257450789"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 15:06:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:06:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 15:06:02 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:06:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oS27HPY/iz0CW4lTRfPJlWTxM+L7XFe/1mnNG5rYYjv4hzt4yd0F2bPqPcv72A/lfBgt6RPzDaQwfpVba25Ze2Pb23D6LPE3784Ui+ZrbU+hQT29nYA6Wg4sVLfpstoy7gyG3v7OdtvxVAwn3o2MENKOaLtoSHJTZuDZr7HnWub+4jJ91bsBiEJe9N7VmphHWB9WCJh1WclmGvxsZ2tHpDIqvd6ZEML+CrR/PbxQNawE8YfxUjFymx2owpSkpTuXXEcXxHyfKTd6PRMksmljV162qADd88/W8kcr5laBUFs04WZ+nCIfo/b86GtL6HSboecgAfdcAOfWVUPJekXIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOrMWAvxl+Tgr2SSPTMip/tm2B4yl5V+fC6LPToJtJM=;
 b=Bdl6bQEsJLocRZoKjYSuMsJHi8LpywcLjtHB6gazEMJDVCHk8jG8i95PUhTiFNs1VdwqU2VpQrWqAf5I+XHt/UhwLe7rQ+Z+bXTb3gctSK/4OmV1SozcGy9k0GELlvE7rwzDKsdgZmXeVrgd7KcMY1P8AFrbCxnVW/e448Ul3dVhkzKPO/YPXAOJvlvlVPLxm4scmMHL9WifanZWkqAHSlAAc/6o9dYEXs3xxAwKZ7wso9JHHhxXVHlkCyVWNRkpuYzLV43XlDKZR6zqqq7lPUfJmCBm7nrJkPxVWKdbROi0Fzs+wtA6zGm57/TS9TzM0gKxPhUa3S2GcS44FB+tYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB7146.namprd11.prod.outlook.com (2603:10b6:510:1ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 22:05:59 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 22:05:59 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v8 06/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
Thread-Topic: [PATCH v8 06/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
Thread-Index: AQHdG8vQ2q7LFT/3E0m7neUbbCFMIrZ9Y14AgAex6YA=
Date: Wed, 29 Jul 2026 22:05:59 +0000
Message-ID: <7bd02e4c440302ececb86f6a3b875efafd977c16.camel@intel.com>
References: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
	 <20260725002302.3337017-7-rick.p.edgecombe@intel.com>
	 <20260725003525.5A10B1F00A3A@smtp.kernel.org>
In-Reply-To: <20260725003525.5A10B1F00A3A@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB7146:EE_
x-ms-office365-filtering-correlation-id: e5fc866b-8be6-46a1-35a5-08deedbd9285
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 2nx3QXEikL+vbfEZ1xtANS2VlsEMxZmKRTcRmgVagqb5bAV5HFRodfjUlGmTrOQkv7jfOdPfUOkmJCragQwrcbEts0njuEawROfH00D2fSb6gTGliNgN9P9pKh4DAJ1RotMHrVzT0iV21KLeiA/LtgFuokHfV/y5ccgApFMuUOmEFwQ7NiWbTC+Q6y852tPwpxfNTLnkmY42uG6o7BoGDx4xJBjHt4CvAnCXLA0uYO4UxJyb+bYtLDbsXbmqF0ArKDX+rQwXIHddMQMaWfBb1agQawAnD450aYIyrPuja3maC3nyTspWEL8PFWINiC/xTpY1xPUki8uoz8zamIFquqvLXjNMR+I7ybMM8Zpnqkqo7XC1+dKTT8A3yI+GmBG43hcTrP6Q59+eUzu/30xNNNxjGRRwjxqFA5JhwN6WhcfhKha4JIqHyZH6VXs65oNA3uPnNMekIuBdyxmD/MFoDFPF7SuZ8IQVQYFKt6flEPMRQ8cbQuAXF1wUjYzwMYmAIrkX9e1ozpMADXyIMbUBaGWzAMM4W/FH9s3fFuFmBSHiRbqZAYsmAdyzciM9HfoJdmSKxQwibxWM8eIg4fP2SweKPz0jUIv17jpPSN9gVnFseBATGTu/euJyPmYUDl5ir6p4UTbKs0yaV2zWA+UGdOB/NonukvOuv7vr2Nyg/qY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0pidjFRSWkzOEsya0FZUlBVSDMwYS9KdnVDc0xLVFB3SFpMNjF1VVVOOVNs?=
 =?utf-8?B?WnJORXZrcnVVbHNPbVA4ZWVMS2c2QjZOcTBwYStYT1BGdXJrNFlnZ0hoK3Zx?=
 =?utf-8?B?c3lPUlQwZXJ4YWx5dXpGYjR5bUlLdElwaWRiUlBxSmhRMk8rMHJDUjhWM2JJ?=
 =?utf-8?B?VkZqbG1MdzFiNVhGWmdheUpiSHRmREkreG9JcE9vdVBHeVFQSFRUSi9maXF1?=
 =?utf-8?B?YytVQWMwU1dDMVh6RmRKOTZMaDIxbVBxZFJJZHZFdnpuQmNGYzVveFVVSVZ2?=
 =?utf-8?B?VWFyLzVML2ZxaUVXRmxmY3lwVVdueGoxaERnRC9LaDRGM3NOM2YvYTFZNWZP?=
 =?utf-8?B?cWhselhBVlFqMWFHbks3QjlhY2psSDU2RlNnb1pIc2NLc25PRUhJNGphRFNF?=
 =?utf-8?B?NDBwN243ODk3MGZlVGZNdnp1Q0padnRMc3RtWEZ6MlllTGVuSjBXQm9IcklI?=
 =?utf-8?B?ZXNkNzlTTE5lUW42UkQ1UVptcjFNdGptRWdaWkd5ZXl2dlZQemZaNVl4QzZl?=
 =?utf-8?B?cnBRMlpRcklLTG1pa21kenF4VDhrUlN4QVZ5bDluN2xnZGV1b2RVS1ZXM0FP?=
 =?utf-8?B?UXQydHlXYit6bXpreGxEeVNqRWVxYjcwbmhUbG9GdGxxUXlUU216VkJlZTZ0?=
 =?utf-8?B?dHJlbmxCQWs5ZGhkSWNvaEl2aTBnT3dkeDcyeE1ubXlEOCtLMjkrVzRXSHE0?=
 =?utf-8?B?TVRNVnA3MHdoaCt1MDFJRTJ6V3JJclAxckJEaFJZS1RzUzJHQm1YamxZWXFa?=
 =?utf-8?B?OXZlZjBXME9vakczVUdDcmJteGF3YnhqbEgyZ25EY3h0ZWlUS3J3ZlBPWlN2?=
 =?utf-8?B?WGhKSFdHNUV0aytGTjhVRWtPa1NQZDMxQ0tOamxmQk9wUHFpelR5SkwvMTV2?=
 =?utf-8?B?OVZOS0hETzRtZG85MlZETmdhSWVCVnQ3eFJvWHZqejZMZElsaXBUNE5lSG4w?=
 =?utf-8?B?RjU4dE96Mm5xMnhuWm9SZDIyNUpUdndvZFFOQ0lsaUsveUhkaVZENG5mZTI0?=
 =?utf-8?B?TGRrSnp4MWw5Zi9md3haOGdCZzI5SjVlVFNWT3QzNmJFMFJsbFFzaVFCWW5S?=
 =?utf-8?B?MWVzWjNXN1I4QzdqV00vOStrL015OUZkTm5GeFp6RHhFcUZ3SmE2ZGQrOFoy?=
 =?utf-8?B?QUtiSW96NFBmbHdaTjZFZ295WXlvVVZMMy8wZTl0MU5zZ2R5emlhaTdsQllS?=
 =?utf-8?B?RmZ5N2xVbzBKNVo3b2V2bHZzVW5hVE9ia2RlSlcrcXpoQy9peUI1RHcvTlMx?=
 =?utf-8?B?TUs1ZmF1NDNmakdEekZBWlZyck5qYXhhN0hoUW4xdk9rem9ObWd1N1I2S2Qy?=
 =?utf-8?B?UDVOK0F1Tkl2N1FjMHNzWloyR0FZa3E2eHZSemtHa0d1b2JDUm9yM2U5RXp4?=
 =?utf-8?B?QXl5QlZjaEJURWJJS0I0dVZDMHJESmhXVkpVSE9JYnlMb2NZUk92N0RKWERz?=
 =?utf-8?B?NTRhbXFTa0lhUDduQVRDKy9ZU09yMEcydnJFdHRXdlA1djA2dHNmVEtMSmVw?=
 =?utf-8?B?VFJidkE3Y3RnY2gwMzEzUXFITGtPeGR1K1JobkNsNFp5MDN4YlY0eENhbkNk?=
 =?utf-8?B?QjhNS2Zsa1NEKzB4VGk2dDcxd3VDVmsvd1ovWElKWXAyTTZvQ3JPODVyRUJ4?=
 =?utf-8?B?R2R2Rk83ZjU4R29xckY0RytiYkFiZGxVVHRzTTRSREFkcVJxWDg0ajBORElL?=
 =?utf-8?B?TC9PZVQrV2FTUUViK3MrTGpsK1BXaW5lOUtXaDRaNEhkTDJjY1NKTGxseTIv?=
 =?utf-8?B?bHVZK2xOcTJHUTFsY0NLM2YyNWFkaGh0Vy9taXhtQ2lkMmVxSy9zMlFtTE95?=
 =?utf-8?B?c2hLbElHVWIxZHlmMkNjckhwelZaeHBOS25aMXJRVWV3c2NJZWFGYkJ1UjFq?=
 =?utf-8?B?WXNhZ1htUFgyNEN0NEIwbTYwbThBakdMaHhYVzBDaHZSZXJrUHI0ME1Jblgy?=
 =?utf-8?B?K3MrUzNCZVN2aW5wdXE1TXBRMy85SXFMQjRJWXhUM2FPOHJqSUJiUkZEOGgx?=
 =?utf-8?B?MGJ2ZzhiWGR4ZU8rclZTQjE3VGIzVitMWkgwcEdqY2RReGczNEJqeThlNlFM?=
 =?utf-8?B?YU5aRXR2QW9JZjM3VnQzL3FtTGdva1Y2UmlSZ05oQ1puRVFmSms1ZkR2MTl5?=
 =?utf-8?B?ZzZIS0dDQjNKbU40YWQrTk1XUUJ4d2F4OGpDTlJMQ092b3JHa0o1MjRnbmd0?=
 =?utf-8?B?SlhqK3pjcjAxZUJENGVzMGVHT1RCeW5QWm9XM3hPK2ZhVW9QYkoyWFkxYVhF?=
 =?utf-8?B?Sy9najdKTG9zVzdjRUIwSGs0U2xvbGJrNnJoU0pFUEhXcG9PUWhpR0dRcDZD?=
 =?utf-8?B?amprU0w1WDlIZDh2bEhVOFRPdzVCM2JhRFB0NW1XU2V3VHIxY0dKaVhMOXRs?=
 =?utf-8?Q?nfJrV52ZBi9kVrBs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4FEBDD3C1593548AD0CC6C549F9DE9E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BhX7Cd0OyaOVuK6D852Qziiq9+8+9YicLR7d+AxAZtBa+dge/OQaKlSON/yi2JnWWIRlpcweM66/N+CRB40poywQTWJs345UPN9btNncdZj5B9c3Jlh4lgc/z+wyKAcPTzjRrK7pGoFSm5RORS6NRXHPM7icRxAaBE/8ZdfL35n2wwvUGckSZGO+DOcrPBFuB2d5ejQMZoJ1sOb2TdXaLTaN7aJvXhCXcc1b8JmPNPgWrgJ4zak4asHO+NYbg6jqgueJxL+/j/bmVsR4RcloGmPi97pvMd88nOoPT090Iebq7JbH4wyWotcAmBdrFbTin67FqCBjJRn+pE553HUl7A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5fc866b-8be6-46a1-35a5-08deedbd9285
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 22:05:59.5519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4GlE+v2WA5vv2VbOK0Kz6ytuh65FCD1wJRFhKw0yQluA5QRgc9ncLb2SyECGcDuz+iyKignEgifJ0Btj9kd3ASv1LgNzuxv70Txx6Ljgl9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7146
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTA3LTI1IGF0IDAwOjM1ICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IFRoaXMgaXMgYSBwcmUtZXhpc3RpbmcgaXNz
dWUsIGJ1dCBkb2VzIHRha2luZyBjcHVzX3JlYWRfbG9jaygpIGluc2lkZSB0aGlzDQo+IGZ1bmN0
aW9uIGNyZWF0ZSBhbiBBQkJBIGRlYWRsb2NrIHJpc2s/DQo+IA0KPiBMb29raW5nIGF0IF9fdGR4
X3RkX2luaXQoKSwganVzdCBhIGZldyBsaW5lcyBiZWxvdyB0aGlzIGFsbG9jYXRpb24gbG9vcCwg
dGhlDQo+IGNvZGUgY2FsbHMgY3B1c19yZWFkX2xvY2soKToNCg0KQXMgU2FzaGlrbyBzYXlzLCB0
aGlzIGlzIGEgcHJlLWV4aXN0aW5nIGlzc3VlLiBCdXQgYWxzbyBhbHJlYWR5IGRpc2N1c3NlZCBo
ZXJlOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtL2FrNUwyY3NJVHlpMXRHcDBAZ29vZ2xl
LmNvbS8NCg0KSXQgbWFrZXMgbWUgd29uZGVyIHdoYXQgd2hhdCB3ZSBjYW4gZG8gYWJvdXQgcmVw
ZWF0ZWQgU2FzaGlrbyBmYWxzZSBwb3NpdGl2ZXMuDQo=
