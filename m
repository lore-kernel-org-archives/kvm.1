Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675D83D4131
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364874; cv=fail; b=gjg6oluc6Lt+hXLGMq7cFFxhXViOm4b4LKIlsk1jJ6i0xx+wjbaQ8xnwe+8YJiSBJdc3RffgGZQ5r1BkZ6TpmF2ZkVljDYCgFcxU4uFC2OavF32FJekz2xgI9oCkGKQVT8OLySFkjiqoNPODPBn/sZApn2Iaw3gm4eZoIQsSBpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364874; c=relaxed/simple;
	bh=37uN0H6cgp+JGGz2HiBe2Em/eA4Vu7BS73ThgQuq/0g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LY9dwpJo6bdDxkQw0M33d5sweAERRbnvDKSHNImNHtw7c78395ZXXW9iHI3ETiJCuzMBaGoNfGZCYFSONc0uDp1ow8Tb7QG4aSty4vkeBkcezAa9RKSBLqIfYmwcr43CeWqf9IQ6qOpZ9U+ntGsop86nqAU7qw0g3HSlN/ObOeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWQy/yZU; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWQy/yZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777364872; x=1808900872;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=37uN0H6cgp+JGGz2HiBe2Em/eA4Vu7BS73ThgQuq/0g=;
  b=ZWQy/yZUx+0utSQG0dnpLUDtWoC8cyhSP3thct0aco+UkRGq/pgiJ64L
   7MHMYcttOJdipv9UmSvaT5H5Fg5vIXR3bwjQEgNIqVUf1VnfBXdcuHe61
   7x0rUkTNDIs5R+RRB4OAvbyDJ8QWZFxFMHoQFgjhg319CDKI/xn5sKaDR
   KOcoP/Pa87mMSbCmRZfzAf2ESQBcdSI+uRvsTclRi97GmBkXxqu0nGnUK
   mSHjfwrolY3+TofpnnXBJ6g4XqcKlF8PLunE18xgudKYNrIy3RcERPcQw
   4EdaNcro3eAbJX+9rtDTgy1c6zhca/D43Bo03i/TFU0s/9LEltJeSrZ3r
   A==;
X-CSE-ConnectionGUID: LJJ1bkv4ToCN2vReqndcHA==
X-CSE-MsgGUID: nGZAKAkNTWGi47QNRqYATQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77431324"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77431324"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:27:51 -0700
X-CSE-ConnectionGUID: 7RiB48r1S5azbVdmhyDYLg==
X-CSE-MsgGUID: OTWNJUFgTtOaxhJT+RRhRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="272020586"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:27:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 01:27:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 01:27:51 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 01:27:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHA5w+CGF8/jqD5WHBHAmsnXEgx3TEEevXPuYENFMRZ1Ev/gQCvfSvFHLZX4kE+u7ToOpImtUu5OxktabBguprQ3s2nXVXWTlpIvvnirnMQhPW0SdWjnPX4n93E5yf80h5Y9SDl1y/QANCVauctkM4rJzMwIbp5yU5wyejIJvTUBAj+g7PxYQOn0F+Qhy19y2xrOnUWFacXpm33W4MUhUJXMhaI/8LqzvRM0eFKNQ074ATF9w5Sr7GBFQJlLhNIz3LgPWtrokMN70+DsSKTA0RGckGlwAE/8fJ7F50ECcpZlwf+FcgNoPepMWDSRAhEXCnrgdb8Gf8XqpgD2oA144A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzpUjQulw0feuYU45RgunDDVmj39klXSQ1Mj40ZIFeI=;
 b=EaHRD5omDZ5PacNy0M3bjXYvBPvOgTjAwRAN8MMPhZJcUhb22CNszEB5GBAtMZnXVGNlHZ0G7w6EHZlxK3fWI3zaeqz4hgH+6NL/Zj+5zO32SJt1Z4eFKHcbaGI0Pce/YLyc7FATp3HDetDS5TXiMH9xlT0k6JoPDsyKM/CYPVExLOOu/dGooMwXtU7nWL7H8JfCgPybVaL2hfKKGoOmI725UHkDLNyHr5stGoNSQbhJ+bCmauiBVT95VBX+uLCJAr9x1HKII5KH4AuzWZWKSVbryUFtTUTxwqDVLLiNngFxr+GTcZHdlRdmMKkU3+H8nMRlp/6sL5Yf40H09+CYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.18; Tue, 28 Apr 2026 08:27:43 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%7]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 08:27:43 +0000
