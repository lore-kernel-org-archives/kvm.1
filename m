Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256FC48C3F1;
	Mon, 18 May 2026 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123467; cv=fail; b=RuHlbfvDYn0jyFJVY+Zg8AUZCwZ2HToXx7MkDwJI6aj6pWDCJXsMf7Cbhw7NSjkhYrjgOIPIX+EUW7j6XFVD9F+j1XprAWCt/8ThbPLPcBVtJj7MeiX+vfvmU62bqv7OlreZKEJFJyWlAIJs4FpX8eRMwYkNnmHN1LtO+KWKzHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123467; c=relaxed/simple;
	bh=Kt6Ke6Aq/Fy+Htyjk1wmkCjN7OKGj9cP/gL0yiXOCdU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AS3FzCnNgBuOtctMt8zfNFlLbRoCkn2/ss2bv1rrZOoWK9KXqpL3oHQ0+EgK5vmuDAs7M2p+CGX3BEwpeOJBjFD396PSlS9zyG3T1rHjqXQtYF2AWkRvQlE9A9Uzn0CxKaf6XDKjI1Ajt4hYt9bJD5gK49Z/EBhCM26YuDrJJzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmoFweo5; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmoFweo5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779123467; x=1810659467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Kt6Ke6Aq/Fy+Htyjk1wmkCjN7OKGj9cP/gL0yiXOCdU=;
  b=lmoFweo5YGKoegKFHJD+4pjhiBdf7d4STZJzh3rCrOntxF9LhOedvmAl
   3bcXBK1EerSV4DoYGjug8m37Vcr9YMfiwaT2cuDfOlE027QTu3jD0gD5y
   tJ4SMnfrlZoCWjY0tNBSHYN98+94eHoXHLqjxLMJf1pi39OqwRWHU3oCd
   MhkAcGRqdgScfC6vAdp3SWFJpulJeeCXNByDovKXiFf5RjbKf4HDbbtP2
   xg6m1GtuFO22p3qMn42z921KIfvemX0D8o4BrxYhmxUTiMd8+Zc/a+ZnO
   lCVZ6NXW7v6gWikU8F+6mPTYX2IyccU3LgmFeGtHZPDO08b2u0eAvc+Ny
   A==;
X-CSE-ConnectionGUID: L8tA9dNgSqKWiieCd3Spvg==
X-CSE-MsgGUID: 1uqXwpSkRMqVv82JGjQ8wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="80035334"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="80035334"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 09:57:46 -0700
X-CSE-ConnectionGUID: k541BnXkQHidZFEXFmjGmA==
X-CSE-MsgGUID: G3gq/Q/GTnyxvJ4N+Aoh/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="243465223"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 09:57:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 09:57:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 09:57:44 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 09:57:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IS3ZqtEi2HtkLR1Sj4SVcpKiqtyaInnXJfAvwyhQ/WN6KT3e8m0jj78rJZnn+PSGInaSVw2jn/c1S4et9P/ey2viX0R7BoWYgZJh4GNXi9QupYSMjaOYsF+Mt/SJpnYLLjPgyIsairVa6ztjSFyZyK9WIaQLVC79oBFAfznYPmfHPlXC8PPldIPVXlUthF4MBx2O38LapE6sEtJp9aGFjh5705zmoetwhNn9LclTGwn3+WxHlSTG+D7+sLiGMpDK7h0He1vkmoop9PJiVUk+CtuorBkm0VS4v3gw1YGworb0FNgsAKe3y89EI9+oSWsr58iU0G3R+wPWzAjrFLZf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kt6Ke6Aq/Fy+Htyjk1wmkCjN7OKGj9cP/gL0yiXOCdU=;
 b=ko25j2DBl8M6X8xOM4PIBXmJYy4RAwob/Ek9AxnGRE3DVR5A05V7JJV87SeEwk2jXMVoLHui8dtjtpRP1BNGciYvSRvNvtKRuBHmcuZ/spKMRpAjE36czMPmYfzHwRHgUu658gi+aqixWqyjj0rsbMvAezSTseu9fgY7bEbAY1Y96Mzq9XOK4MFfo9pfMYQQ2Jelp7iyyV4Gu61QaSgl0xFR6f68DIAGmPHs8EjJaEiVBjU8DCHIX6p/2taXB/6STnPIPtKHeXOF0ySR6zrtbyb4CXb7Cj8HmkBbKWPIFnatluMCj4qAl5hsJ0FmKe/pGsMA6+C9dzUeEGvFRqvDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Mon, 18 May
 2026 16:57:37 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 16:57:37 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Gao, Chao" <chao.gao@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai"
	<kai.huang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "kas@kernel.org" <kas@kernel.org>, "Shahar, Sagi"
	<sagis@google.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v9 02/23] x86/virt/tdx: Move TDX_FEATURES0 bits to
 asm/tdx.h
