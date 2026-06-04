Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E99043D50C;
	Thu,  4 Jun 2026 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576774; cv=fail; b=PIO1NOqRNqXbb9TE0n9CsJaY98r2GhmwZqE+hvMt9ufagbg/bqnasZBlM/nFRxA0FhldbwL0MoM1Mg68kweP0FotLGFun1VEg/lIC8wTukfEuSoYDYKyoRnuC1XUTJacstNse9G+tQiyEcEQopBQGBi2xPgW/LXQ3vlAsmQv6tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576774; c=relaxed/simple;
	bh=9w7NQeHgmYjWNooQ21yn/EBAD16T5nQac5ht2FZ68YI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G85G5f7btUeI/vnDgNeuNDANZTxur+KR2loNnLgkBLs7heW7XNRNpjeRLR9fiUbddBrnzRGu/Ewlr7IOLMBkAPff2PC0oPtJW32ZgB5PJLbflDiUjnkDKHCHM6B0VdRuZ3JTmbnafBJdpMWg9B7bg39/PeG8wkYDqpuatrD5S9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdku3Hg/; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdku3Hg/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780576774; x=1812112774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9w7NQeHgmYjWNooQ21yn/EBAD16T5nQac5ht2FZ68YI=;
  b=kdku3Hg/bw5OQ2gNdWZaLsQsxADwBKC8YksNLBX5rdqZJbSyRDn48q1y
   VoBTW/8VtT/pCnocvCR7csaK8tesA/zsL+dtgFa6oua3A+XdGsNSwSXwO
   KeO0hJggROhCDfJdRwaF6+85QLGpT5l83ZPcqpLAHQCcfrUCUP5zeMp6w
   9CPUk4Qfh9tWP8yvJGlFZuJrlqcb5MHZULxnX5Oc28jkGYdsUaJuXFZC2
   ZeuheSCdn3S6JwxZj0FHn4KcApk2BflNDxI6YDKXrgJo/EZdFp0OfRSiZ
   pWXGXJ0giM3x+sCf25JR27iMCxo9ku5/h6z2lTEDYEKFyYkKE5LaPokkR
   g==;
X-CSE-ConnectionGUID: YbRXHKdPR0qbcAvn3rvKkQ==
X-CSE-MsgGUID: rC7z4edRQTOAskuyMjvkrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81582659"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81582659"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 05:39:33 -0700
X-CSE-ConnectionGUID: f8kUsCa+S8KVAfPAFg0ZMg==
X-CSE-MsgGUID: U1Tjos47SyOnvMd/unR9eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="246367708"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 05:39:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 05:39:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 05:39:32 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 05:39:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbpVkiWcX0uRtWNNUdk0HINphaQdrm/6sjZXOJEhmhmm3voq2RzFROJ7t/6Te0Rq23gPB1EGV3wWsXSoEJob2AuKTEhpORIpOODPi2dCoM90/AhIxbEkMUN2fi4wD+WM5wOWhYY0q6ufnrEp+1r7j6lFyK5WhXpmHEDt1NjPWZrg4QhjkYViBR0klllYm9FaHIkO+YH9FnCtKyL0ODW87t5XJqgIO91ygVQO29eS/8JlnHE+Wg7qu0OqQCq1/cJffxknGy1FWzrRgRmJQnAm4qFtA5IoQMrgDZ/uNjt4tnkBZqnHp4LHmW2edcg1u0Dey4G6XmIB1atx2MeUasIG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9w7NQeHgmYjWNooQ21yn/EBAD16T5nQac5ht2FZ68YI=;
 b=eY1oF376YyOrHYY0d6/TTUf61+WM6l9CGn09blnTIMXHc8JBgEA2R0CMj5aU5DvezQbJ1ycYkj8HLqNNLuJ7NVH+NIvo/6UCdu5sOlWe8xOHJ2wQ7vF3lL4d2ixT86m8Q1tUbKkU/sQ194kkvE8CL3q6/Dvu6Y+lrQIvYQdzDhbJTq743TOJTgve9KT3st/Mfa5UJ61znF3sl2KyNMbJ0ZCozRZWJn5qGHu1ShMq2cvV4ucHXQOw6E8Vij+djswF+0PlR9AiXNkTcsKc7MNCynyOvntOWr0LQfrbX7UsrJyfFVGAYh1aQefrViqq5Oudz/gaBoVZJKQXRdX3kW0Oiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA1PR11MB5780.namprd11.prod.outlook.com (2603:10b6:806:233::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Thu, 4 Jun 2026 12:39:28 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 12:39:28 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 28/40] KVM: x86: Move kvm_{g,s}et_segment() to inline
 helpers in regs.h
