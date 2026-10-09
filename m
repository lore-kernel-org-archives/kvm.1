Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7563B0595;
	Fri,  9 Oct 2026 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572336; cv=fail; b=EqowYYY/qu7PUhH6wzhKKBPy43mJqjIpWuX8f6bumrK1a73+Ap3JGR0xweeMBBGsEMJr+lZKtxyxXl1SCDbv+swj3oq0mA6ndYrNv7B2DBxLdqSiEn0/PG3cIChLf/HEy4dJGJZn0IVdXUz/Id3iRwxHK3oETA7gg+apPHs4RBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572336; c=relaxed/simple;
	bh=Ij9+TvsEeAYlejWPDeNTbw/1KIHAbw9AOUfqaX0NGHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RiFvFCj4y1a+mCVnKqXmPvbBA9+wbHf7G5rhBtoZbpxdZprUpGh3IaLZUiN+27kab55NjmsZplbc7D65Rc4lxTysE0DR6Zz9RChXArJpP0iJmyAKFjO3S1rPUqk6GNWQAfVtpR6TSzUTqoBzv/VcRl+NW2+/LIvEYUokt8oGGTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GT2bcDlB; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GT2bcDlB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791572334; x=1823108334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ij9+TvsEeAYlejWPDeNTbw/1KIHAbw9AOUfqaX0NGHg=;
  b=GT2bcDlBK+m6IDWjSFJ6uCQGS2NRLowlbAF9+clMET1L3kd4uPV4A980
   ofuE+ywOGkfMlLsOPeWS3UeMBzvVOQXTEW/D/ndhttCEfRVPrtdauvhdI
   NiTMUfLYAslsNuMUr+L6w2D9H2vOJ05j/YmJjUYBM9pALDcE0qsWjYc46
   K6AUuy1quW3jwvVtrAwuq6UR1fOGhsm3hNdgeUnvZzinPs4BCmKTqGq2q
   N6P0A+hZ8muuTV38zM7rjOz8yc8nvhfhZ6aU38ZR4EAxyy97apvVVrom8
   b0QYSRncySF+ZPx60aitQ2hkRrrTLVK/EV7LRM51Q5868R84xjMbQX8p/
   w==;
X-CSE-ConnectionGUID: uYgH30AkTVehIF6tsB7NdQ==
X-CSE-MsgGUID: Ax07PjV4SeKPN2Ck95g4mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="384926"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="384926"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 11:58:54 -0700
X-CSE-ConnectionGUID: Kt+2cKZtQVO1tmeDj8icJw==
X-CSE-MsgGUID: XIbcmNXZRLWkYQuIMs1oug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="460573"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 11:58:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 11:58:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 11:58:52 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 11:58:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQXt5tk6gTrJdb6IEwfPYr7ljNEBp1CH0PiRTjU3C8QzXeFvGBv+YqJmUvm+NzCjb/MSG4+6ssSvDZU2hlZiYCKIgZcX0ZfpnW2r/uTTOc3TYZhyBCU6gW5Vv1M5TBYhboKibKpUtcl9YGBCCyHA/KJ4GblvKMnAI+EC6kQGogoFXPuUiXwDDXehqVU1dC/lWFc9CN0yPcjGfwqi6hC2YXpo1/sCkwccGpR66UFbb2axzi1+4cCHCOWMCmlU8GLG3NpgqDyRKypsqD4PuyDVCBw/ibZpMZptxtq6RCvRSomsR0mmUg7PP+R/6Y3l+HJmpvpUhovl4taYOJhoTS2irg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ij9+TvsEeAYlejWPDeNTbw/1KIHAbw9AOUfqaX0NGHg=;
 b=X4IRl5nVCp6DkavlT0lIlfT/14g1tErV11kkXhEdaqbaLOajlgA9r0WbXBtUQML/LuL/VhXbeX8+fzC2IeiCIsAsSvrRss3UO4hIXQIal5oq9ol8Bj8YQ6n9YodU4TkHVb0ZziiMCvr9vs7YNqy9oAXpIX2x4MnrKNdut20xUsGJkw0hyhHo2zWaz0oF9LBPQXXXtwBzWIwLtlUVUsh8UbkCOZHxM7uRQXQ7ez9ypvZf0mtEj70pIdzcjEyggZbyK8Y4kNe4JC3EXxxcGMRBoGa4RrBni4969mYTTNvggZp350Lbeisntk66peOp8iYF2SQvjr5bFB4wDNBpzTcJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 18:58:44 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:58:44 +0000
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
Subject: Re: [PATCH v3 3/6] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Thread-Topic: [PATCH v3 3/6] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
Thread-Index: AQHdVPFrwePQkhjz40qYtvqh1oXdVLb1loYA
Date: Fri, 9 Oct 2026 18:58:44 +0000
Message-ID: <e6207c3e0443be4ee120ad4ce2b10359f7769964.camel@intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
	 <20261006-tdx-module-ext-v3-3-db52cb05b918@linux.intel.com>
