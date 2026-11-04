Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793822524;
	b=dY1JyRTVzkJvtcNrrO7ZHnUB9nn54qMW+0f2lHzxxEv4PGI5V617v4DG3ZFGZSgloVUQ
	 NtuOj/6DFZ1BVzRUARH1m/fBCsYnPcqBGcvboBGT9lRA52bMldzYPhnGh9DJj6+IlRcxT
	 rjksTSTDx/3mDGWnzAEnJzZgp7vGEavArF6s1F5GdwUSqLtzH+meorfBsRU352Ev1FFdm
	 wJUv5TblD50rDLeBuqNOp7lUgu1RFa2FwbSowLWUjNBFnlQQdMwXKNk/uxlrFqdZ6gWE1
	 wsDA7QzogPhCS1NOAr6uW0W7wOFAvOorqwt4xDGh1FYolqcScSmUmtldnsufJu1zWuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822524;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=3TVkV+F01OdzBizTF5MQHebTHfDuzMDa0+diW84FiFc=;
	b=F2mxDMkREYE7JqGtTwVioChwrjGw4D1Z9i/uDJWq9gKDL9JXZHViiCn16YVhYyjohotn
	 dUYwK5ZVCLYRzf/oqRwNCgEp8EX4UXWv+BTlXY1+uW630M9qUmy4HUVV06lCBlF9AA3mY
	 0nnetJr7/9jYfbbR5pU9osEUJqTUrCyWRZalWfsKZu7sv2pYzV/oTmpsaUWotqxxiumr0
	 eYl3v+xjDfF8vdvKrkbGW2x5m5BQGensme9H2+v4WyYQvGhDvLwwH7MuEIaHHYzrZcURQ
	 wxvl8macSzKXPHR7e0Eni9y4qtBSyyRLI7G2ZhBcF7miMdVjBoFGtyKvJyMuX9g4uaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kkNWYlP4;
	arc=fail smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582A5606E821;
	Wed,  4 Nov 2026 20:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 582A5606E821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kkNWYlP4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793822522; x=1825358522;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fjvo5+qTSPKTG27phwGt3ngRGsUhKFZyZks5K8KRnTM=;
  b=kkNWYlP4x5DQdfAPzYV1XmpyKV6A8jVkPRuRB+g1Y9xd4Bdo53YvFbUB
   YehWrr+UFHeUrp9PglZkQYfRrlkwUqfs1D3BD5xu3OX8Zu7kNCJJ9RQ3w
   jNfrzjiOV4Pv8v/2iGFxsvWUB5azKbDXaS+msFrQfDxH87DIsY0+4oJsk
   hPTQ3aOHet0QZqsjYGqmTKk4ahRzdxevMdG40tpJIdC6ERy++q3u+AYaJ
   Dj0OW/0X22z82FYs4X+/d6oRpejkHXcH27nsviwy5QF/CTuvQAUQitVZd
   ebJWYAmE3EEymezY2wdYGJG4c9tsvGHSAq3qHgJjl9LUVwVM1sdrN0q5n
   A==;
X-CSE-ConnectionGUID: c97x4N6KQN60zPpLjbCEDA==
X-CSE-MsgGUID: fyINYOvRTRGEvHSLI8iOwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2696503"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2696503"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:01:49 -0800
X-CSE-ConnectionGUID: DsJaXeOcQsaWSa8i/vLItg==
X-CSE-MsgGUID: RizodZnPTSqDzpuOrqp+Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7144577"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:01:49 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 12:01:48 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 12:01:48 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 12:01:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLmkghJItOL7U0TGgJ8VHm2NttFuNRSTg6dmR2teREhJ39U7y/giSnie7AhWTw9hAKRXpAQnG5CrU7Zyzto0dwhwZngx+o97CELw+eKfCt9mYTTsGbGGCkyFhvXBBxkD7QZjAKOOxNy43C3CHqfbrrpTRneP+K87Ys2C+E49e15LIZ/s1vwcr5QAljywx0mdVNxXBYtvLzQeJUKBDl66scEpuCCIS/J4bxcCLCk1vYXfFt6J00aUpEYwlCNOeGdiztvCRZazJ6TEi4rBXYXiisVt9QFtEgsdfZIOb6B8Smlpo//XhphjfUe55sQN1AQjzWtzqWX0JDoW8Wtc+VrTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TVkV+F01OdzBizTF5MQHebTHfDuzMDa0+diW84FiFc=;
 b=om9wUVAKjazFW/Cb+1AB4MCsLytCAgtqssYbJD18GIcFLTZkKKu4bZIto4vwpJi+U/Kvsb82ZwJEFZVntA3kyPgN2VfjUzSKyk9AkNMAPt//M2BHQhTRI0tallZpk6IUthX4X2KQEKSZ+QqeUHiwvMZ6t8YfjTXWfmjhnAI2BAomD1NnF7K75sayot/+OEpJYVmg8o7PDsNlrrdkd72+b98e0X8RiHmwpegdeXu7Z+757fxT/90zoJ+s2KOoSjmYBE/+XnWsQM/54XBIAzBXbUGifkX/9NIrX7YqcdeMPjZxvMIUsT3UGZdvf2+6NtQZnLlZdz8V8P8WIqsd7KuvUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 20:01:38 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 20:01:38 +0000