Message-ID: <04c954e6-a23a-4cc8-8bd3-5882a951a8cc@intel.com>
Date: Tue, 28 Apr 2026 16:27:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: VMX: Fall back to IRR scan when PIR is empty despite
 PID.ON being set
To: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Jim Mattson
	<jmattson@google.com>, Gao Chao <chao.gao@intel.com>, Farrah Chen
	<farrah.chen@intel.com>
References: <20260428070349.1633238-1-chenyi.qiang@intel.com>
 <3235eb76-9b28-4000-920a-491659927e67@redhat.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <3235eb76-9b28-4000-920a-491659927e67@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|CH3PR11MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 7332a2c3-5275-4b0f-3e6e-08dea5000495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: cvIq5KXx3LfEu/geWt/9gFkq4BtPNUaGCaMhQit8/SJ2Ok0ChGGmEDTxKCNC80EHV52AX19cRjFEEP929WYB7nU/PUB3kQBfwheDhiM8tk0w8K4NeHw90cZlRExqa2U92JgPyiW2IaDaQ3wvMcmFX3ZmKHHaDYZ/WZrFYIxh0D/H2ka2PIU/OX7sSxjqrsCPi6DmtKpsuqolWvwxR//SRR1OvtrTOfG9WQc4vhkDEGy65LarJ8zzSdT1ZOlTZf4buXSes9lwuI+1BiwSpixQoM00JQ6t/sahG0EYDwONl0Fpr0Kc4g0ADOgDVpkJTxcOQy8hLCstf9WrwobN/cPn8Sg0Y+JmPW/zT97xTqI3TCtTMiaJTGmHqH5la7yarf94L2oKSBnQLx7y+v+m4mJaIgllDHtSCMq14Lvdp17AFjQpP6kVrFqZMdkfnQ4B66idojrbG26y7X1zZrJOtuHwCf0o3c8DnHU4WmzlaxPrVlPVCgNtuA/K4ztKXx/EB965TERRzh25mQTeEvng/NgLql2xtFAUNDhTdtZFmWXZOs9zl7cnZ2foiVOdP+ZfIcqIqillv4uG94wXtPgfRzH4+MjHBwwpPOANEPQTjdL/j2OT/hiYn+edJXjWkptXPvDpSP7x34YZcqngcCdNQe11l/SLaQVzR9iOfhGFEYkC2mOQJHsTn08V4vYlaggvYkRZY+3Y5W1cm67sWrnOChZEECrkDQd4r/ktqCKXov5Bqwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0RxZHZEQVVKaXdJOXNUSHEyUmRvYjZ2bVQ1enQ1Q1BtZnhhYkt4OHlEcDRL?=
 =?utf-8?B?enVzNlhSTUtIdVlDWVkreXpTZDB3cHZjQ3VpdlA0Y1haTTVoNmhvQnE5aEZN?=
 =?utf-8?B?RlJzR1U1V1ZrZVhXSE1yeENwVVNwRERPUllVUXFkdGJET0E4TlZ5N0gzb20v?=
 =?utf-8?B?VWlzVmYwWTlTNVBsOGhZSU8rQnNmZFZGbEE4Q0Z4OHRDZnpJUWhOVnU3WUgx?=
 =?utf-8?B?Um9HOVNjU3RlUFRudndIQk94Z0hnaUt3TjRtekZLMmdBSThmbVZ5cWc1M0FX?=
 =?utf-8?B?bDh6ZEtweFowRW1LL0JBdWRMR0tHdUM2Z1pnUnhRcXNyVjdnMjNyQzJHWmto?=
 =?utf-8?B?bmZyVnF0bStnamFFT01WTFZzcXkvWndPSXlDaTJzelBkY1pydERaak1zNEgr?=
 =?utf-8?B?TnA3czZFdU9XcFN3azZWa2Z1R01Rcm9wVTR3REdaOG1pbHRraFJjejJxSlE5?=
 =?utf-8?B?RjhvOVZkZG5IQWVwbUNBaXRFeWhDc0Z1M0s2MzQ4MWdRdllLRlFpSlJzaHJ4?=
 =?utf-8?B?dmxuRWJlNlk5OWlDSk5QWjA3YVZwR2JWL0w3aFU4bjlWU0o2WFozSkN3Q1pm?=
 =?utf-8?B?cVpKZThoUFEwVGoyVklIdnFUUlBXUm1adVFYYlF4SXJuU2E2T0dMcTRiNUVk?=
 =?utf-8?B?UEVhUlpxQkpENTRvNWxkQ1hOUW1WYTNFaFVhSWk5UnhTNFV5UXowWHZ4Yldw?=
 =?utf-8?B?cVg3Wi9MalRuYzdWeFNUY01BaVpNdVl1NVRad0liKzZVdjVUL0J3ZW5Ya3l3?=
 =?utf-8?B?Tk94SWpUejFjOUYwdjF4RW5MNDVvOHY0ZWJVeFN4Q2g5RXNSTGh5REhGcko5?=
 =?utf-8?B?d2d1dDRrcHM3R0hzVWZoMTV1RENJVlF3aGUxOWs1VFdMMWdORlVCVllvU0th?=
 =?utf-8?B?VEM0cUZWNHB3d1Rzc2J1ZXR0RjBpWVp0cVc3c24yYXozQi8vWUlyWldRamo5?=
 =?utf-8?B?VGtFZFkxaGFBbVBFcGZTMHlBTUVGUWw5QTdWVDFqNjR3NGxscmttZGRUSlo3?=
 =?utf-8?B?dTZaQVRURHR2NDloYkVKelRlMStqTHhpbTNsQlZ5dGcreW1BVndGaWdjc01u?=
 =?utf-8?B?eHYzaGl2SjR5MitzY3M4Rm9iNDYwbnBqQlNPUDZVYXAyZWxiMnU3VDdWNFVy?=
 =?utf-8?B?dkVzUHNkMytqWC9JK3RSSlYvQmEvam5QT1gwVzF3OWVMZ2toOFZ2TGV2NkhK?=
 =?utf-8?B?Q1lFYk1PK0hnend0ZVAxRXFwV1V6MHJ3b1lsSGtQWW1HakxXMUsxb0o3Tklz?=
 =?utf-8?B?OTV4V1VWNmQwYjgrSjdndldpczBCb3ZyMjBJOTlnTW1XRHVnQWFHNk1TZW9K?=
 =?utf-8?B?ZjR0V2t6enhPYzJ1Y3dWZ01xR21iRURoQ2NxVlQrVmpiZ1FhcmRyTUNCV0JZ?=
 =?utf-8?B?bVFhTHYvRzFSbGZSN1V3alRFbnozZjhOQklxNVRTQjBITlhWYzExNTVFbXFV?=
 =?utf-8?B?aUJUcWR6VmJGL054andtVkZPanRTSDgzN1gza0d6OTJlaGJkSU9DQ1VjeGQx?=
 =?utf-8?B?ZE00dHJKbWJuN3lZMWhDQURxTnhkY1VGa1RWRHQrcVFwNVEvOU12T3NwTHZu?=
 =?utf-8?B?ODE4OGdMVGZVS1VQTkpQODRQSUpDM0dyYVdYZG1hM0ZBOHBCTjBJemNSbWZN?=
 =?utf-8?B?bmhUS2ZtOEFaamNaSE1zOW8xSGlrV0tmNklmSFVXSG1oOUNUNEhjNUVWcFAw?=
 =?utf-8?B?TFBlVTlmMVBZb1lpNE9OWGxHMVZvdEt0KzQrcGQzbjk5dUVoQUc5c1pIUHQy?=
 =?utf-8?B?UWpPYVBtcTNBcEZXa0RtL2w2Tmd1TWdJa1Y1WXVtTWZ6MTBwdWpwbGN2T3lR?=
 =?utf-8?B?Sk02Vmp1aUJIbkxwbjdwUUNsTGlCU2VHWFpjZmhuMHdIVE1HNVdVcGMxVWxV?=
 =?utf-8?B?V2hVd3MvRGpDeFMxa0NncXQ2RXJpRWl4MTJOeEF3QmhoVVpMb2JQWmw4UWZW?=
 =?utf-8?B?a2J3aktWN3lCZmJER2xBVU94QVZYNGQ0MW1SVXZneWY2UGJ2Q3JzWG5yU3lM?=
 =?utf-8?B?MW82L1lvQWZUbWZPaVMzVHYvME9nY1J3cm9vNDdVbCt5Y0IvVDlMYys1NitC?=
 =?utf-8?B?WGk5eXBBSWNwb2I0QjY2ZVBWR3FkT3daZHdDV2E5L29vZU1aUC91WnlqQnc0?=
 =?utf-8?B?QW82U3NSUmQvMHlYUHhTc2FSNzNhVkZmT1ZhYkp5a3pSdm5YRmN0a2NGTVl2?=
 =?utf-8?B?NDhyam1nQ1BDWlFMa0MzU3RLOHRhN0puMGZrSVhnaVE1L3h4YjBockZ5U0VZ?=
 =?utf-8?B?S0VYdHNYMUE2RlJ5Sk5RdXhJaGtlSlRTMUNZZndrUTZJVndmTGRXNGtXQjVo?=
 =?utf-8?B?cHRQYTlQalFJbFVxNWNITEs1TU5XZlhGclJMa0gwNzViUFp6WmFCUT09?=