Thread-Topic: [PATCH v9 02/23] x86/virt/tdx: Move TDX_FEATURES0 bits to
 asm/tdx.h
Thread-Index: AQHc4urTVkFyyS3v70qCqCVz/hQDRLYPRleAgAQqdACAAJg5AA==
Date: Mon, 18 May 2026 16:57:37 +0000
Message-ID: <68e91c7ae1d10bdff73dd178d0e4ee48eaf1cfe1.camel@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
	 <20260513151045.1420990-3-chao.gao@intel.com>
	 <c7d64460-d03c-4198-9320-8afceafcecb5@intel.com>
	 <agrFTv8Lr3HeNM6P@intel.com>
In-Reply-To: <agrFTv8Lr3HeNM6P@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS7PR11MB6077:EE_
x-ms-office365-filtering-correlation-id: decdf603-799c-41df-116f-08deb4fe906b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|38070700021|11063799003|56012099003|4143699003;
x-microsoft-antispam-message-info: 2lA1k+jYQ8Q5JPtQ6NvHcmsDLgU+3zEarITg/WEDgtqseeqF7EL6OZlWl44rlEn1koHWhfmBaqpvSFwDuSWNvdjOWjchh1Azcp1gU9ktDSkLlaIooMnYVFjPWZrAuF4ZTr92MZnnH/2HDqtVxnk3RZX1C9/N7WLixVNKlUmxHovx1IGzjZbFQCqG6ZlNRrumv/Mce234ElQLJp+H90HdS+tYuUOXO+2OuXlh1OPF/43/gLJkyZ8GBDnlEmYd/IheUUrxCwqrbr71VFZiG+nMKtQr2GiSgyGjt2g9ybqR0P5XlA5HWHAfp2J4ohS83rp7EcKxUTuvKNikQg5pF2WgeqYX8B1sCIqbWYCVzEHIjiSCfGnpBsH45RnjRzjfmbxUn8GXC6qK3ya7mzGUo8hK1IyzrMcCwGRnwPYcJnO35GRL7BuA2Kedca0EUrh0cmqAhHkMb2nbwRz9duMZTZKjMCl1NPnDazeguhuYRLgoJGTeCc3eAw7kOSH1x8w+3i3mgChi58HcYWiX1nBCgAn9aQk/x/zIc2Jp9PT2A0SXA5TKyvdenm6CHivoFcWzAyQKQoCz9uCT6wYWiARrBz2T6qOoPcRC2auSxXWUeFjYtzQmu11a7vafCf/Foh+NgcgbUaceynd9DyINJkkLLaQZ2hvL40alvGR/x249jwqYfLED+04Agp+mt890RITfQzoLu9fbRrOuzDu7xdiobz+lQV6s8GyDxlo6BlehjVi7KIwj26oVm2iutpgMkhQ0j+Xv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(11063799003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnY4d05LUGJkZEFSc1RnQ2JCVDdBRExQT1poYUlDQm9qNnM5L0ZNcVRqVDQv?=
 =?utf-8?B?bnRqNjg5eEwrMElCWjdlRGdnR0drSTF2Y3YvaFpLT2RKTHB4T0VFc29mUzFW?=
 =?utf-8?B?UlZ2UXJrWnFRNmJOSDFXMEtQenZ5OGUvY0IzOVpGZUNlSzJ0TnlWTW1WcjU3?=
 =?utf-8?B?QkRJcWUxMkRuSWt0dU9ocUdIZmRyVXRtVmptMG4rekRxTnpjc1hZSUF3K0ZF?=
 =?utf-8?B?aFo3dTFCRElxVmFhSjArOWlDUE45L2NGcFNvbTJjWDcrWFlvbHJoVTV3R1J6?=
 =?utf-8?B?SnBtcm0rajVHT1hDdTFueGhScWNNZ2UrTzJibk1Fa3NiOTVDN0d6U3ErckNh?=
 =?utf-8?B?UmRJYWlUUEhtV1NHNnE2aWtuL3pVbUpTTXlkMUxJRk5DZDZPK3QzVFluZVJs?=
 =?utf-8?B?RnRZbWpOMDZPdlJGZk1JbDgyZWp2ampzK2xHTE10ZnMrUS9uNVNaS1FucVZW?=
 =?utf-8?B?azdYNkpOdktuTXNNa0htekY1bjJjNDZxZTNFZythZGxaazFNSkhUa0VEVnhQ?=
 =?utf-8?B?QitGdlRoR3QrOXEyK2VXMFl3Z3cvVFNKQlgxdG95NEZlVW50cWtHeVY4NG5L?=
 =?utf-8?B?UzNCYzJmS3Q3UUNIeHZEajB0R2RqNk1ISzFQSlp2WWNwU2cxME1ZaHNLeE9N?=
 =?utf-8?B?dXZCVDhsVXYrK3JpWHBYRk45M0FzaFErUGlJMzJxcm5pUytyL2lPWVJ4dk01?=
 =?utf-8?B?YW5oU1hjcnN4NVNyRkN6VE92b3dyV0pjYmF6Z3VlY1ZlMjZSZjdyRFdVUHMr?=
 =?utf-8?B?d0tuL3pvQ1JsWWp0SjJ0OXpMWk4wSTVPdUttaThDSFdPL3c2ZlJZNXlTMVpx?=
 =?utf-8?B?ZnUyWExOZ1BMMEdSc1BIejd0NzhNcTVYWXByMUM0eDlkOFJJMDZ1ZDJHakhQ?=
 =?utf-8?B?WlU2aXpzQmJXbVg2YTJ0M1ptSjZ0U0hORXdqOFBGUkFWeUg5TWI2TmFPdFVP?=
 =?utf-8?B?MmY5UXRjWWlXb01BMEZMTjV1cW9KVG9Cd1pYNjRhNkFzdi9EUzAyOXhWa2w1?=
 =?utf-8?B?a1Irck80d1g5cDBoUEdEQVI3eUkzWC9PZVgzbFZTRHRsWE93RzFTcGJVMXA2?=
 =?utf-8?B?WTE1cFdyRTdCZHFUSmNUYmRCY1BRL2s1ZnM0bklMVTliSys4aTZBbmN2c25l?=
 =?utf-8?B?VFgvMlRmNnBkbkNVYkViWUdYaEZKbTEzVnVRbFFzb0RDL1FSMzhmWUdLNXRG?=
 =?utf-8?B?WXd3bXBGdkRJaWVqZEhlZGw0RkpJSzhxMjNvd0pvTEtqbExyZUdGVkVrRDhs?=
 =?utf-8?B?NG5IQUxPamp5QTZONmNpLzhNbWNFR1lxckxqUkkzdEs3cUpqWno2bXBXVDBx?=
 =?utf-8?B?MGJLTXRDNXFHMnBGTlJFVnpMOVZsdlhsT2dhVVN5VVEyRHNiU2dVaG95OHJD?=
 =?utf-8?B?aU9qanRoZHpMWjdWaEkrYXVad2s0ZUo3WWZEY1Jqb0pXdEpab3dxWTV1VVlv?=
 =?utf-8?B?S1BrS0tCTVlrWTJDMTV6cFhleTdBRE1NTjdYTlIwa2dWRjRHRnJ2RElQYi8x?=
 =?utf-8?B?a0kvK1FNYVE3VWd3SGN4VmVweDZOOHJqVzdhT2dvZHlUMVNWcC95aVVVYXJa?=
 =?utf-8?B?QlFKdGhqcDJGU2U0MzdGSHZVakI5V1ppdUlMcVdRV0E2SEd3bnRsTzVBQVV2?=
 =?utf-8?B?aFR4dnJXdVM1MmVQcDZOdHYzRk5nN09QREozY3IrVzdWa2tYWWgxZmJFTDhJ?=
 =?utf-8?B?aWZtWnNuRk1sM0FtK2ozMmVXWjczQVB0QWhMV2tYQk0xZXNqbTBmOHlyRUdD?=
 =?utf-8?B?cXdQTk9uVC9JMGFBUlRTVWE5NmU4VUNZb2I1Y2d5eXluaUs0ZHZRb0llaDRL?=
 =?utf-8?B?ZTZUQ09pNzV5VWF0dnc0S1ZnNWU5VDVuTGwxM2pHQ0p5YnNVN2xQd3Q4cmJC?=
 =?utf-8?B?ejA3bkVicDBxcjZKaTRuMHF4ckVMdytJMHA4dUxUN1RDbnpKQTZ0dzg5L0Yx?=
 =?utf-8?B?UngyTURCN2gxRE9DZmNFTXF1eEM4Tng1bnl3ak5YY2xoMkpTb2tsME1GMFV3?=
 =?utf-8?B?WEZkZ3c2cGpCMFRwdlFXa2s2L1VOUVMrbmo5eUZVMXJDeW9ITGNJeml1Zm91?=
 =?utf-8?B?dy9xVndGekJJTm42NDQ0eXRqUEI2dlYrbWFpOFIzN2lvbTFuUEpCTXV1ZlpT?=
 =?utf-8?B?N01YMXVqc05leVY4eElnRXdoL1BVTVRmL0NNQ0FJc0l1SFB2NDkvTmV2UkF3?=
 =?utf-8?B?b3NtVjUzUjc4RWRCYkFORURkb1drZXRIK0VXUUJPQVRxU2N3UFFzVHk4NFZs?=
 =?utf-8?B?citVK2RiRXdHZmVXamtpRFRBUWxSTHFIU01qMWxjcWlyU0JjS3c4TmcyRVVK?=
 =?utf-8?B?U1dNWkNIa1l4RHMxdGJ5S2FPMXVnZElvVU9DNDlwWHN6a2NkeFdTbmlZUkZZ?=
 =?utf-8?Q?woJGKOXGiAAYWSY0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D758C862286A649A04FC3E7E00EFA93@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nLyHc5cqiagEiW+lIhCkNK9CQ9gbwUjEOn2sJlAl7dgmjX6mgWod93EBHigEE9YdWqeL7nQoOTtXWtX1J5yR5gCc83K4mkzwn+aIM3OWiqVz64bwBYZO64ooLOLtR1h7J4Udzr+yZge9s4czBWdGKuRlapfmzgBew9RhjwstTc5nyxY3sbnU07nuK2UcpZl0SNfMxeX5R3N6sJBlcy3GB54KBio76xMIs9oph0lM9S7sVQQbnXsQYIdaBOmOA7+wCe6C5G3UGXM5eVMwt4rq4COubEvvx9TcCrsVtSCO/ExzVD2JMr4BS9vZitEXwiu9j4dW5SvA0MOAQeZ4Be1KxA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decdf603-799c-41df-116f-08deb4fe906b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 16:57:37.0462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xoLKS1LrilPPdYrDpObEtDGPM47C+0gTx5xbf6M/f3A2oKIi8vJspf9uoo2laIsDw+Ipj8YCSIN9wBcc+RvhoVfNHypAa00JEVoGRJ7zBBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6077
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA1LTE4IGF0IDE1OjUyICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gT24g
RnJpLCBNYXkgMTUsIDIwMjYgYXQgMDk6MTU6NDdBTSAtMDcwMCwgRGF2ZSBIYW5zZW4gd3JvdGU6
DQo+ID4gT24gNS8xMy8yNiAwODowOSwgQ2hhbyBHYW8gd3JvdGU6DQo+ID4gPiBUaGlzIHByZXBh
cmVzIGZvciBURFggbW9kdWxlIHVwZGF0ZSBbMV0gYW5kIER5bmFtaWMgUEFNVCBbMl0gc3VwcG9y
dC4gQm90aA0KPiA+ID4gYWRkIG5ldyBURFhfRkVBVFVSRVMwIGNhcGFiaWxpdHkgYml0cywgYW5k
IGJvdGggbmVlZCB0aG9zZSBjYXBhYmlsaXRpZXMgdG8NCj4gPiA+IGJlIHF1ZXJpZWQgZnJvbSBj
b2RlIG91dHNpZGUgYXJjaC94ODYvdmlydC4gVGhlIGNvcnJlc3BvbmRpbmcgZmVhdHVyZS1xdWVy
eQ0KPiA+ID4gaGVscGVycyB0aGVyZWZvcmUgbmVlZCB0byBsaXZlIGluIHRoZSBwdWJsaWMgYXNt
L3RkeC5oIGhlYWRlciwgc28gbW92ZSB0aGUNCj4gPiA+IGV4aXN0aW5nIGJpdCBkZWZpbml0aW9u
cyB0aGVyZSBmaXJzdC4NCj4gPiANCj4gPiBQbGVhc2UgZG9uJ3QgYWRkIHVubmVjZXNzYXJ5IGNo
YW5nZWxvZyBjcnVmdC4gSWYgeW91IG5lZWQgdGhpcyBtb3ZlIGZvcg0KPiA+IHRoaXMgc2VyaWVz
LCB0aGF0J3MgZW5vdWdoLg0KPiANCj4gU3VyZS4gV2lsbCByZW1vdmUgIkR5bmFtaWMgUEFNVCIg
c3R1ZmYgZnJvbSB0aGUgY2hhbmdlbG9nLg0KDQpJIHRoaW5rIGl0IHNob3VsZCBub3QgbGluayB0
byBvbGQgdmVyc2lvbnMgb2YgdGhpcyBzZXJpZXMgdG8gZXhwbGFpbiB0aGUNCnByZXBhcmF0aW9u
LiBUaGF0IGlzIHZlcnkgY29uZnVzaW5nLiBXZSBjYW4ganVzdCBleHBsYWluIHdoYXQgd2lsbCBj
b21lIGluIHRoZQ0KbGF0ZXIgcGF0Y2hlcyBvZiAqdGhpcyogc2VyaWVzLiBJJ2xsIGNpcmNsZSBi
YWNrIGFuZCBwcm9wb3NlIHNvbWUgdmVyYmlhZ2UuDQo=