Message-ID: <60f7934b-5271-4207-b071-6240b5d36cc5@intel.com>
Date: Wed, 4 Nov 2026 12:01:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 11/28] KVM: x86: Add a helper to detect if FRED is
 enabled for a vCPU
To: Binbin Wu <binbin.wu@linux.intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Xin Li
	<xin@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>, David Matlack
	<dmatlack@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-12-sohil.mehta@intel.com>
 <f7f84b44-e2fc-4d8c-b2e5-e5327086d026@linux.intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <f7f84b44-e2fc-4d8c-b2e5-e5327086d026@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To CY8PR11MB7846.namprd11.prod.outlook.com
 (2603:10b6:930:79::14)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|CY8PR11MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6393fb-7893-49ca-a523-08df3aae6f94
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|22082099003|18002099003|10067099003|261022105027099003|56012099006|4143699003|11063799006|261028144727099003|261026121527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: ImHM4wZkouLqCaLeKOAz7TL7iSG47yYI9OcUwhrDIJlxG0UiGUM/CktN1go+sAWJWwwVPun6mG8ICTipjXeNpBGP3QKUpMkb2HJL9p1cp2g6gU2fBLrSp8M5dbSxnVEvcytTxAVpW+Wac0PKXEsatfhkaST0dU5gXOCHXT0Cz6GvDQLZuz00QxeO39b269wfEmxuPIiYLfpK8LxRWjXhw+Mgw+DAd3fG8riodu2g/uZmlWNWC9InelugNipbYbeWTQIxNG3FQtfOLzTNpxcNtyKrAIDQ+2IncshZNjj487ezIXGryftC+dmqVm0IIBJg0augcnq+Dm12dcQaHvuoZrxLZSrTYuDIBSSn0jxNHStUASrF+9Z+qRVdcKqkGCBxb2kYH8gQKdQ0NS/gCQ9k/wgqTYqFZfzJtK7ZkbInYTMD3AqqaJDKj+pSQJ0k0zOSG2Fl8TNQHoZeZ/YKh76iboUq2d9PYI56EZiOqnooKB5B3sPHj5NXgApBTgVe252AEiLkJIAMKDvl8RluO2RcWKDiRLADQDh27gS0q7u/yoTM/y8fR7n4VmcvEkZiYz4cfc8Vb1PyPa5Bg8UFk0h9L8BPrNRlU3FBtYd5sIDKvQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(261022105027099003)(56012099006)(4143699003)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkwyK0tsMUxIQ1JBek9Wek1DNDA4RklESnUyN3BTaDNZeXFidldVbzRQcGFT?=
 =?utf-8?B?emZBNFRsMkd4T0RNcVFZMzV3aVJubkttUWZtdHovcFJCVzc3NmYydFR4aEJI?=
 =?utf-8?B?T2xnVVhoQnVVeE1aSjNYcHk0QUFyUk1xOWtwS0JzV0kweDhQS3BZeTJPdU5B?=
 =?utf-8?B?bkhDclk0cDd4TzdkSi9NMytLYStxVXRXMjJpcEt6UCtmanZoVlZWUjRpZExa?=
 =?utf-8?B?Y3RLZGRST0dhVDA2Y0xxVlE0VkNDTW5MbzJoV3FrTUZ0M2hZL3pvd2xrWER3?=
 =?utf-8?B?WHhFemNMWjY1OFRHTHBDMUI2bHFGeUdKdHhZM3A5c0pSa0RhWlFrSFpCTTlh?=
 =?utf-8?B?cHRNS3cvcW01VXNlK2g5Tm5lN2x5ZHNNWTdCT3JqaE4rUTM1ZDBPamxKT2dx?=
 =?utf-8?B?TkxLZExpNDZaUmM4R0tuemR5TldZZW9jT2lGYTRiVVVnbTErRWhtbmF0WkRt?=
 =?utf-8?B?R3dTVkRvQ2dyNXBzUEl6dXJsa1N0YkFYNUxPbHl3VnhLdExOdzQ3b1ExTHhx?=
 =?utf-8?B?bkNZaEFhd0tHRkkxRDhjc0xJUThXK0hyOWIvRWE2UUxud1MwSDdscjlYQ1c1?=
 =?utf-8?B?QnJSbEdmZ2l0RzEvc1BoZGh3bGtWSFU5ZmFJUDNlN0NzZjFSd1NjQWh0Ympj?=
 =?utf-8?B?aXdLNi80TWo1ZnlXRS9oMElSaUtnKzJ4SUVpRnUxU09zalc1dlMwUVMyYko2?=
 =?utf-8?B?YlBzZDI3U3dSS25MRnJVdktsWk9jNUVkaG1mVWx5OEZKdWVLRWRSSlpwTm9O?=
 =?utf-8?B?UzBtNytMclNUSmdZM3UxRzlsZDdzOWdDQTQwM0wxWkVCWTdQazBmQ3RXOHVi?=
 =?utf-8?B?WStmeEpwZWM0YVQ1KzJPQTlUUVMyVmtNTFFqYjF2OGNOZ09OM0ZzbXRUUExp?=
 =?utf-8?B?NTNtMUF5YlJJV1ZzaHRqMnhNSUZUQyswc1NaVExGK2pJSGN0OCtCTlptSW1l?=
 =?utf-8?B?U09wT3dVcSsyYWxHOHdISHBwZ0VGOFQrYXd0U1lZTTZyQ05TWG92R0MyS0g0?=
 =?utf-8?B?L0JEOXg0WElPTmt6QkRBRkdRMVhCRTE2cG1YdWQxRGxNdFR0b2NYTVFHWklZ?=
 =?utf-8?B?QmQ5a0EySmtGMFVkRXcwNThyeEh3QndyanZwZnUwTXVqVU1hU0hDM1VXWTB6?=
 =?utf-8?B?bEVDb1IyejFuOGZuOVVWNlNZcTVHc0JkWVR0ZEZBZ0daQ1BwY0E0bk5qNHRy?=
 =?utf-8?B?aFR3MEZ6UmxxamZCNkk3NXRHTE40UnBxZHd4aXJRNXJ1aDc0RDVwK3VnRzlx?=
 =?utf-8?B?c1hjWDl4UkxMdVQ0Z1RCQTJXZWt2Zk1Oa3lPMjVPdncyOUo4Y1ZQUjQ3eEMr?=
 =?utf-8?B?SjBLVW9tYlhpNi80ckJveS9MWmt1OHhrUm5FNHlkV0xRc2l1SGJQZHh3SjVR?=
 =?utf-8?B?bmxLb0VsbTFyWDNLWm5vVWdOZVNpZDV6K0NrNTRIZGZuVGZhU0FabW1NdkhE?=
 =?utf-8?B?eVNZL1FISXZrN0tSc25WUUpJZWJBL0djU1FxREd3Sml6MCs4NldmR2gwaVEr?=
 =?utf-8?B?eXdhT0NRRVN1NFhGSFFXM3FtS0VPMDhBNFk2Sm5NU1NVajh4ZGh2djI2elNa?=
 =?utf-8?B?UTlpRmRuay9mNFZYNVZzY3ZIaGxPMm1maTN1cVNuMjlaRkxHM1lZZ1ZSOXBm?=
 =?utf-8?B?YkVVR0lGNnZqZ0JXTlg2SGJzWitxQ2ltb2dTK2tQY1VncnRJbjJUMHBWOTQr?=
 =?utf-8?B?dklRNnoxM3FINmNIcmZtNndGcjlrbTdyVWhzcUdNZStmZTBmczlEdWZKZURS?=
 =?utf-8?B?ajRMTzRtOStWYlRHSE9FY1NNQUhwcjBpMmVEMm84QUV6cUY5TWNkRTJudi9i?=
 =?utf-8?B?NG56TVk5NCt3NnRWUzh5Mnk1YnJFNml5dUpwd2oxbmFrNHlkMzdKRkVwZncy?=
 =?utf-8?B?MTVwM3lEY2tvWnpXQU80Q2RZem5zcE5aTDU1bmF4T1NueXNtSGx5VFdLV1Zk?=
 =?utf-8?B?QnNoWWlGRXFWQkFLMHQyNHBhTW5WZUhNamZzT2pRL05lK1FLaWQ1VzN5TTJo?=
 =?utf-8?B?WFdYMVpVeHRTSjJLNFZ3WHB6OTFtQ1BKN3JzUDNDR0hvVks0WityOXdTNFow?=
 =?utf-8?B?M3IrSWxmRlpjTHdVSzh5cHpTSXgwTzhqUWpJZlBSQU1iU1JOWkJ2dmJvKzQv?=
 =?utf-8?B?amQ3N0ZiY2RFNUpiUGl5SEp4VFp5QmVpVXlGdWtqVlFpMXZhRU5qQlZjQmo5?=
 =?utf-8?B?cC9udkMyOFhnY3M0d0JoRitKaDRNY1dvaC9qZVJlUFRrekluU0QrR0pIQmVM?=
 =?utf-8?B?Zk1HRXRzOHBCU2FhUmVVQ1kzRDhZM3hiZkNyT00welhMTno1MmJOSXM2NmJP?=
 =?utf-8?B?VmhjL2xyNW96NnU0UzJPRmpIU2loRnNFMnl5bUhadVdpZ1lXaTIzUT09?=