X-Exchange-RoutingPolicyChecked: sKkpHJNsdtI84MsYGynsPLOy/PeSWUIEhAiChYs0x3eksgwdm1wPW6pF7e+eMsmwSEXRiBa30iEzV8v1y7pSgrNUmzHUplwwyloLFsje+iB5lXBLuyJ1U+Wa46vMNVTsfqkml9Tx6VJK3Yn2WO6KwDWH/ttQfY5gEHoOlt1fkd6FGydn9bfd7qOpyO8ZR27/4tVc+4QNUToahiNiOCf8yK0OEk5sbVf0MNUhqJ/cfDAA4X4xQQ52sOvzqlZVbqv/1EGYy8l7IUEqgijJeO6nYhecsZ9YKh3AZhw5BiNwovrKnV1Owavv20R5teEwUiclJ1T3AigbdEkOpqObPMxQHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7332a2c3-5275-4b0f-3e6e-08dea5000495
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:27:43.0538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zw8m6NAOZZ54HH3TnKCaRfBUKZL71FUNtpW8Ts9G/TSaPcgVc8xMem+Sb2YZrJqG3vh/PgMxVWE8yhJkH09IbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7180
X-OriginatorOrg: intel.com



On 4/28/2026 3:45 PM, Paolo Bonzini wrote:
> On 4/28/26 09:03, Chenyi Qiang wrote:
>> Fall back to kvm_lapic_find_highest_irr() in vmx_sync_pir_to_irr() when
>> PID.ON is set but PIR turns out to be empty, to correctly report the
>> highest pending interrupt from the existing IRR.
>>
>> In a nested VM stress test, the following WARNING fires in
>> vmx_check_nested_events() when kvm_cpu_has_interrupt() reports a pending
>> interrupt but the subsequent kvm_apic_has_interrupt() (which invokes
>> vmx_sync_pir_to_irr() again) returns -1:
>>
>>    WARNING: CPU: 99 PID: 57767 at arch/x86/kvm/vmx/nested.c:4449 vmx_check_nested_events+0x6bf/0x6e0 [kvm_intel]
>>    Call Trace:
>>     kvm_check_and_inject_events
>>     vcpu_enter_guest.constprop.0
>>     vcpu_run
>>     kvm_arch_vcpu_ioctl_run
>>     kvm_vcpu_ioctl
>>     __x64_sys_ioctl
>>     do_syscall_64
>>     entry_SYSCALL_64_after_hwframe
>>
>> The root cause is a race between vmx_sync_pir_to_irr() on the target vCPU
>> and __vmx_deliver_posted_interrupt() on a sender vCPU.  The sender
>> performs two individually-atomic operations that are not a single
>> transaction:
>>
>>    1. pi_test_and_set_pir(vector)  -- sets the PIR bit
>>    2. pi_test_and_set_on()         -- sets PID.ON
>>
>> The following interleaving triggers the bug:
>>
>>    Sender vCPU (IPI):              Target vCPU (1st sync_pir_to_irr):
>>    B1: set PIR[vector]
>>                                    A1: pi_clear_on()
>>                                    A2: pi_harvest_pir() -> sees B1 bit
>>                                    A3: xchg() -> consumes bit, PIR=0
>>                                        (1st sync returns correct max_irr)
>>    B2: set PID.ON = 1
>>
>>                                    Target vCPU (2nd sync_pir_to_irr):
>>                                    C1: pi_test_on() -> TRUE (from B2)
>>                                    C2: pi_clear_on() -> ON=0
>>                                    C3: pi_harvest_pir() -> PIR empty
>>                                    C4: *max_irr = -1, early return
>>                                        IRR NOT SCANNED
>>
>> The interrupt is not lost (it resides in the IRR from the first sync and
>> is recovered on the next vcpu_enter_guest() iteration), but the incorrect
>> max_irr causes a spurious WARNING and a wasted L2 VM-Enter/VM-Exit cycle.
>>
>> Fixes: b41f8638b9d3 ("KVM: VMX: Isolate pure loads from atomic XCHG when processing PIR")
>> Reported-by: Farrah Chen <farrah.chen@intel.com>
>> Assisted-by: GitHub Copilot:Claude Opus 4.6
>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>
>> ---
>> There is a WARNING call trace during a nested VM stress test. AI
>> provided an analysis of a race condition and the related fix, which
>> looks reasonable to me. With the patch applied, the WARNING can not
>> be reproduced in overnight stress testing.
> 
> The analysis of the race is correct and changing the logic is the
> right thing to do; but I would change directly __kvm_apic_update_irr,
> either like this:
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index e3ec4d8607c1..5ee14d6bc288 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -669,12 +669,14 @@ bool __kvm_apic_update_irr(unsigned long *pir, void *regs, int *max_irr)
>      u32 irr_val, prev_irr_val;
>      int max_updated_irr;
>  
> +    if (!pi_harvest_pir(pir, pir_vals)) {
> +        *max_irr = apic_find_highest_vector(regs + APIC_IRR);
> +        return false;
> +    }
> +
>      max_updated_irr = -1;
>      *max_irr = -1;
>  
> -    if (!pi_harvest_pir(pir, pir_vals))
> -        return false;
> -
>      for (i = vec = 0; i <= 7; i++, vec += 32) {
>          u32 *p_irr = (u32 *)(regs + APIC_IRR + i * 0x10);

Make sense. This resolves the problem at the source.
I will verify the change in this way and respin it.

>  
> 
> Or even ignoring altogether the return value of pi_harvest_pir(), always
> going in the loop below for simplicity.
> 
> Paolo
> 
