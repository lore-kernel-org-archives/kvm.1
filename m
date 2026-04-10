Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6D51F875A;
	Fri, 10 Apr 2026 00:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775780207; cv=fail; b=fFIe5DXwE/Efwy1z5u2MLvUVCZwyKakhBwucDTSBitZvKEelbPVkXPBDMDMNgaGECVqV3KPS9Nrgkexaivh38hM41sLN7aH12uAMVa7lIZPs+3XyaDEr3yHwI7KExFAxSCOpdjrfXMGJ9rHrW+Z+VbOcIajQuSmCMT0T6/sOu1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775780207; c=relaxed/simple;
	bh=p6u9kJH5qjcR87dFTrvm/dBimxVa9icg6wVNN8ruRnQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8C1RuetGqVeFy4XHiTyNTf0dZdhcEbcdUJj6gPudhjUqav2ezcsabLUcE5/QGz/wAN7kXFIssJbO28VoJvLhJlTYoUO8mv7o5gw/UurCK1yVfs5Stz/cKgqarOeRu2mgvGlOPVYUgu8WDPvgr1n6ar76gSEAj4mEBeW6qrG59k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPVHTNT+; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPVHTNT+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775780205; x=1807316205;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p6u9kJH5qjcR87dFTrvm/dBimxVa9icg6wVNN8ruRnQ=;
  b=kPVHTNT+0QLiyi7fH+OaYI2uC/3vG95BRdsOgCIEYTeoK37FO/mXf97u
   g6ZnAAH6Nc0kEeBb6c//ZNj4ZPQtTT80DI+V4qxdWzbFHcjxfO4ODS1IF
   RkzeY5VLDyQklqwA344FkmnhbhfvC/hzE9nDPdCnEgHWs4mC5Z9OJJnhV
   FPN8mJClbwIjMolllhOs46J886GprjNhf/BBHBUt7mwn/R6fS3g0CtwF/
   nBzpGYkErGg62l3TtgXhUts+M0qRfaYBoqzsEfD8tQz/CN/KLU9nFZhL2
   jcANi533tKIrQIh4DM+/uZzoj40wNylPSxhTOnbrc3GUOYDutw/0xg9uW
   A==;
X-CSE-ConnectionGUID: lejdo9+vR4SnewNsYlnSgQ==
X-CSE-MsgGUID: 4jTce7oeRD+KFh4TZZUXrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="87872491"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="87872491"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 17:16:45 -0700
X-CSE-ConnectionGUID: 8oEWAYoaSd+IsY8NCVCCKQ==
X-CSE-MsgGUID: NfoP04P+THm4FBRJULxAbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="228100379"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 17:16:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 17:16:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 17:16:44 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 17:16:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORRVW/zHYwSm8PbjZsnzurggmjEkAhGELfYQUBYbpbIWemXZvL+sm+N8ctwRnI7MdNsAnaqOWFXAtZnEJAU10xbB0/hDjDuHsoQwLn/NPo330oGrMqEeu3cRnxIxyhWROSMoZqkIaxaSeCZGomyUF5D1FrT7T+Xrn63QOMp38vbSVz+WJ6c2upgfr7lt4J7VuLQTGVeYl4XtPPiRENTltg0WmvbXobWsmVXdlQ47eEjvsf6VPH4uDXDyebAV/SPq1Hs6DSUv6z4iMjhh8LzmupQIhheePl4PswzL800xPWzKUfpz3IsqKnBsMmJGHVsilG3WtFnnVY5gu2cNz+ojQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgGeRRMjbvGCiccth6kOcvIoi/NwAa1kDdFYUqIG/S0=;
 b=Gei+dGqg45aPIMleocyWDPmWTZH4+CUtQ2KSJPeXO8j4Xav9dQezOkbEi7C1Nr2LTdksBOm6qtRFIcvum2K4PvjfDQhi80m1ME9LF3l1TqA2hpm5v8QG5+xNMlntMShZJC+GFhzm9CUHq0fhzJRZ0YKReH3x2eIi2gbLiH+DaTDhqBnJI7Im2n2quVSvs/EOebpUJbFzMk5cN9r7WWOupB9vOfPWo5kjNje+8F9544dw+gstwR71afwuuEEj3irBRRcLNr1QTqnLxbfWxDEXw88PmOj4TvzpZadU9l4jiMU0LYqKrPF1k2KeSDMtX43RP5LIglXIIAL0aQ6m96e8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.42; Fri, 10 Apr 2026 00:16:42 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 00:16:42 +0000