Thread-Topic: [PATCH v3 28/40] KVM: x86: Move kvm_{g,s}et_segment() to inline
 helpers in regs.h
Thread-Index: AQHc77nJ+xDrEiXPSUSMeUZyJHuTgrYuXucA
Date: Thu, 4 Jun 2026 12:39:28 +0000
Message-ID: <a41300e17d5a678dc40039d6d8be779692f3adb5.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-29-seanjc@google.com>
In-Reply-To: <20260529222223.870923-29-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA1PR11MB5780:EE_
x-ms-office365-filtering-correlation-id: 01386bce-96c1-4d39-3370-08dec236517e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|6133799003|11063799006|56012099006|4143699003|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: U3CBkSNP85wnYBSZbNjSrWBO8jY9LN1wILnI33syTURdWr4Y8q+3GRveFixz14LZfu0VtphhvKj1v7JWY0DsHXac8FPbjYAyFyb1OyP9imQrXFXlnPk49mWNTpjeLx6ZIqt6L7hGkDME3/1geuQoRNDkozDl5dAyjwxHDOI0GEznDEPjeUMBoHMIJY50qrMzgEr6uEzttBYxDXFibb/PDHnwWYgqtQ9v+nI+PzFggfMZ4nAE7OhHaxDJp6w3hN/3p6bauuMNotUy8fywd60lH18zQ1Cjpt2LBxTmayjoaYYqCPTuRwl/OdnfUNLAcBhvR8i8UQkSmpJQ2Izo+xUhwQ9wWFpV4MZ4m133h0Dbg9ys4ox+XDVcDnhDA3Sh6mCQd9wHE3YVHKZW0UkrcGts6ARbUtjjrqNX4GuOQ55a5yHHzXTit9JDvo1sQ318zYb+5uxpJq1HQ5dgFAyRCkAnVhZFkuft51kLKHmpo/lPyVk2vfrGrSiPQ/u31NdpGM+3DH0sNXbAmzDJdLRTvAtIL62oiDzKd0b/MlqT4/ty3gWcfPN/tUUVk1LxYRfN8OEFrxwMqJd69aA71nVjDUlOkeocSmUz6SnTQHS1WGSJ9MBO4IxqJOf3WwlDumlHvCU9T4cJ7hZX31SAoZjAohXpSh83y+exLyLpVRiNgxRcKoPmR5PjKQc55lRhR+EPvtfpdooaFnRVfaipTaJmIj8R9Ijlkr4eIAB2j4K/gLGqJ6kjNhaastIXJYxzzlvusPW0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(6133799003)(11063799006)(56012099006)(4143699003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk1xUGNlZUFCajlNdGxTakp3YWNhM3haM3RkYTdTSmZxRWx5dHdzLzk1NlVG?=
 =?utf-8?B?VEtHSFFPTVZYMzYydVhRMjNZa1U1UVdXVG5xSjc4aUZTVVlNd1NYdE1tU3Fh?=
 =?utf-8?B?aVJEZFhjS3UwNUZ2V0lVWUJxNmZTNnduWjE4K0EyNXkwUHJLdk12RjVUWHFF?=
 =?utf-8?B?MklmUmp6SmR4UFZVc05VWlNpRVhTbFRWblhnUUhYZ2JHQXJRM21USVNQWjNX?=
 =?utf-8?B?ZFdROXhwekhHNWVVTTZkQnlocmJERXNNTS9ybEZuYXdKZHBMbk1oRVF0d3I5?=
 =?utf-8?B?dlpZLzdtYTMwcjkyWXN1QW5BdWh1SlpXUGNDT004SmFXQUI5Z2s2OXBHVldG?=
 =?utf-8?B?S2FZUXlIcFFaSkw3QkNRVlRnNHJTZ2JCRUZlVDB4Ry9BM0Y3WWlYWmgxdXFj?=
 =?utf-8?B?TXhjcGdiV2lMU0pHV0NhOUxDTG9RMGRQRzA2NGhlUW01OXR5c0NsUndqUzVD?=
 =?utf-8?B?aEttaWgzZ2Ryb2l0ajVVSGRGaUpwRlYySTd3dTlIV1NCUmZ6bFRONHZLSkNM?=
 =?utf-8?B?MTF2YzVmTS9nWStMbTkwbnEzdTVVVktjSHc1QVZhYzYrRzBtdUtBU3FRb253?=
 =?utf-8?B?NkxjSUZjeWo1U014NEF4Vm9mZ1VLSDFjc0h4b3ZSS2RIN0ZjNUVWczR2d09m?=
 =?utf-8?B?cXhMenZmdVZnRGdhY2pqUHhCVld6bnBybmtlYjh1V3NrOWQ2S2FvcHZScmpy?=
 =?utf-8?B?RTNWalp2KytYOFdVV3B2dUIxWndSSEpYWVAyaU9FZm1aMWZkYUJadVFIc0Nj?=
 =?utf-8?B?ZS9CQ0xzczBFVnlDd1FhRmpzQmhoeWZqVmh3c1p4NzRocFUzZVFOcjVYMVY4?=
 =?utf-8?B?T0xDcmFZMTBiNGpZQXk0azBSblVwOUE4WUtOOER4Y3l4Z1hjMm1CbWRCcks3?=
 =?utf-8?B?RmV6cWJDbXdQZnNocysrcWJwaXJUOXUwSWh4VFR1cWNRQWluUkRYS08va3A4?=
 =?utf-8?B?SkxxTThpOXl2SWgrU0lhVUVVa21IT1JMdDg1d1c5SFYvTXczTThPNWY0Vlcw?=
 =?utf-8?B?QzEzd2dkOHZ0VUptc2luWVh4MTU5QThHQTRaQU5nVjhOSGZIb0pCVW1zcThF?=
 =?utf-8?B?dUpwdWFJMGw2bHZ0UzhoTWViQ2prNkUrZ1RNSkt6WTJsd2VIYUkzai9rL0pJ?=
 =?utf-8?B?eXdKTTRFbG41UW1RdzdUZ3g4aXdvUSsrVU91MnFEZ1k5Q1krN2ErSzhnalJy?=
 =?utf-8?B?NmdHUWl5WFByYmRWUTY5LzBFaVNVdCttUEJkOTlxU1NiZnpxNFdFdWhreXg0?=
 =?utf-8?B?MWFuYU1WbndmRm1sMVhKVDBjRGNudjVGYUtSV2ZCNWFUYy8wOEZKODdQeUJV?=
 =?utf-8?B?TXovRGVaclVCYWgzbnFqajRRMGxncmVpMzRJanZ1OWJDNlRiWHpDMG9WazVY?=
 =?utf-8?B?ZU51N3NCMTE0eTdEaFAwdVEza3IrRmM2TGZJSnNLWDhYTU9vVnZPMFg1cWU3?=
 =?utf-8?B?WUJpNFpkZmdvZ1UxY0NEWGhBZHpFaUpxT2JGTjErTGRyb1M3MWxmVk1KMkV5?=
 =?utf-8?B?bDNoVnRrTzJtMEtFQ0NweEk1Ny9DaVFGblJiVHFZYmh5R2RxY1JqZkRGZjYw?=
 =?utf-8?B?ZHNjc05pS2l2U0tEMjg1SFM4NStwaEhmSUJWNk1yNjF3dlAyNm81V1VPbW1O?=
 =?utf-8?B?NUttelgreTNnSXpRVTVRV3lqam53TFR2TjNsK2JqUHBGY2U1ZE01aEpkdGlm?=
 =?utf-8?B?a3FwZjNQa1lWemFiUFFpR0dqZnRYRkpKbnluWExvbzdwbmpBUUZlRmpjU0xY?=
 =?utf-8?B?QlY4MDVRUTR4Smt1Qjk5djVrTlB4WE41NFphaXBEZENtcXNtL2J2bEk1dFBD?=
 =?utf-8?B?eXJRZXpDZkFYbXFzQzhlMkRqRFdPM0JUQzhnZTRMcjZ3UWJOU0h1cXArTGFP?=
 =?utf-8?B?VFRvOGNzZjY0YllZOGpPQTRrMUJ3QUpNYjZ1dXAweExIc3VvYW5rZGJER21Y?=
 =?utf-8?B?UitjMllrS1QrdEM3YmpBWFFZVHQ0RWJTQk1Bc1Q1Q3gxelE0T1YxcGhhK2tr?=
 =?utf-8?B?bUo3RksxbkRLa3BIUzhXYU5pdXBMUEswN0FQdHR5WHBGbkNpRzdnT1VaT1hR?=
 =?utf-8?B?UUhYSGxWRzk1OExiaHpCd2lFTXJiRHNPZDB5VHJ5ZmNabG9KZzVRRnhFcWYz?=
 =?utf-8?B?ZUlCODdqNzZwN0h1WVN2WDB0RUlNUnAzM1BtYnZkc0xwVjY4RE1tNHFJNGpJ?=
 =?utf-8?B?T1l6Y05JZlNCc3ZkQmx0eGpkR1BkRC9hRU1wWHJ6THJMeW1pY01qSmtORXVT?=
 =?utf-8?B?WWpmeVFCTVJKeG1tMDNJdHVGMlF3bEJockFVVkhFdzhCTzF4MHRUaHFOdHhm?=
 =?utf-8?B?cDg1R2hCUm1xZitoYjdKa0JIYkd5WnZjRzVRRlU1L2pUZ1E0RGxnUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54CD51E3F30D114990B72D0614DB4ABB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Dj/tutHTwoK52CIMngdpGxwelCibu+tTKflxJl2ix5XG+ZvdY3ZSLzRUtx3KbP/UbWRzbXdCstFXPUZ8HbUuPAZEjtc9YNrecGm4nxwDNe9ZWY/5lywemFoBkvdpW+r3lhNHlrHepRjKGvjuhgvtXMf4n+AziSwFF4lGAgs1sjfjZoxJyHtXLrtJ+MnIabXy3NFSy35A4u7Bd5pDIKN7E+BL9ZkHLb6AMs5+kABNpEn7XQnYz6rLJSiurnUUkP81KtTkcF8ZHz41O5O6n4oDjYO/wCT0V11Sosb7uPucJ9DSWEBYtYIipmoHvRzKjjWiuMY9vBFwl0coq0fxXVQ6CA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01386bce-96c1-4d39-3370-08dec236517e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 12:39:28.4241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcVWyKpc2fJoD/PVdS+ImpFB4tKlYfCZen02yAnVbD5qMXXHUiX3P0/6uKkWKlT1KpCcg/qMrXSwEoDrXYBGPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5780
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBEZWZpbmUga3ZtX3tnLHN9ZXRfc2VnbWVudCgpIGFzIGlubGluZSBmdW5jdGlvbnMg
aW4gcmVncy5oLCBhcyB0aGV5IGFyZQ0KPiBsaXRlcmFsbHkgb25lLWxpbmUgd3JhcHBlcnMgdG8g
aW52b2tlIHZlbmRvciBjb2RlLg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xl
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg0K
