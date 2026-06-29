Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71B13B95FA;
	Mon, 29 Jun 2026 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732440; cv=fail; b=lQfyMpYHAIdfM/QJBNspEDIZrWN84SRr4EJHDB5buoM7K+WWwCKGmA286zrxwA4VChD8ABOrY1EF+77G/4kBeIphis2GdURTI9zPskKdac+e7J8fmuOdoksVxhpCeJAI+j1R8AdMgdVxEXjZconOEj+HUV/5dwhv3jmbhjzGSPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732440; c=relaxed/simple;
	bh=12FpK/jy7n5w4LTJp7MxYFVKfjyvuO1wGHu3q7YkKrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TcZPYWPU/1JVe4cX4NihpshR4YN5AzlF+UJi+gmORU4rEw0CrWedLrmqUghan86UNbB1SiOvqBltPT835eD+t+X7SQSts4AI0gefE6gi5bYgnWCdrhcNLBaRspRH5fDGiSOyQ5psmyWH58v4Co4i6a5G9ujWQKZrJUT80+dBPiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyIb6O7/; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyIb6O7/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782732438; x=1814268438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=12FpK/jy7n5w4LTJp7MxYFVKfjyvuO1wGHu3q7YkKrE=;
  b=QyIb6O7/I78+9xj/xRrJ4BgsSwDnEBZNXIn3DhDboZYcj0zMh/myCDSc
   hKXFHkYjUIAxyltxjDkZlJserbcyrhYjX8IyX3lgNLgUPxkJM0ae9TNbo
   E7Vx6/wvwe1th6WAcoO+bMu4XYtGE9O/L4ma8fGlfEE0Gc3/zCugTzBs4
   8JRY2V2N3JGnbRjxrlTL8NNXLJV1RT7p3VeO7QVbTJggVSIaUQa9VvUvu
   NCw/IrWZaov/v9E5CjYKxFVfu1TF8DHmMX+P3EA8rCT64Rmp15WvoyVYN
   zJMDgaAxlozHvWdJqJ6tj1+I0c0sKwYjZUqt3XJaWbtiHmPkZZG5qttzI
   w==;
X-CSE-ConnectionGUID: f7q7pk0MQQa6cw6Rk3+6XA==
X-CSE-MsgGUID: wDYnKc/zSEiX37HPsbnAhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="87258449"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="87258449"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 04:23:24 -0700
X-CSE-ConnectionGUID: 6N0jh339TTuCdx3T407mIA==
X-CSE-MsgGUID: GNsZsvhTSMuKKifVyp8g4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="251539776"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 04:23:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 04:23:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 04:23:23 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 04:23:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hz0wrYoXb1oWf74rEsWoiabULBN3jMAs2yQ9QhIKqPRvNl2K6ubIxEyGtkgzw1mY8v7o37ynMrfA8a9vKmjlxzYE4rgXwm1rq5a+SGa0A/Tq7OVjUDmCUedXAVB/vbXRx0BPb3KEfWCtAp2Q8qVDsjzte9kGf4Iu/ysFSbQUsqmHKsANwqFu4OmKfXK2TxWmXgE8JiyZ8mQuyTzxvgFUe9vcKnre6p5/XTUkEzWzhJJxjWcp5rtsn6KFB9/H8JjS0g/L/2ffRQYG17ukRvC1kRAMbET6D2MLU4MJY7wc0HPHQaTBrc+vK5NrGAZShVQPIW1O3+2ERj7YJR4EYh4c1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12FpK/jy7n5w4LTJp7MxYFVKfjyvuO1wGHu3q7YkKrE=;
 b=EhVtPVrRF1z2LZfO71pNSOxvOiMkaFTYUtiwYrK/LCtyEozlXnq3MFITvoQpavDzqmLFmJhSNnK9P0A2HlWWRNwd9ywX8u8DHWZpCfsOZA8fck5lxQlajCyY/XnjybzGOr0ipBcTT/S77r1eD97UoYRy9oxAri2uXvxaELLD73wbldOA46RdJFDDcJrImspEKpKOtiHmUEJGD+eYDENpRjKwdUVVCovJC6blWek4sJg9Y1bv/oLf41CTXuz0/JPaYst22en6zYJcaBuKNlOkShxexGqiS0QhW9Qyb6VRgnUGhed9p/BG6vCd0477B8HZYQYaz8YsUIoUmt1sDZBNkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4691.namprd11.prod.outlook.com (2603:10b6:5:2a6::21)
 by SJ5PPF3F833FA49.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::823) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:23:20 +0000
