Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11A23033FF;
	Wed, 18 Mar 2026 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871930; cv=fail; b=UOC6dL04JHYIyLncggsuR34dtx+oe28KyUZwjcoabY1weFxMelGJroJzbXue86PbrM7PNaaySYQGvyhZp9knnHFcMdLKNaNAH2eSeqoYMAMPxCLdRx1eA7H9KFg8zGe647827d4g8Lc9sfuLb2LjFTG7ISNb4/hWX1MYwv4LmpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871930; c=relaxed/simple;
	bh=4RpfDnyxOTqbA4f3PXv6VrsedbWWppNz/Hk/6HH3Ta8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lwNQlDLhfkY9NIZD508hcMihrj/I5S08EwT/JxXYhdDQwktY/gY46+M3g/nJHeAd9uGFGIDnB8sNM762kefEt5lD/NZAQZD2ryNQG3fSxHTLJIQFxvCIFLq6IolwfmXbyfN9aS86q/0v2sAKwS8lnSJx2FEF846HrK8wY14wtl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1N2dwhh; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1N2dwhh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773871927; x=1805407927;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4RpfDnyxOTqbA4f3PXv6VrsedbWWppNz/Hk/6HH3Ta8=;
  b=B1N2dwhhP+w/VlagXxn1EDh3hmHylCP8dx+5MJbew0nUjVl750eDAkCg
   6Y6lYN82egkcVHmUWJ4KbWSVaz9/pWftjs1htXfnbk0wKE7kyo9iKaRrI
   g3W4Ja45XuW1NmkumJgJCjJXIZrZmpH6MV0ew58Tl4BKDdFxSMIVWcDdL
   R6MAUUv0x4bEglaa8AB8FDFwFT/a8QiwvkozKp02+uR4iM52BMNxjQPbt
   /722YTvQoKEbggSOTxcwMIoWDgijEccqyBNXMmu4tmGN80/pAt1sp7sIz
   gIZwG5/5SZEGfn9Iib1nOdxf4WB7ejN+bd5oFHGnyMXqZIj7fLtQQzSVX
   Q==;
X-CSE-ConnectionGUID: w85Vl44xTxOv3fodAMGPEw==
X-CSE-MsgGUID: AaguT09RT06FhvdLcblmGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75016918"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="75016918"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 15:12:03 -0700
X-CSE-ConnectionGUID: vg+mXsZ2RDGJe8Elq+ml1Q==
X-CSE-MsgGUID: jg5e7kdNR66qYLB6rsa6zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="253258959"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 15:12:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 15:12:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 15:12:02 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 15:12:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjiQ8mJhUSdwEIDHHhyHq16uudkaTGUWGrcbGEaN+nl+JZw6YcdX2hEn9j0O3+3w2kv/K2RMOzeQBIiPQiaLJf0jmC27iz37cPBd1OJyHEZzTsN6df2hiFTUIC5otwz7w7g/yUOOzL05QH+woqbv19wPWtgyAEKTijxz6GLhlbug5fEGBGIVYzHd6eYtLV0jwyOfwYw2uP8aRnNeqdwRnmuazaxI9XbhrY4QqHux6YHtKixudk79T3f00+reoISbNg8VxeUepCHsDnDV4zxWVR4PdE0oKCncRItiC69pGBELRJ/vOEocJTYZ5kDCyM+8yrHAtV8/vUDD4xwIqsl6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RpfDnyxOTqbA4f3PXv6VrsedbWWppNz/Hk/6HH3Ta8=;
 b=XgnpR0QxcAJxyiIgGdd/OFlCFBEWM1xZCxXL2UWxGIrVLHNufnwotK9+mWIrxkWDyKN6Z0RRs29WPq8/Fhg2tgCzNCE/bhicxf8kjPtMfMG7ePUaXWO45VhzzCklRMuIxuzksKnZ7XqURXrM5DxItB2dt0VvpeqIgo97b/XExhvfo4zIuTMvVehh4Al3IsgWtFhyU+guwy9wAM6ZPzNzHTzBnxSwWxEUrtnBqxAlJZrbuAo0TyTOqbKMSEDK7A06BH9NJga1hjmOCHzBAtfzDTT30fuXNrh4KcPMPXhBV0dnDf/2aJVyz9hODSsh2s/CuUyARAooAUkxX0pOp9zv4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA1PR11MB8809.namprd11.prod.outlook.com (2603:10b6:806:46a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 22:11:58 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 22:11:58 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v5 09/22] x86/virt/seamldr: Introduce skeleton for TDX
 module updates