Message-ID: <5863120f-a710-4df8-9c0c-2a07efb4d71c@intel.com>
Date: Thu, 9 Apr 2026 17:16:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] KVM: VMX: replace vmx_spec_ctrl_restore_host with
 RESTORE_HOST_SPEC_CTRL_BODY
To: Paolo Bonzini <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
CC: <seanjc@google.com>
References: <20260408182213.522713-1-pbonzini@redhat.com>
 <20260408182213.522713-8-pbonzini@redhat.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260408182213.522713-8-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::18) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DM6PR11MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: e11cff0e-c0a4-4053-764d-08de9696714a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: DygSZvxsFDA8zxpLazJxXqbOhjQFb6Zlk3HkbIBDSJNRWETRKp2+p3YLBOEDqe2oj9gjhZppQjg70FHqrrsrICDnjXfNLxfSnCDcH+1nDaT0l6/snWrq6bwUAuUpTVsJ9LZe8hFZ8AONce9H8zfF2nqJ9OGMNU/xZhAUmm0cVQPgP9pzNBvqBIj9V24NnOITFgI0Fq3tvLeNHY/P6GMjRcKOFrD1VOatmGH4PPfCfZottgej31/IdUkySyzG0MsYCvVadbIBuCpn+9CmrtWdUxO4s9aQpzCQTHdxe6El05818/50mDmUeobxXSfqiODYyzwMpbEivGPu95w1rasqXFPHun3mq4mGgIlRu3L7F/h+qgPsv4eZkINjSG6d6/EyP2JabYPGaf+HQ7OVKqDXcbQUY4D7c1uF9gdRdrHNVmSK9ZPRkLpwyd1L2IkP5ZwB7n8JuJziVjcDiRTHlYD1A6zC0zIITgcNkFMeGEm30+xRZUqvvpV4PsQXibpCIq8iZnU1TDyYivcbgBabXg9U7r04Ujaij4z+e6PZf5F/njOBStUWKkmiVQecZRn8qqoqwz3t9FomqJd2PSBK5WteGOTCwQnvWPxDhk4GZ4MrFHz9k5O7bUrQSaw36AIj/eEW1G4kcMb7neODP97UOcQU/rIcTh6xGI9EY76LU4JDpHGxwp/lUUn6Z7exsyuWaXfbYedzJXZkMdlJPJIwiGfvkxs7hrMyxM+P6e/X0+A6XFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnQrZ3M3Z0kyNFNqOWI4WlFNM3lLZ2VWWFA1SEdMUmdkL3hUOCs3R0w2OXFM?=
 =?utf-8?B?eWVzcFdWakx0WDNHUkN4MmkyU3AvSDJTVDZyR1JXUkpBS0U4clJYQmlWRzhh?=
 =?utf-8?B?NkpxLzllYzcxWi84NGZFT2xhTE02bGdLZEpTb21va0RqTndaRm93NzZTMmI0?=
 =?utf-8?B?V25OcGkrd2F0OUoycHdCMnpGeXFzWXNmSjZUakJNbkxzazJCbjVWWGllREpC?=
 =?utf-8?B?Y1YxOG1XZDY5dzlVS0UwUXhPWFh3clFmcEtUOUgzTEMrNStyblNTamtBVkEy?=
 =?utf-8?B?TGQzaElEdzUwc3hIZDczS0N0SmpTV0JadG1yN3loSFlQUUVNL0V3bm43RE1L?=
 =?utf-8?B?dEs0ZWlEeXhROWx3Qnl1ZDRQRE5lT3dCVzBUcFBxRFpNcGwyditTVStGMElY?=
 =?utf-8?B?ZkNhM1BncTRDb0YvTzhDNTcvMkFrbXVaZ25Xc2ZrMldXL2NSTW5uK29Ubkgw?=
 =?utf-8?B?WmU0ejRPaGNyNFVrSUxDOCtncFQ5b2FQMmxaU0FwZXNFaDZtRzY0cHpKRmw5?=
 =?utf-8?B?Q212Q1VUamV6TnhTeEJXZXZjRXgrKzZEYU8wMHNLZTh3RUdieTRmdTZMdjQ3?=
 =?utf-8?B?UG56UEVld1NrSWxuR2F5b3NNU3B1bFhzdkM3NWR5bjhxRHlWaXQ0d0lteGRq?=
 =?utf-8?B?dnpvNDFTN2ZXb211bVUwQnh1ekdIYTU3M21qMFRDY1V3MTgzVUV5dlEyMDFL?=
 =?utf-8?B?ZlhQVHZTNGppMTdtcVJiWjA5S2hCR3VDbG9VM0JCclhNU1FtdDN4SDB2Y1pJ?=
 =?utf-8?B?ZmlMN2l2dk4xTTJFY0xJQ1BiMUtPZFZCc2EzaDB0bSsvMzA3YW5ScTdodVFK?=
 =?utf-8?B?MVNUVG02WnU1WnhRV3NnbEwyL0JBa2dJWnUrNUpWSVo5bnlYc29vTXZCVmpj?=
 =?utf-8?B?Vk5rN1hrQW90aHlNK3hVQkVzMHk4d2VxeGFTSERmeW9SNndHWk9EWW1SdTBx?=
 =?utf-8?B?VFBuZ1ZVSnpoVjZueHkvODB6ZGs4cldTNXB4czRYZFByYjhjNWRITDVKQ29p?=
 =?utf-8?B?SkVGbURLdUZSaG05K2VrczdMKzdmRGFlVnJRSzVtQk50SnpSTTNybFI3bndI?=
 =?utf-8?B?dTRzWCtHbFFYRVVuMzJYVVV2OWRTcTkyZjRCQmhtYjQzYkpkWVljZVY2aG5X?=
 =?utf-8?B?ZFVUcEEwQXVUdUhsOXViNi9QUTFINi8yZmpObGlaUTg5Q0lvZnlZcjlpNFdM?=
 =?utf-8?B?ejVsMDUzMmdIeTFNR3lDTG53Wi9vVU5WZVJ6NlBDdlFZdGcwY05IaWdIWEFY?=
 =?utf-8?B?Wkx4bWJWMFl2VkMvTkJQbFQ3emJLM3hKL1QzcjFzNkozd0dwNm42MTl6SWxh?=
 =?utf-8?B?Tk5QVERMY2Z2TnJvNXRjbWhHVkNCZ08xSHVLSld0QmZ1T2VYTUJDSkdVZDJt?=
 =?utf-8?B?VGhNZndSMDNUa21mdHJxam1BKzF2dVlibzBsMGY4UW9MUVVla0pjVzRESkR0?=
 =?utf-8?B?b3ZEVWNrYkc5WUE3SFhiVzloMElhaFFKTHVYdk41NXJzbU1GTEtma29KWnk1?=
 =?utf-8?B?Nk5QVlZQei9tM2dITkQyRnhnUHhjb0F0TnBXd2hWamNodDhaNWlUemtDQTBi?=
 =?utf-8?B?SzNhMHJsck5JUHhTcGJjVjh5L1dHdWxMb3hlSlZPY0FDeVl2VndJZDV1N3Vk?=
 =?utf-8?B?SUY5Z3ZXbnk0WkV3OW53Skp6T3FNb3BTQW9JNzFqdWIvSEtYRlQ3K20xY25m?=
 =?utf-8?B?T3l5ZmZaQzlvaEpZcmpoMm9HanJ1ajl2djQ2ZXdaY1NoOUthYUVDT2FtcFRQ?=
 =?utf-8?B?ZlRTcGlGMDVRSHVUd3NmU0RLV1lDSlNMeFVJVTdoUC9MVHdqZFRQdmg4NU1n?=
 =?utf-8?B?TDFPQWlxbllqTlAyOUFtdkI4TitOWTZ5Wk5uM0pyV3VsbVl4dUxQbmEveXU0?=
 =?utf-8?B?SEJSWGg3TmI5aDF0cDhPMVhuZEhCcDN0aThJNitiRy9lYlJNVlIyU1hva3Jm?=
 =?utf-8?B?UWt4UU81RVpTYlNvVWFNaG5PZUtOK2Q2UkQ5Y3JyWGJqWVNPQjgwUGpRdDE4?=
 =?utf-8?B?Ymp1a2JXa2NtcUIwZ2FVT2FsemNoMm1LN21QR3RaNitBTFFERXFTaHlObkFi?=
 =?utf-8?B?enVaQlA3dko1WVBqQm1RZEIxYTE2Unc5OFd1Q0ZpM05Nd2V4VFJDL0pETEp2?=
 =?utf-8?B?TXJuYnNhZ2ZBWTBMVFViSk0rY2F1MjUrTm1TRUhMWkdYTU9CeG9sVk42U1Vt?=
 =?utf-8?B?MjhMMHhRUWdZQnlhTGVLaHZDbDBBQ0M0c2UyYS96K1BZSVJUZmdXdFE0RFcx?=
 =?utf-8?B?U3N4ZlRtT3kvczd0blR2eCtFN0ZDazhNV1lWNXdXdHdReStDdWlYRmpKUmdu?=
 =?utf-8?B?eTAvSlg5ZmxIZEZXbktUTG90ZnZOWEt2a2h0U1l2anE3akJLbmZIZz09?=