Received: from DM6PR11MB4691.namprd11.prod.outlook.com
 ([fe80::5d52:baaf:8c72:ba5d]) by DM6PR11MB4691.namprd11.prod.outlook.com
 ([fe80::5d52:baaf:8c72:ba5d%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:23:20 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86: Ignore pending PV EOI if the vCPU has since
 disabled PV EOIs
Thread-Topic: [PATCH] KVM: x86: Ignore pending PV EOI if the vCPU has since
 disabled PV EOIs
Thread-Index: AQHdBCWnns3dykXXyUWZiAS1Gt6Yz7ZO4JMAgACHB4CAAIkuAIABLbKAgARMmQA=
Date: Mon, 29 Jun 2026 11:23:20 +0000
Message-ID: <3c0f96a316a968e5e0301f355bc05962c4b975ad.camel@intel.com>
References: <20260624220516.3033391-1-seanjc@google.com>
	 <c4ce0b3ebc40384afef7895909df3d00370b3e1d.camel@intel.com>
	 <aj1KP2h49GzfNHFz@google.com>
	 <20320c7b5e6e9a01f2607761c934bf47ec8e2f64.camel@intel.com>
	 <aj66ZyxVdLjF_0dc@google.com>
In-Reply-To: <aj66ZyxVdLjF_0dc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4691:EE_|SJ5PPF3F833FA49:EE_
x-ms-office365-filtering-correlation-id: 65f14ced-694a-4caa-b234-08ded5d0d312
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|18002099003|22082099003|11063799006|4143699003|6133799003|56012099006;
x-microsoft-antispam-message-info: gwqHTS3nbswEpTkst0WlBrJYegNhwCCac25+QIELNjEgxeE8NaNvf587hKotucFJeppx9EAMHKgtwSfzID3r/TIVTLVW92f6tqkvkyAQcosDvcFhubW0U/iQWGlVpl3mVhVU+/Wjrk8QNbEq5tenZ/sb5DuSLWay3n7cwwDsZIXXFF5nzXQtZQF60j0MS3dBOdrbu8K5v/w+179CuG+ktFcntJNDeSKbxURH0cok4JN1/YewENFTToxPB7NizgZ1HcMbLkc+T4a9PJ9mKOix3pVXUrhJMvatxbOwDUkhAvLeIlr0t+0i3KHjwJGGtURS8ZSRiSeJZ6x4GUfEX+IQumPa9BgHuH5BYhgcjdvXr02vZ41BO29SGxuWoVm+73RX/P0tetqRs94EcFfCTLy2VJObKoTSr2nCCJonfdYiYLvkUNnriSzNGgUK1b8vjLC15Xeruadooy0hjh8ZB+9EZ/Rt9WhR3l716hZPokZ1Vx/k1gIsLxMIxehOXuxjtm2FrEDPM5j/YoGcoIBRdujz+2P88jxQXcwfjw+acoFJwdn93ND0ZVBB7X9m14r5tNhGEpW2SS7tn30CBl8Ao6V/MXLtzR34isB9jdYSICiXK1tS6Ly2ju+AFpmmYAFivjak6nt/tSvqMidVK8r9UV+TkwFyc3zDeua8NBw3F2CU/BU9ojybDHP2/eaxpW1OTP7qav0bYlirKv5xqLYtM7/gDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4691.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(11063799006)(4143699003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHdDQ0VLMWpDczFXSEk5cldkNXl6QXZaZlZ3QllUTU5aTE1ZeWk3TUVMVFhG?=
 =?utf-8?B?R2dteDRUUnNSamdSdW9zRU5KVE5IdjNUanFkTkIwRldoaXpPYnBTV3RLWmdV?=
 =?utf-8?B?a2c4VDdwbjJpSXl4Qm55eTVaTXBNZjJweS9CeXJKUUhKNFdZdklaV25vS0lo?=
 =?utf-8?B?Ulo5SDk2UlN2L2Z2Lyt3dTBTK1pjdFM4cmhTRlNSUkYvRXBWdmx1UW5YeWhX?=
 =?utf-8?B?dXVJVDVhVDdxZmhQV0lMeHMxa01HTGJtRU03UlVPTlJCT2NCZlZQcHRVVStr?=
 =?utf-8?B?bjdBdXNrZHg4eC9BUDduWmxYcURwRW9BZHQ2SGdXdkZhM1A2a1F4cWJqVVdQ?=
 =?utf-8?B?djBWU1VDdlRUalpHWDhtOUpvSjZrdngrcGFtRGdNNEwyTS9ZT3FkNTYwOVJW?=
 =?utf-8?B?VUN6ZVRiYm5teHpmVVM0cXhkYVJKZFBFdWZWRjFxY1FNa2tMZkFYQ3Z2MGJj?=
 =?utf-8?B?ckZvVTNtUjZtbUlFV1JKZlpqcStPb29MRTJYWTB6RnRsN3FpQm1kZUU5Qmtm?=
 =?utf-8?B?ZlJyR2tFWm5GVCtTcS9pSjdzd091bGFKbEFGR0IxaEVRdzE3UEtGM2N3bGFh?=
 =?utf-8?B?cnd3MnI2U2ZTRjU3MmliUlJkWEc3U0dZdTI3YWNtZ0creGZyR0FxdFBwV0JO?=
 =?utf-8?B?Z2RuMDVDQlpZUHdieDVUZE5pdW40cUx3M0s2VkJvV3VUVTNpYXd5Yll6TklD?=
 =?utf-8?B?eDRXVFBSZ0xxTnlVSUdHZVl2UzJWd0hRSVFpN1NZVXFMaWY2VUgxRlRiVFBF?=
 =?utf-8?B?VTlJU0hXbElmcXRkTzNRK2RRVldUUWhqNktEOWhFVDdFcENzMXBGdks0UXFC?=
 =?utf-8?B?T3NIYXV3Z0w1SDJmOXo4S1VWSngwazRnRjNCaEYrZWt2QTcxWjVvRlloM2dD?=
 =?utf-8?B?a211bk44V2QyMThnWTYvMUg3SThwb0pqWmNzckhxdlhwU1VTeUczUndmSUdU?=
 =?utf-8?B?SEN2L0ZrdGRLQmZ1bFljLytZWW40anRzMExBTHJ3bkZhZFlJVFQxVVBxK3Ay?=
 =?utf-8?B?ZXRWYnl5cW9sTFJLdmVlTm5GazBNMEtKUHlnVWlhQml2enJhdFdkcjRIVFRn?=
 =?utf-8?B?MmIrcGF2R3dmWTZjVTNPYzNubnIyWkFySTZqWjNVcVl3VlFQYTJnQlBKLytp?=
 =?utf-8?B?cWE2K2U2eHJVdmMwVE1wSU5hemk0cEkrMXZ6c0t1R1I1OEV5Q1JGZzFNUm0w?=
 =?utf-8?B?Rkl3eTI2OXd4Nm93NTYzMzJldVU0bEtuS1FRZU9VWDAxTWhLOG1HWEh1NjVX?=
 =?utf-8?B?T0FDbndGUE5Nc3BzenFYRnZYUWN2VUladG1TNVNvMGFsY0RtZGR3VlNzQ3Fq?=
 =?utf-8?B?WGd1cGcyVnVldW83NU9MaDFYVk05c3l6RUZNUHJmR25neHptcWluelpsSERE?=
 =?utf-8?B?TGdFVWNWMDhRVkswY1lBQ0tvR1lBWk9WRHZxOGlsMmc3L1ZYM2dyNDNqVzNO?=
 =?utf-8?B?cDVFczl0U0htYUtESE0yNldEdXQ4bjJ5N0tvVWs0QlJrR254MTViSVhRakNK?=
 =?utf-8?B?TmJtVHNtRFJnbFA1bS9WMDZXZklReFBFdHMzOVhnOEZzK2xJKytENkZSOVh0?=
 =?utf-8?B?ZGhXVHFQS3BGcVBLb3ZmQnlwK2Z1SDVFR3VDcWJjbFlmNHMyYVE4djBSMm92?=
 =?utf-8?B?elRHNzFqRFV2Z1FlRmNtc1FvYytOVW0yUWVsUU5USVZ3OGJNMWN3N1N6Unc5?=
 =?utf-8?B?VmY0YW1hNkNUajBySWRmV2NMOVNKbFBsbHd5bHRmQ0tQZkx1cVZVZWtqOVN2?=
 =?utf-8?B?enpkcVhVRkhPd3ZVWENUc1paV3VNeDhOck1kYlVudWNHMWk0TUd3MTRnTU1v?=
 =?utf-8?B?dmZWeWRCYmlvMEJrYXYyTS9GamQ0NmhlY1B2VXVsaHFjOEFjYm51ZDhnc2xt?=
 =?utf-8?B?T1NQSUV6Zll4bEpCOHp1cVA2RDJwUXJCbnU1NjBSUFdBTkZDZmFwQ1JPWnFv?=
 =?utf-8?B?MFRqNXpFVWRkNzBOY2JlQ1dMWXJMWjY2SU44OVg1UTJITytxazdXaWRCcXdQ?=
 =?utf-8?B?Nmw3cHdaK29FakFkRXlybmFXdTBIMGtnOWNZN2hLdnR6eEVnU20wbC9xcFE0?=
 =?utf-8?B?dWZNZWN4cERQMlFWUTd0WWo2UzBZZVhJZEhhWkUvMFNMR00zUTAwNDlIck0z?=
 =?utf-8?B?eTB2SnRLbkhVS0p4a2I5YldCWGFWaXBOeHo0ek8vYUx2YTJrR1RpTDRxRDNU?=
 =?utf-8?B?Q0g5b05BeUphcVNxVGhIcXhMUVAwSERDbEhWeStocStjb01SWm56VmViZDZv?=
 =?utf-8?B?QlNma3dieFpxbTB2bzhFM0d5c2R0TXFhYkN2YmV4Y2k4MHhXbEhhTEhSUHFC?=
 =?utf-8?B?S2ljMC9kai83WExLY1c3eFQ3cFUrOTdENzZhR1NxUEd6dXBUZENHdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00DDCC218F1F904EB0B08BEBB322D030@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TW22lgnK5RFLUh7kGSNO4ldgbwwkjIrr0hk3XYH1XDRoIz39Y6hYMwQB1CbYhsg5FovrjjnCkZwm6/Bp3Giqh9t19tAIX5/0C5mfaa2oiCd9RzfwOHcE79MgEG87Qca9+hbVGG7yzljb5DkFoSGH4upcvk1smsjblw5mo1gvV7jKWhNlGOcI8QJ/rtzjEVc+EybHTnnyYoPQ0ts/5mJO0Q/Jk1Y50VfvLjaubRhbUvgKoW9tBHKNmcTAxPp/DQaHryKFI7/f189mv6BtV4qo1byCSaZuPNV1zkd3jgVunMCxIVIkL8Ghmp6QSXkC9cJPgc7i5/V30jDp52DgvB/9bA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4691.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f14ced-694a-4caa-b234-08ded5d0d312
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 11:23:20.3745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dp6BAq228n/8fsLe7vvcLh5siZmPr772p1aCBayIbdi2z8yRb8cjm3DbqR9ZQXc0wLB+KigN+GbEMRe5L56tdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3F833FA49
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTI2IGF0IDEwOjQ0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBUaHUsIEp1biAyNSwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIFRo
dSwgMjAyNi0wNi0yNSBhdCAwODozMyAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToN
Cj4gPiA+IE9uIFRodSwgSnVuIDI1LCAyMDI2LCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gPiA+IE9u
IFdlZCwgMjAyNi0wNi0yNCBhdCAxNTowNSAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90
ZToNCj4gPiBJIHdhcyBraW5kYSB0aGlua2luZyB3aGV0aGVyIGl0J3MgcG9zc2libGUgdGhhdCB0
aGVyZSBhcmUgdHdvIElSUXMgd2hlbg0KPiA+IHZDUFUucHZfZW9pIGlzIGFjdGl2ZSAoZS5nLiwg
b25lIGluIElSUiBhbmQgb25lIGluIElTUiwgd2l0aCBkaWZmZXJlbnQgdmVjdG9yKSwNCj4gPiBi
dXQgZnJvbSB0aGUgY29kZSByaWdodCBpdCdzIG5vdCBwb3NzaWJsZToNCj4gPiANCj4gPiAgICAg
ICAgIGlmICghcHZfZW9pX2VuYWJsZWQodmNwdSkgfHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgDQo+ID4gICAgICAgICAgICAgLyogSVJSIHNldCBvciBtYW55IGJp
dHMgaW4gSVNSOiBjb3VsZCBiZSBuZXN0ZWQuICovDQo+ID4gICAgICAgICAgICAgYXBpYy0+aXJy
X3BlbmRpbmcgfHwNCj4gPiAJICAgIC4uLikpIHsNCj4gPiAJCXJldHVybjsNCj4gPiAJfQ0KPiA+
IAlwdl9lb2lfc2V0X3BlbmRpbmcoYXBpYy0+dmNwdSk7DQo+ID4gDQo+ID4gVGhlIHJlYXNvbiBi
ZWhpbmQgdGhpcyBzdGlsbCBlbHVkZXMgbWUgOi0oDQo+IA0KPiBUaGUgUFYgRU9JIHN0dWZmIGlz
IGFsbCBhYm91dCBlbGlkaW5nIHRoZSBFT0lzIGluIHRoZSBndWVzdCBpbiBvcmRlciB0byBhdm9p
ZA0KPiByZWxhdGl2ZWx5IHVzZWxlc3MgVk0tRXhpdHMgKHRoaXMgcHJlLWRhdGVzIGhhcmR3YXJl
IHZpcnR1YWxpemF0aW9uIG9mIEVPSXMpLg0KPiANCj4gSW5zdGVhZCBvZiBoYXZpbmcgdGhlIGd1
ZXN0IGV4cGxpY2l0bHkgZG8gRU9JLCBLVk0gc2V0cyB0d28gZmxhZ3M6IG9uZSB0byBub3RlDQo+
IHRvIGl0c2VsZiB0aGF0IHRoZXJlIGlzL3dhcyBhIHBlbmRpbmcgUFYgRU9JLCBhbmQgYW5vdGhl
ciB0aGF0J3Mgc2hhcmVkIHdpdGggdGhlDQo+IHZDUFUgdG8gdHJhY2sgd2hldGhlciBvciBub3Qg
dGhlIGd1ZXN0IGFjaydkIHRoZSBwZW5kaW5nIFBWIEVPSS4gIE9uIHRoZSBuZXh0DQo+IFZNLUV4
aXQsIEtWTSBjaGVja3MgaXRzIGludGVybmFsIHBlbmRpbmcgUFYgRU9JIGZsYWcsIGFuZCB0aGVu
IGRvZXMgYW4gYWN0dWFsDQo+IEVPSSBvbiBiZWhhbGYgb2YgdGhlIGd1ZXN0IGlmIHRoZSBzaGFy
ZWQgYml0IHdhcyBjbGVhcmVkLCBpLmUuIGlmIHRoZSBQViBFT0kgd2FzDQo+IGFjaydkIGJ5IHRo
ZSBndWVzdC4NCg0KWWVhaC4NCg0KPiANCj4gVGhlIGlycl9wZW5kaW5nIGNoZWNrIGFib3ZlIGVm
ZmVjdGl2ZWx5IGRpc2FibGVzIFBWIEVPSSwgYmVjYXVzZSBQViBFT0kgb25seSBoYXMNCj4gYSBz
aW5nbGUgYml0LCBpLmUuIGNhbiBvbmx5IHRyYWNrIGEgc2luZ2xlIElSUSzCoA0KPiANCg0KUmln
aHQuDQoNCj4gYW5kIGJlY2F1c2UgS1ZNIG5lZWRzIHRvIGtub3cNCj4gcHJlY2lzZWx5IHdoZW4g
dGhlIHBlbmRpbmcgSVJRIGlzIHVuYmxvY2tlZCwgaS5lLiBjYW4ndCBsYXppbHkgd2FpdCB1bnRp
bCB0aGUNCj4gbmV4dCBWTS1FeGl0Lg0KDQpUaHVzIEtWTSBuZWVkcyB0byBtYWtlIHN1cmUgZ3Vl
c3Qgd2lsbCBhY3R1YWxseSB3cml0ZSBFT0kgdG8gQVBJQyAodGh1cyBQViBFT0kNCm11c3QgYmUg
ZGlzYWJsZWQpPw0KDQo+IA0KPiA+IFRoZSBDUFUgY2Fubm90IGV4ZWN1dGUgYW5vdGhlciB2ZWN0
b3IgaW4gSVNSIHVudGlsIHRoZSBoaWdoZXN0IG9uZSBpcyBFT0ktZWQsDQo+ID4gcmlnaHQ/DQo+
IA0KPiBOb3BlLiAgVGhlIHJ1bGVzIGZvciBkZWxpdmVyeSwgaS5lLiBmb3IgbW92aW5nIGFuIElS
USBmcm9tIElSUiA9PiBJU1IsIGFyZSB0aGF0DQo+IHRoZSBJUlEncyBwcmlvcml0eSBtdXN0IGJl
IGhpZ2hlciB0aGFuIFBQUiwgdGhlIGV4YWN0IElSUSBpc24ndCBpbi1wcm9ncmVzcyAoaS5lLg0K
PiBpdHMgSVNSIGJpdCBpc24ndCBzZXQpLCBhbmQgdGhhdCBJUlFzIGFyZW4ndCBnZW5lcmFsbHkg
YmxvY2tlZCBieSB0aGUgY29yZS9DUFUuDQo+IA0KPiBGcm9tICIxMi44LjQgSW50ZXJydXB0IEFj
Y2VwdGFuY2UgZm9yIEZpeGVkIEludGVycnVwdHMiDQo+IA0KPiAgIElmIHRoZSBsb2NhbCBBUElD
IHJlY2VpdmVzIGFuIGludGVycnVwdCB3aXRoIGFuIGludGVycnVwdC1wcmlvcml0eSBjbGFzcyBo
aWdoZXINCj4gICB0aGFuIHRoYXQgb2YgdGhlIGludGVycnVwdCBjdXJyZW50bHkgaW4gc2Vydmlj
ZSwgYW5kIGludGVycnVwdHMgYXJlIGVuYWJsZWQgaW4NCj4gICB0aGUgcHJvY2Vzc29yIGNvcmUs
IHRoZSBsb2NhbCBBUElDIGRpc3BhdGNoZXMgdGhlIGhpZ2hlciBwcmlvcml0eSBpbnRlcnJ1cHQg
dG8NCj4gICB0aGUgcHJvY2Vzc29yIGltbWVkaWF0ZWx5ICh3aXRob3V0IHdhaXRpbmcgZm9yIGEg
d3JpdGUgdG8gdGhlIEVPSSByZWdpc3RlcikuDQoNCkFoIEkgc2VlLiAgSSBzaG91bGQgaGF2ZSBj
aGVja2VkIHRoaXMgbW9yZSBjYXJlZnVsbHkgOi0pDQoNClRoYW5rcyBmb3IgYWxsIHRoZSBpbmZv
IQ0K