Thread-Topic: [PATCH v5 09/22] x86/virt/seamldr: Introduce skeleton for TDX
 module updates
Thread-Index: AQHctIP9iW2U9mkyMUO/ptPmhvolYrW0322A
Date: Wed, 18 Mar 2026 22:11:58 +0000
Message-ID: <371af3874cf40ff01e9e5e6960fdb7516ff51240.camel@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
	 <20260315135920.354657-10-chao.gao@intel.com>
In-Reply-To: <20260315135920.354657-10-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA1PR11MB8809:EE_
x-ms-office365-filtering-correlation-id: f09bd208-d3b2-42ba-938c-08de853b5f63
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: uA+eW9gwkbSe+zz7d4uTz84KnFVY4jVTY9Sa17i3q+Mmt11YJwSNsc7T47U89/tvzfDQgQ54jVuHL8/q+lPAns3eA17MzzpKnFR+7qwP9qO1JeVXrPNOzHA0gHDs7Z0hf3bP2NYnlPScePResnGOoiw7BBhNx0DiESmLSqdoNIJvuqjHGR0nHC/oL3PSfTed9o95YWH7IzcFYVx9NQbnx5Jinhd2BIjC1UUKSePXrXs3gTYXNSWjWWfWph9Y7JmTkwv+A58OzXsmhpfNOND/3hFNdvGMvbQOCyqyVEPy0FWbwaFzaP/PEF1RTHV6mGFpOjQzXGDx/g8pSMB5nQo0ghHN1ZDbVEWVKTNQ8c5SbGLIvElTT77hl/iwgVyzum1XnbDac9NdeUkVA9yJzhs6v6XbeYoMC2WqsmkkCoSA1jEz5N4ZKyLcahtSeOtfMVFO+WftVSqUeF2S1yt89Q6gyBuT3oeje0efyieyutELrfi/CnSkn6r1ejlZ2KyLJ9mXcdgavq9KcW1XgJAPCy/pA75g/tw/M4DWDSnihLi9l3mtxaGqHRb2xjMh0Y0STzkDBc92dxgIUdjv9l0msjTDUE6MaUPKlTM51YILwqTAmP+dUXsYRWchtAFEevB9So5gbGXnUreE0fWC2uQ4sJtOPxWtpnu8zR/tG3EgHubDHBRtcCvoXbXDBhPpMBbfPys7RfLkvPi4MqXG6yrSJHbpuHTADluHBGmEkmETW6hsT7Vjireg6AuHG7EMpdpD5S+rJv/sJMFVCAwwzC2M6UPs4roVG00nIp8FPQu3gQIQezM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWdMS2RuM0VFRm5RWmY5MUtLS2o1NUZzL0hjZXBpNU14dlNhZjl3T2JHbUVI?=
 =?utf-8?B?SzI2bGxiMjFvb0tTakhyVW9PZkVuZmpJMFJzWlBNKytiUUFmaXhUdTdHZEdi?=
 =?utf-8?B?QWt2Tjh0YytMSkoxUzhBVWNrejl4MndkUVpTOFQwait0eEhIMlNiMTRJODZ0?=
 =?utf-8?B?ZzltV3JLZzdwU1U2K0hrMzljcy95ay9xa2lZRGthVVFMV0QxcDNMVTlaQ3dZ?=
 =?utf-8?B?NlVXOWtxTk9TS0w1aXhGRUYvY1ZVcTZLUnVrT2dNVVk2WjlXZmNzZXoyYmRU?=
 =?utf-8?B?UVN4NktESy8rTDNpWWVpS2lhVldJNTN3VTZxazBoV1dPME5OU1lUM2xmSnAv?=
 =?utf-8?B?ejNSM1hVSXh4d3FvenVVc2l1Nnp6VGJNTkI4b1ZiNjhFWGpyVEl5bXBRTmtO?=
 =?utf-8?B?R0pLWVR3NnlyZm02ZXRqU1lNOHRCV1QxZDg1ckswSUs4bGthMmZ6cjFJTGxa?=
 =?utf-8?B?R1p2L0J2Q1lyL09kTGp4cFBEYndscHpydTZMMG5UZVlET09HWVozRFNpMzFR?=
 =?utf-8?B?T0JVeGdMYTMxdlROK1R3Qy91NjNrNEw0Q0wvNkJOV2Q4d0Vja2VaYlhEdXc5?=
 =?utf-8?B?TC9UU2p6TkV6a1dUWUMvbm9panhDUzg5dUJDcEtxMUtYNnNXZU9leXdzWjht?=
 =?utf-8?B?SlE1M01QNHJoczJIbC95M0pnMnNtb1pPUngyUnNSLzZ3RjRsYVQ2bzZDTmF5?=
 =?utf-8?B?Qm8zdVFyUXFQS0xESDYwS0ZvSW1HNno2TGJzcnM4NmlmY1JuVjZaWHRwekIr?=
 =?utf-8?B?WnpUTUx1bVFDc3JqSjFpUCtBSndaZysrSm9UbVZmcWU4WkRyaVNiSENjcGRE?=
 =?utf-8?B?dGJrdWVPN2h0dkVCR3ZmaTUxREJ5VG5rL3FFRkYwclpRb2VQTlVQYkt1ZlZO?=
 =?utf-8?B?ZWM3TVo5UlZVeHBuako4UHhCWGx1UmwySDZ5UlFvVGRMOUNEVEJVdTZna1Iz?=
 =?utf-8?B?U1drUGxaR05lWDlJTXRkUU9tRzJVaUkxWFFNYk1DdEh1VGhYbEtVbjlnOFFi?=
 =?utf-8?B?eCtiL21VbTkxcHVaRmhMckxMczFjQUFYUmtVMVpnRWZrOHVwVFc3SmJQS2pB?=
 =?utf-8?B?ZzBvazc0ZENwS3B5LzBEb2tMbFJHbWlVQlBNb1dPYUpQcE4yRzVpUy9JSXR2?=
 =?utf-8?B?cHByQVBwcnoxSzlhaGlLalA0ejNMeG5wK2h2c0hCRkN3Rk9pTWsvdUlGMVRP?=
 =?utf-8?B?bUJ6clp0dFFKZEc5bG5NTlEwSWEyY0I4bnJqRllvSFQwTmNpSFVHYU4yN3Q0?=
 =?utf-8?B?dzdMTWJsblhSazZEejVZVnQxWVRkR3lldmlqRzRxRlhiZWJ1UWxOcmQxc1VF?=
 =?utf-8?B?Rm1ybFMwamRkNFJUU01zY1FWMlNVSGF3bmdJYmZNZC91ZlFmMTNpeE12SExx?=
 =?utf-8?B?TStZLzJ6TFVaS2xkWFJrMXMzZktBQTRTMjFtcEY3MSsycUgyZFhTMVpVRXl1?=
 =?utf-8?B?THBpT2F1ZkpYOU9ZdWdQbE9EOGYvK2RJajYvcW9RV29YN3YzakJ5U1RTQ29s?=
 =?utf-8?B?bGZhZEgxbUNNSFYvbCtneDNSemlQdVg0MVZEMmVqby9DVTJuWjVBSkRpN2E4?=
 =?utf-8?B?UUQ3V2tXSnlqNG9GK20waVlWTkhRTGFzSHBWc1lMbzFubHpaRkd2eHU2aHFT?=
 =?utf-8?B?M1NsNHozNjc3b1AxaHdhbG5YVjh4SUQwQ0owOHAyUmhtQWRNQXY2RVdkTDhT?=
 =?utf-8?B?eUJHRWt5UkhRbGUrNCszeW9UOEkxUXNzZmVPbG1MSUNPRmxkRzJXS2Z1VlVa?=
 =?utf-8?B?YnloUUxwekovczBab1RLdktWb09VQmVUNWFnR2dNNTI4K1JleG5VcGM3QWw3?=
 =?utf-8?B?V1ZjeEJ2bVl1NXVMVW9qWXNUd2FnbE85ZG5KUEpmTUZHcVJ3bFQzWUd1Sk5R?=
 =?utf-8?B?RkptVTkrUDF0SmRzVWxpNlBvTnQvUjRVNGZwVkhhOWdCdklSV2E0SDlrYVNs?=
 =?utf-8?B?TjhTZkh4MFZ1K1hsMU9BQ1B1M2JTMU9uR2gwMUZvTGFDblhyVUNWSnlCZGZG?=
 =?utf-8?B?S3FjVjJZUW0rdXp6eW9EQVdKVzVVUm1KSzkvYVkvbklNZTd6TVNhVXd3NDh6?=
 =?utf-8?B?eUpjZEowd1JvWkRQNW5kYnlGQk5nOStDNUdNdDlPcXNUT1YzckF0MkwvZUVr?=
 =?utf-8?B?SDYrYkVwSUk3ckk4NDQxNjZzOHZ0NDJyQjRrV1RpVFRMRWY1QnA3dUx4K3lh?=
 =?utf-8?B?ZFR1ZzR5YnlrT2VVSFFHbGJoSXJkQmg4MUhFWTcwK3NZc0ZOdHNVZXc3K0J0?=
 =?utf-8?B?Q28xNm9xNXRrTzIwbzhmQWxaMklCelRXd1htNVBJZHl1RUpybit2Nzh0QXlv?=
 =?utf-8?B?U0FpbnV1eFhWNEhMVVY0KzNQQmVQMCsxV052TEt1WGxoYTEyWjhHZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EF1439C4A5B1F48AF6886C0511E7172@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DyR92L8osD61WMEdrYIm4lkbB2fwKQPkbgG0oLgqkgKflKVQnXyPQXdeMZpxlcdBnzQGI1o/gVbnVY8NlECiXMPe6AU9hz7PWxrb347CwRclbqbjb37jSh8Ii2GaJOMifL+Q18B+hJPOoFn78KqwI0Nm7R4ppO/Q6YyX5h0skG+xa27JIHKeGPkf10nHCp53P6bjcEYIfSaismkEBk+P76f77YX9WGGahz0+y9xCIAlw7gGCk4TT8xMQ+Te4e7xNOQpcN6YDzbU4P+FxlRv2OZnJ56k7LXEKeg14q/nlT6C2Hu3JnSw0HDnQ8aYtt4dG2JHpH8F8SxgnAvx1sBmBNg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09bd208-d3b2-42ba-938c-08de853b5f63
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 22:11:58.2968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/YRJqGorL/i2mwSvw2Ofi4l9WYC2VcH6Uj/L+uo8lkhYD4LNDNzItb2T6PPD5nKFi6OOcrHlUAqfuyCR93Njg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8809
X-OriginatorOrg: intel.com