X-Exchange-RoutingPolicyChecked: Fg4VZaiM9/p9t4DcJYzjPyD4TJrkC5nkIPXiEifHXFW6JY7A5l+CZnLOMR84D2gGOOHkQNoT66Qnx4gmrJwe0ybnmdKtWMvmHmM9ajg+14xZ1fVyfDbkd5Xlpxl/wr267Zwf+JFh6d7lT49TBLUz/LUXi1DO5k/ZwGjk8O50sPWHCCfgVj2iZezP0LqKjiIuwRvOol5jV78mB9X7FaJK7h0TDcs6DPErWesT2VR6aapIo0/Cf31dYR1mRnd6VFKntwtbaqZ84Caopwu/RXVjDdPVEl8rqmL1wEkU/AOZDnhg846v1OH0XrAWTYqh5FhEGzaG/sT+c75uWwrAdj+2Fw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e11cff0e-c0a4-4053-764d-08de9696714a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 00:16:42.4483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8O/po9LRr5OVqwQPG7V5ZaG9U8xdm6SaGW6TdwMIXsjqtW5MxpOTvnY/gtfuLWMMPLEVgjjmQgAtf1spdPtko28rTlSGrOdThJjP7wMDGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
X-OriginatorOrg: intel.com

On 4/8/2026 11:22 AM, Paolo Bonzini wrote:
> 
> +	push %_ASM_AX
> +	RESTORE_HOST_SPEC_CTRL_BODY VMX_spec_ctrl(%_ASM_DI), %ebx, .Lspec_ctrl_host_done
> +	pop %_ASM_AX

objtool looks to dislike this PUSH/POP pattern:
   kvm/kvm-intel.o: warning: objtool: __vmx_vcpu_run+0x1df: return with 
modified stack frame

I saw Uros tweak suggested to remove this which can have a side-effect 
to avoid the warning.

Thanks,
Chang