X-Exchange-RoutingPolicyChecked: FDCPeAOl/1pM9LlXxPCkrE9bJaRizNahaRPa9z1HFGY0PzGbmb2CkGf/hPinUdGEUvlnXk1Ch83zSXTIQKRNFyfoqKNVJeetORyrEfxVnZnBSNNh39Uer2OLa+sqn70nQznDiS9a2JHv/OcQvqO7YhQADGqvQQPvQg+n4Y97C+qQsnfiEoGOFah+vzeWYYNNcZPmF0qTE/s42cHH5CiqTmUTxyD6Qz4o4YaG+AfYh3zw1l/yD3TP8kpTIkVf3Hzj+1GSsJHKuG8SZkGhDF5e1hg6KFD8Ky10C+phalKnsjb7LPmKI7lewP8FnHzG1uTtdZxD6Vt/9RWarZEfy+MvsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6393fb-7893-49ca-a523-08df3aae6f94
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 20:01:38.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLlqyUiU7TWbOyhxxBfAUo3nf1WPeLyjsNf5F9Z61UaaiV+jekWNJ2WJMqxKyM50xlsLEYM8YeH3GnmTTwyLcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7134
X-OriginatorOrg: intel.com

On 10/23/2026 2:21 AM, Binbin Wu wrote:
> On 9/12/2026 5:36 AM, Sohil Mehta wrote:
>> +/*
>> + * It's enough to check just CR4.FRED (X86_CR4_FRED) to tell if
>> + * a vCPU is running with FRED enabled, because:
>> + * 1) CR4.FRED can be set to 1 only _after_ IA32_EFER.LMA = 1.
>> + * 2) To leave IA-32e mode, CR4.FRED must be cleared first.
> 
> It seems KVM doesn't enforce it in kvm_set_cr0() for 2).
> 

I think the comment is slightly misleading. The spec doesn't directly
enforce leaving IA-32e mode with CR4.FRED. It is just expected to be
unreachable.

1) Based on FRED spec section 4.2 Enabling in CR4, setting CR4.FRED
prevents compatibility mode entry while CPL = 0.

2) But leaving IA-32e can only happen when CR0.PG is cleared which can
only be done in compatibility mode while CPL = 0.

Currently, for KVM, the CPU enforces the first one and the second one is
enforced by kvm_set_cr0().

Is the suggestion to add an explicit check in kvm_set_cr0() that
mirrors the PCIDE one? But there isn't a fault specified by the spec for
this case.

Sean also requested negative tests for things like leaving 64-bit mode
with FRED=1. But, I am not sure how to test this.

AI tells me such a mode change can happen with emulated far transfer
through an MMIO far pointer. "em_jmp_far(), em_call_far(), em_ret_far()
and __load_segment_descriptor() have no FRED checks, so none of them
raise the #GP that FRED spec 8.2 requires."

Chao had brought up enhancing emulator code and making it FRED aware
[1]. I am wondering if we should revisit it?

[1]: https://lore.kernel.org/all/aapnI6KN7Flal8kg@intel.com/

Please let me know if I misunderstood something.

>> + */
>> +static inline bool is_fred_enabled(struct kvm_vcpu *vcpu)
>> +{
>> +#ifdef CONFIG_X86_64
> 
> Nit:
> This seems to be unnecessary.
> X86_CR4_FRED is defined as 0 in non 64-bit build.
> 

Unfortunately, that 0 is exactly why it's needed. kvm_is_cr4_bit_set()
has

	BUILD_BUG_ON(!is_power_of_2(cr4_bit));

So, compilation fails on i386 :(

Though, it would be better to get rid of the #ifdef and change it to:

  return IS_ENABLED(CONFIG_X86_64) && kvm_is_cr4_bit_set(vcpu,
X86_CR4_FRED);

>> +	return kvm_is_cr4_bit_set(vcpu, X86_CR4_FRED);
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