DQo+ICtzdGF0aWMgc3RydWN0IHsNCj4gKwllbnVtIG1vZHVsZV91cGRhdGVfc3RhdGUgc3RhdGU7
DQo+ICsJaW50IHRocmVhZF9hY2s7DQo+ICsJLyoNCj4gKwkgKiBQcm90ZWN0IHVwZGF0ZV9kYXRh
LiBSYXcgc3BpbmxvY2sgYXMgaXQgd2lsbCBiZSBhY3F1aXJlZCBmcm9tDQo+ICsJICogaW50ZXJy
dXB0LWRpc2FibGVkIGNvbnRleHRzLg0KPiArCSAqLw0KPiArCXJhd19zcGlubG9ja190IGxvY2s7
DQo+ICt9IHVwZGF0ZV9kYXRhID0gew0KPiArCS5sb2NrID0gX19SQVdfU1BJTl9MT0NLX1VOTE9D
S0VEKHVwZGF0ZV9kYXRhLmxvY2spDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgdm9pZCBzZXRfdGFy
Z2V0X3N0YXRlKGVudW0gbW9kdWxlX3VwZGF0ZV9zdGF0ZSBzdGF0ZSkNCj4gK3sNCj4gKwkvKiBS
ZXNldCBhY2sgY291bnRlci4gKi8NCj4gKwl1cGRhdGVfZGF0YS50aHJlYWRfYWNrID0gbnVtX29u
bGluZV9jcHVzKCk7DQo+ICsJdXBkYXRlX2RhdGEuc3RhdGUgPSBzdGF0ZTsNCj4gK30NCj4gKw0K
PiArLyogTGFzdCBvbmUgdG8gYWNrIGEgc3RhdGUgbW92ZXMgdG8gdGhlIG5leHQgc3RhdGUuICov
DQo+ICtzdGF0aWMgdm9pZCBhY2tfc3RhdGUodm9pZCkNCj4gK3sNCj4gKwlndWFyZChyYXdfc3Bp
bmxvY2spKCZ1cGRhdGVfZGF0YS5sb2NrKTsNCj4gKwl1cGRhdGVfZGF0YS50aHJlYWRfYWNrLS07
DQo+ICsJaWYgKCF1cGRhdGVfZGF0YS50aHJlYWRfYWNrKQ0KPiArCQlzZXRfdGFyZ2V0X3N0YXRl
KHVwZGF0ZV9kYXRhLnN0YXRlICsgMSk7DQo+ICt9DQo+ICsNCj4gKy8qDQo+ICsgKiBTZWUgbXVs
dGlfY3B1X3N0b3AoKSBmcm9tIHdoZXJlIHRoaXMgbXVsdGktY3B1IHN0YXRlLW1hY2hpbmUgd2Fz
DQo+ICsgKiBhZG9wdGVkLCBhbmQgdGhlIHJhdGlvbmFsZSBmb3IgdG91Y2hfbm1pX3dhdGNoZG9n
KCkuDQo+ICsgKi8NCj4gK3N0YXRpYyBpbnQgZG9fc2VhbWxkcl9pbnN0YWxsX21vZHVsZSh2b2lk
ICpzZWFtbGRyX3BhcmFtcykNCj4gK3sNCj4gKwllbnVtIG1vZHVsZV91cGRhdGVfc3RhdGUgbmV3
c3RhdGUsIGN1cnN0YXRlID0gTU9EVUxFX1VQREFURV9TVEFSVDsNCj4gKwlpbnQgcmV0ID0gMDsN
Cj4gKw0KPiArCWRvIHsNCj4gKwkJLyogQ2hpbGwgb3V0IGFuZCByZS1yZWFkIHVwZGF0ZV9kYXRh
LiAqLw0KPiArCQljcHVfcmVsYXgoKTsNCj4gKwkJbmV3c3RhdGUgPSBSRUFEX09OQ0UodXBkYXRl
X2RhdGEuc3RhdGUpOw0KPiArDQo+ICsJCWlmIChuZXdzdGF0ZSAhPSBjdXJzdGF0ZSkgew0KPiAr
CQkJY3Vyc3RhdGUgPSBuZXdzdGF0ZTsNCj4gKwkJCXN3aXRjaCAoY3Vyc3RhdGUpIHsNCj4gKwkJ
CS8qIFRPRE86IGFkZCB0aGUgdXBkYXRlIHN0ZXBzLiAqLw0KPiArCQkJZGVmYXVsdDoNCj4gKwkJ
CQlicmVhazsNCj4gKwkJCX0NCj4gKw0KPiArCQkJYWNrX3N0YXRlKCk7DQo+ICsJCX0gZWxzZSB7
DQo+ICsJCQl0b3VjaF9ubWlfd2F0Y2hkb2coKTsNCj4gKwkJCXJjdV9tb21lbnRhcnlfZXFzKCk7
DQo+ICsJCX0NCj4gKwl9IHdoaWxlIChjdXJzdGF0ZSAhPSBNT0RVTEVfVVBEQVRFX0RPTkUpOw0K
PiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCg0KVGhlIHJlYWTCoA0KDQogICAgbmV3c3RhdGUg
PSBSRUFEX09OQ0UodXBkYXRlX2RhdGEuc3RhdGUpOw0KDQouLiBpcyBkb25lIG91dCBvZiB0aGUg
c3BpbmxvY2ssIGJ1dCBBRkFJQ1QgaXQgaXMgZmluZS4NCg0KVGhlIHdvcnN0IGNhc2UgaXMgY291
cGxlIG9mIGFkZGl0aW9uYWwgbG9vcHMgb24gb2xkIHN0YXRlLiAgVGhlIHRocmVhZF9hY2sNCmlz
IHByb3RlY3RlZCBieSB0aGUgbG9jayB0aHVzIG5vIGFjayB3aWxsIGdldCBsb3N0Lg0KDQpSZXZp
ZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K