In-Reply-To: <20261006-tdx-module-ext-v3-3-db52cb05b918@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA1PR11MB7110:EE_
x-ms-office365-filtering-correlation-id: 024f510f-1bb3-4a4c-e6fa-08df263757cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|38070700021|56012099006|10067099003|4143699003|11063799006;
x-microsoft-antispam-message-info: gDv144FDVf8eHXmQmkp09a1JPFBguaxuDqcaYjI3aW0SHid0aT4WCgh0rVXZkrP4xGR76Zm1Q7cwmX/86YOZLlx9NKriqyZKodl3oxYzrYVDHozpa2j3cd70mS1O1Rr89x8l0lDFAnYpXLYPe4WuEyxvGq2g3BQGMq23y+DS8yAC9jDzj+secd4jzw3PKZ9ZXTN33wypU6QDWckYM4I9ZN+meuAwQ1T8Q5dHDSmy5yu2S0NBdnqUlJcJbBJ555N5rN0Tl05Bdy36tUND4JxX6eEtouYYMZSbSosSSdk037s3aw7rP42NJlTC6ypwvmWLmwkS0WoDrdsyvnXbwD8LtcaEvKyiF32rVpSFEhDE4ITFUJlB9eCFOgqbVxxQ0B9yhKRn/EYofHh2Dy4EFkkBuLFTr7bJja5kH6NPvu0yBTx2WdzqJt8lkrwcXyb2OKKgI3yQBTT9zNa70muZQiBtWdUSGLHLhilVJhEON9ZwlgXEyx2pgcXEvSMEc9z1xRxWBK4lnnhngTV7LMdipJYeCukFs4ky3UQ0K8LGJcX6+DJf3UnWe8ErKuFGQkH9KKPCqR7dID4hOARhTH5GwqqrdMuaiZiDvZzUMHcFDwXCIGWZabg6oaxsB0iPet5+bhxQjwXn6+ySgDTrQPuno/AmxTBkIEbIUAKXreWS9frpCk0uJc9JJxBkz0VshMve3Q5fmBJ21Pg33z/dwtQwxWM9m3tSamH/2LaScUGBF031+7Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(38070700021)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUpUYkxEcVloalgzRDNhM2ZHdE44TDhNQ3VvdVhnbHpQSUkzQXk4OVRaaVdC?=
 =?utf-8?B?cUdUaW4yZVRYSlluTi9rQWk4OEQ5OC8vSjVMUy9DYUNYN3RVdlhoYlZNSVRF?=
 =?utf-8?B?ZXpRcHFJRU8vWkVHaFpTRzk5bnB3YmpSYVQzcmtXUVBYRzVGSkJvT2dOaks2?=
 =?utf-8?B?aU82Vm9QTWNLNFE3MEhydFdmOUFSOTloRTVlZHhWMkhPS3A0WlNpRE1LMGgy?=
 =?utf-8?B?czFUZVNDbFFZcVhHTFR6Mk9CbGgwRnRUMFNYWXFqeDZ1MmJPQXNIbHBwQVR2?=
 =?utf-8?B?MDBTYTdDKy95R2JPcjBUVVJWSVAySlgvMjZkRlUreDFFUTl2Q0FBL0hGaHlz?=
 =?utf-8?B?Um02WWtrd0ZkdXZFNXB2WTQ3RUtBK1N4NkJoL2JxSHlRWGVUWUltY0d2M2lO?=
 =?utf-8?B?OVRnOW40cXQ0aVY0YXh3K0ZTV1Fvb0ZBTTJaOFdWMk43ZVE2OWlwT0ZmOHdV?=
 =?utf-8?B?ODBJV3dQeGsvSmxSNW1tQ0FLMnhZSFpud0F4K3NYYW1iWitwNnFyV1BuSEEw?=
 =?utf-8?B?bnZIK0RWd2JsNFhRVzFMQ0M1d1M2RmJXUEVKbXJsNEQ2WVhDekpTY2dyMzdS?=
 =?utf-8?B?ejJQYlAxWXN2K0x1dGlNSkxheDhGS0p2emxvZS93bVdhT2Vybys5NXl6U29n?=
 =?utf-8?B?Ty96K1lvSW9WcWhnUmE0S2E0OVJLSHRVT2J3Qjl5WGRxeVI1ZHJvYnlHeVFC?=
 =?utf-8?B?a0doNlRZQTRteENrZXFzY3BmeFl2TWh2bisvdzVTdkovT00vazNtWFNPYURJ?=
 =?utf-8?B?R0wwS1FoUithZ0NkNlhpTkhJc05YYWYzZ0dEQUF5VmFJNUZUb1BRb2FWaHFO?=
 =?utf-8?B?UTE5LytCS2lSTDFvbnNLcUZhM2pFTzY3Yncyb2U4cENyRDcwSzhERUZjZHpL?=
 =?utf-8?B?VTZtb016UVk2NnhLNUxrZFk5QzlMeVRzTkV2Z2Fza1gzdGYxcjEwMVB0c0Rq?=
 =?utf-8?B?czkzMi92MnI5eDBxUEYrNHFPakpNUVI2VkxnTkxLK3E0WXhHVC9iT1BaRGRr?=
 =?utf-8?B?MCtiL1JSbU8rRzJOQ1Z0Szh0cks5UkdVa0lnOWFZdVRnTEs3RlVCWnptTHVC?=
 =?utf-8?B?TGw5SnVMbkt3U0k5THE5Y25UZlJYQ0ZjcnBBdlEzczBTYjZuN0FpQThXWHls?=
 =?utf-8?B?NjZjTG5jMmU5M0Z4bnJyRnlvMC9HQmY2eGxMNWJ5N1dNSGQ5NHpTOGROYW5u?=
 =?utf-8?B?U0J2QVI4MFBjejdDbXJINU5HT0laaVVjc2c4S1VFTUxWU3NraHBZSWU1dkxl?=
 =?utf-8?B?Nkk1OTFjZEl5Y1AxUjNaRVZwRzFST2gvSGJFVEtHMVZqMitFMW5HWmdJTVZH?=
 =?utf-8?B?cUx1UEhVbVMrRU1nZE1FT29GY2ZaQ1FjbkhiRFJGUm05bjBIZ0JCL3FsTk8v?=
 =?utf-8?B?RmZ1SndydG9YditiSVBwRFJabGNqT0FDZU9TRzFaNlR1bTFwL3E3WmVMSkNU?=
 =?utf-8?B?UFpHRlNISnRDSG9EZEU5ejk0d0oxRWRWNGhkWnJYdWY2RVhDRXJhdldzM3cy?=
 =?utf-8?B?dFBIMkxuTzY5WVM2a0szVGxocFhOMTlLcDd1Q2hqaUJkRWt3ZXN6SVFJYVlm?=
 =?utf-8?B?akdqclFmNUxuMVNyZ0UxTW9ObmdQcEpPMXVIY0twNXVJVTcxblZ2VmdORUZH?=
 =?utf-8?B?TGxZazZ3ZjBYbFVhV3RtMXJsZGRreHljeDdnU1d2dDl3ZjByOHJGZlFkNzJG?=
 =?utf-8?B?bzRINHcrdVpmZnJYYVZQS1ZFODk5d0ovc1NycXNIT0gyNmdMc1p2L3ZlcVBD?=
 =?utf-8?B?TVdZeE5Mai95S3p1RklrNC8yaERzNXh4S25XOUt1L2ttUGg1SXVjeDYyNk5N?=
 =?utf-8?B?NjhUdUxrWkpKYUZaN1NKbUFkWlRGSko0RHFtbGxNTitHa0orOEgzd2RkcXhh?=
 =?utf-8?B?NEFuMWh0Skxmbno1VDBodDgwdGxkMkRvVkJRamg5ODVKRENzREdmei9GdUZp?=
 =?utf-8?B?ZHd1S05sa2NMUTc1SWFIVHZ4N0pTQmZ4c0VVQTUxQnN5Y0hENzlXRzBYOExC?=
 =?utf-8?B?QXhIRVVCbyt1ZjdERnFzTXd0dkdYYmdRRjlTdGlpZ09WYzZGemNSUE1UcXNZ?=
 =?utf-8?B?WEFRVVRFZ3VLM2JabVJTNVM3NjZTWEtwbVFRUXlUa1pROTh4YTN5Ny9CUlJt?=
 =?utf-8?B?RUFTVndmUlEwNWVCanE5dWtnUzIwb21pTWFTeHlUMENmUXJtV0lUejV1Slhk?=
 =?utf-8?B?MFkrQTRyK3dMazZHRkx1TEw2cjVxMStvWkNPQ2tZanBJd25FY3Q1clYyY3Rl?=
 =?utf-8?B?RVZ0MG81YWVwWTFJYkxteDJkMEt4aVNRcE5NSWVqU0xTQnBmZVY5WjJDMDBK?=
 =?utf-8?B?RjNlVWQvaHFBZFlUcWIySERDSGtCR2NveHQ5YWF0UG83MkxlaXFVWHV4bk41?=
 =?utf-8?Q?AwwlaNlPeQh4LLw4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82693AED7590A34D8E3A40A2E10B6898@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Bikcx4thRNIVCLDbxs3ESXozJntXITd6Ee8eDeC58vhCf6WTIOXt8VeksOQfw5jb6sLvMqbtV4/8zfT7jPsgctrp9IlZDyqK05sXMfzhGCzt11him8uu7lFO7cQJUnMfDIyyk6GVWSnu8O+sG/uPtikH81N8d0TxYv5FrhSDENKCQkb1JP+Jk8MWUw/54zfLkqNYxtJ1aI3Tkd4oPRFAhbkqiGLoeSyrteUzV1QXqcL16wNMALHqm+GRDADTUhkUDMoz+OoA2OKIYyQtmut58+ApUHuisXqgAD8rlN4pvvtLbVWbX1M/cCBH0HH6ZCM5kUXHyx/jZ8hWiHOaMX1syQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024f510f-1bb3-4a4c-e6fa-08df263757cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:58:44.7822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DwE4OiwMQg4pA40YGDcUcU/0ch3xVAuQNKvC7Og+zUYUL9zCxz84mihv1Y3wAlBGX91tAxrHWOU7MgKir2evqsa+REUrZx2W4Q5y8eta7C4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7110
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTEwLTA2IGF0IDAxOjQxICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gK3N0
YXRpYyBfX2luaXQgaW50IHRkeF9leHRfbWVtX3NldHVwKHZvaWQpDQo+ICt7DQo+ICsJdW5zaWdu
ZWQgaW50IHJlcXVpcmVkX3BhZ2VzLCBhZGRlZF9wYWdlczsNCj4gKwlzdHJ1Y3QgdGR4X3N5c19p
bmZvX2V4dCBzeXNpbmZvX2V4dDsNCj4gKwlzdHJ1Y3QgdGR4X2hwYV9saXN0ICpocGFfbGlzdDsN
Cj4gKwlzdHJ1Y3QgcGFnZSAqcGFnZTsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJcmV0ID0gZ2V0
X3RkeF9zeXNfaW5mb19leHQoJnN5c2luZm9fZXh0KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1
cm4gcmV0Ow0KPiArDQo+ICsJcmVxdWlyZWRfcGFnZXMgPSBzeXNpbmZvX2V4dC5tZW1vcnlfcG9v
bF9yZXF1aXJlZF9wYWdlczsNCj4gKw0KPiArCS8qDQo+ICsJICogU2tpcCB0aGUgbWVtb3J5IHNl
dHVwIGlmIG5vIG1lbW9yeSBpcyByZXF1aXJlZC4gVGhpcyBtYXkgaGFwcGVuIHdoZW4NCj4gKwkg
KiBubyBhZGQtb24gZmVhdHVyZXMgcmVxdWlyaW5nIFREWCBtb2R1bGUgZXh0ZW5zaW9ucyBhcmUg
Y29uZmlndXJlZA0KPiArCSAqIHZpYSBUREguU1lTLkNPTkZJRy4NCj4gKwkgKi8NCj4gKwlpZiAo
IXJlcXVpcmVkX3BhZ2VzKQ0KPiArCQlyZXR1cm4gMDsNCg0KTWFyc2hhbGluZyB0aGlzIHRocm91
Z2ggdGhlIHN0cnVjdCBqdXN0IHRvIGdldCBhIHNldCBpdCB0byByZXF1aXJlZF9wYWdlcyBzZWVt
cw0KYSBiaXQgc2lsbHkuIEJ1dCBJIHNlZSByZXF1aXJlZF9wYWdlcyBpcyBuZWVkZWQgZm9yIGxp
bmUgbGVuZ3RoLg0KDQpUd28gb3B0aW9uczoNCg0KTWFrZSB0aGUgZ2V0X3RkeF9zeXNfaW5mb19l
eHQoKSBqdXN0IHRha2UgYW4gdW5zaWduZWQgaW50IHBvaW50ZXIgYXJnLiBXaGVuDQpDaGFvJ3Mg
bWV0YWRhdGEgcmVhZGluZyBzdHVmZiBsYW5kcywgd2UgY2FuIGtlZXAgdGhlIHN0cnVjdCBpbnRl
cm5hbCB0byB0aGUNCmhlbHBlciwgdG8gc3RpbGwgcmUtdXNlIHRoZSBtYWNybyBzdHJ1Y3QgbWFw
cGVyIHN0dWZmLg0KDQpSZW5hbWUgbWVtb3J5X3Bvb2xfcmVxdWlyZWRfcGFnZXMgdG8gcmVxdWly
ZWRfcGFnZXMgdG8gc2hvcnRlbiB0aGUgbGluZXMgdG8NCnNvbWV0aGluZyBtYW5hZ2VhYmxlIGFu
ZCB1c2UgaXQgZGlyZWN0bHkgYmVsb3cuDQo=
