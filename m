Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4DA387376;
	Tue,  7 Apr 2026 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562570; cv=fail; b=O/76bqW3jiizMowdhenUBd5ENJ7HXLfqsCqpZjTTO/r63p4kTYH8R9wfw5k7F1EVnkExzxBytBjVM59RfxZ1t84W2HIjyZ7OnUpwYTLH2maMslEz6raq8ZMYCdhIou+e6VCAGooTJsBjQlemBJoNrfNV+9GuWmS8Oz/zYjgmW2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562570; c=relaxed/simple;
	bh=ybfc/403OHfYvTMpz/DghjXksPltNcD/Cy61rWo5lGY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JLh0Ch9sJG01juXczw30kb8LAi6Enog31E93Wfqa1NFV2KCONEx1Pl04yD7fxgd4yIJzPOWxQg5dW9/lfQmJChed52oxIymmprQb/oQzrLS2ACp1xs571xQsTL8HFYUkkg0R2MVCAErRKQY/mQX7JyVhyAohun20TrxyUCnYQpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyTF1SgX; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyTF1SgX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775562567; x=1807098567;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ybfc/403OHfYvTMpz/DghjXksPltNcD/Cy61rWo5lGY=;
  b=IyTF1SgXCZJHp32itqoG6TFE3BvMF3v/urEw20ivb5Ei5h7mwUvewVoS
   TMnSfH3WMv7gDyTfTJ2YtLgpLQNI6EVbkM19luhrZklbQqsmjfpYV8ty9
   fKpD6OwWzyRC0NDADicQkUKJcaFR6nX2dXBFQLC6lPm/ni2qjA3AI6+4X
   Sk/cdJzzl7cEw8S3Dlj00HlXgliuSATFnJPYrJSJ4OazOFpgWx2ROS6P9
   JYYCl1UAntS9Jdqu/iERUs8OclcE/x6ZFwgkFFfDZBm10unx8X/HXIe7l
   +cC8lbyMMrzTIRhPWpM7WBoUqpCPmti5IxnloqVjNIIZSYGhh4O6gMAmh
   Q==;
X-CSE-ConnectionGUID: gXLR+LPhSxqAyZTOPcFKgA==
X-CSE-MsgGUID: Flwj0mQTTS60405N+WEiXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76417704"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76417704"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 04:49:26 -0700
X-CSE-ConnectionGUID: 7ugYC9UGS0Skjh3mm+iIPA==
X-CSE-MsgGUID: hOVq3cfNQWOz6GPVBq98Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="224962393"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 04:49:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 04:49:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 04:49:25 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.20)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 04:49:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DO1eXxID7lFlUIzcyamUIcDcGdxZjYeSt4zjR94exzUU7bMAPJDQgW4cMhgIfW9zp08R2XJnXFU+0YoCCcFO/OGLa860LwGTGdnM9X+HpOA21nm8zXK9tccMO3vHR1S8gXBXghHEKyKodCfcCywPCJBDTGFNYaH1ubE9GRkTN/DdNEUUw9bh3tLgn10sWMuhNoU39/jfDJNIRhMHqdt+Vb3DvYKEIVd5taIZYdjBjyeZdk3WMm3ziyFE0PMcLSIo8m4DVZKOzHYx/kE+K3E0qZLbOLsvOFJb45p4YvPPFahnywy5sfI20nupl5LjetQ86pxZaDs79MlVmr6jN1FSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxtJdoa/Jm/YhJFoGKmheKClcbPiFzO1ZdxNU0wkFbE=;
 b=RaZPV1Zc21eIFteh+R9IEF26yFNK2zZnRU9qccMqt2a96QOvUTamk4QByd6A3O6CL/WAnGbGvHQWMqT9vSTQKOWUv2n7EkRTIfXUyM7TzIx0FCv7F2iMfrT2lA3G4lglcJMcS1/VMKt0fxqZ+R5/wS/ItRxvjj4XSzTIuAb76qUGgzQHmk+jH3K2gUyrUhgZkyb37dPPNCob08ZPV7Dr4+tbfhLklaLwQ9whBk+QPD5otJCPAQkaTPfFQwiB+aulBSmaxLteZ+5yeLrZQgXBnHLz1ICb9HJ+J5gzw7/GZecBRo6drYRerZoSwkOF9PKF8NVXG8GjFD/dpNYIOf+FMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH7PR11MB7430.namprd11.prod.outlook.com (2603:10b6:510:274::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 11:49:21 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 11:49:21 +0000
Date: Tue, 7 Apr 2026 19:49:08 +0800
From: Chao Gao <chao.gao@intel.com>
To: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
CC: <binbin.wu@linux.intel.com>, <dan.j.williams@intel.com>,
	<dave.hansen@linux.intel.com>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v7 09/22] x86/virt/seamldr: Introduce skeleton for TDX
 module updates
Message-ID: <adTvNKVRxsp9Vz10@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-10-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260331124214.117808-10-chao.gao@intel.com>
X-ClientProxiedBy: TPYP295CA0011.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::6)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH7PR11MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab69f5b-a0a5-437b-48bb-08de949bb4a5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: TdEyWKl9RhUrAWFtSBiQHD0IX+S3g3S9ISj4HhspMCvyHphtFMlFePevWtaIMUdH0XfX2hCFJjIg6fGzSEey8BFNEA3OlxwlOrDsmAp1AsNYhigN0EdEY/w65pMjcrnUQ/kAbO1Ph0XMng5LFfTzhBoldv2VwdzfmY10/GJJjmnisLj82mzRSMMkxMYTheBBAe4tCp6Vj/MeD7a0WGaCAFoyAUvGJlELMecs5OKsYffj7zANvL+56zbDlazNXjekPoLXivQG9uXPNsEDpkOOoqLNYlI8Itc7mQ9ua87M8SbrWr+JDvguSlNKj0qxeBvg3hFGNDoCuAKLmzRxBxSSS9rpPxIhLRbzVteynqbakSjtYZ0UMXx9XSrCJ+CXAeon5Qq+jjgsv0qJx0Vd2jGsTRqahuZVHRNGl1TefHZoLGbOk0wxjVs3apmf80jfAuJ1dsLSEKdMpWo4vJBelk23eruXyrKIwXx1eWcWdLIOIIdrNa0fmVWeyzcL709eknk8mWvsGJdsv+KtnhplQPAaseW+81GkE3wxVBNmZnXTeMp9vjrRY1L4P85MIeK5JF0Sw59TWQcu+1bRel0FWwNhgucTZ/xMvA1b1tzxefUzEr7YVKxFNObBvoSrTnFvIfJcXgz/huXCB+PQK5f1K/jD96gKp26Bu07QmQRdzIq3947FbV8P3l4fx+RUVL5VdvZcotx64WU13xa6ueUUEBn8/4lqBhQDmusdL2daQU6NTvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Mv586rTbOjBS+buZ8ieNXHbv1va7otmk4IV03JYJ5dFj/Erge0uSy2TIl6S?=
 =?us-ascii?Q?AVKDsO/VLNcbovX1+tR2Y3Rv5Gi7Bey4OYoEqrXT/CuZDn4rgiQ6ML7i80N6?=
 =?us-ascii?Q?tj8sGa69nCHRidyMXFShj1NrOETZZPkimDWE4M3XPEju5ytcVGhSfnm8Tk/t?=
 =?us-ascii?Q?pj0/tjVDcfz4sNI7318zQ5qyb5JYn6E63VQiHCXc9f3TMRxGeeaC4dYV4jBk?=
 =?us-ascii?Q?rZorHsRQ+Hsny/HYtMfB8jryQHedEdtQqCpkn0mwBwhNNWXaYXpcYicT/rHz?=
 =?us-ascii?Q?/6Cb1SJ9vuypwstVW/5TBOaTVznhVqbyoMMgKF3la+OquqNfZqgMZWyKnHw5?=
 =?us-ascii?Q?8tjbN2II4X6vgJ9TB9C0jAVECh5TbEe2vpG4Bqck5XZXey5bp4a85HBq4sRg?=
 =?us-ascii?Q?e8yvS6yWaWWA1jbbOtd6Q6fxahFdDZIojT1PkyxbgXf/84Pl6s6mCJ/IexQ4?=
 =?us-ascii?Q?pQ9A9euT/Ci1vCbkpjjzMLjEsrGRAI0dX0MLZFoxkpYdB9zYru9uMviQbA0c?=
 =?us-ascii?Q?EONq2dO/Pp09TQtSXTCUwJlR1aHb1ItuKzQcSUGFlGuhmrgdI247AOeQ1zRe?=
 =?us-ascii?Q?tQNwa4Xd3t7T72Y2WD7GYdVZOSQhQNaNNllw/8IK72W3ukEdGFiUhI0Vl3Ue?=
 =?us-ascii?Q?1hwoKm2imi3gcF+QdAap7ggV4x9NYTT16c1Icv+Z9IggaqsYmBdkBnx3VeDo?=
 =?us-ascii?Q?OqKHtYbvriCgLhuxy2eFY9rWZV7mn6ErXURSVWUS8I6NwU4Dq6BGSUeWkASg?=
 =?us-ascii?Q?dTSPeQ8uvq2KbE+l+WrFm+E3tjyHpCkQ52PsmJfyKXpMqDp8AAc1XOfNy6fo?=
 =?us-ascii?Q?Nig58pN9O8fCDdtav4jKWVYpXh9oyuo9EDJ74Wssk1V2UvxVzE0F2NwOYony?=
 =?us-ascii?Q?ua4FnoEOPTHCYQ8nzexgEipjVf9p7gZoxneLT8oywQd1YiSqIEua5DOVJXDH?=
 =?us-ascii?Q?2PMJ0U0rp4jzcLP6K8SYH94PUmDL7mBNhQpA+u12stdoj4CeiYjigGM/QpSm?=
 =?us-ascii?Q?3BuIQeD0EenXrvdx3fAjeVFE8niQnHstpOr1dLbVTHt1SjYlZrZ+dtpe1pUe?=
 =?us-ascii?Q?aFjMB/iuBS/uUbw36pGArc/QhzlzeoDKvlUQRpgupWTwhEabuRjVbxx8eyWb?=
 =?us-ascii?Q?fGGzhhhCSeLeqcjUI4PHJlad++uoFBeZFss7BOgpkiqlxUi1FwOWySqVMtyp?=
 =?us-ascii?Q?RgalI/bsd4yoYdU8Vud4Z5Czmtg+qA+LIdyH7tWXoZtAAOxPcQbvpsyIM1iz?=
 =?us-ascii?Q?1GRPZh/R6z3fSql6S4I/37wfhKXYQlR5I/1dnhzTFLeiQg0hqY9s+del/FA3?=
 =?us-ascii?Q?y1Myt2n5FM4RBZgecWTNGBTnPj5kfu4DEgfYyHsRox7lQxSpiCgjDDBT7h0Z?=
 =?us-ascii?Q?bDhWDGG/A9BvVKVXOrMqk3Km7fu8rvGwaCJGkDqD1he3FIlQ6j+t4KYcB553?=
 =?us-ascii?Q?nF2vvA9jRI89hFwB7sTbjcMCAPgeyrmpp0zimX+Nd5PLjlduPhyZRKRnRUYp?=
 =?us-ascii?Q?rWqpphLE3Qsm30hSZF4Va+36fhrHRh+Rve/93x4usV2jpAoM6eIaBUOCCsCp?=
 =?us-ascii?Q?AacmQbDrANBUcCF2AQPQye1e2Rpb0PpqL4/mLkycvJhXcXJrmZkhzVQQN6mB?=
 =?us-ascii?Q?zvIDqAaevaTlnM6dbiPOCAmBoLwUrmUg98D/iEl/i3JzgnwX8tnRS+0sYsSw?=
 =?us-ascii?Q?G6RDaIifmZ29tq7LlW8sRjK/VjGPeOOUJ22v7RqihZ95P4KCUSdhGNagdUH3?=
 =?us-ascii?Q?6MU+MumeeQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: P717OG2cTcqpkpiaW635RDFS+oqM7vfNZTbWNRCivxaXvIuCJpD8eJpF3lGnwfvuu3Hq8/YoM2OlMAv8K3I1c6jYG2BbuZ6cysPuACM9Kp0D3ITlmhkC1vrH1Iae5d+79czKFCEf02eoWSmidlJMgBx6/8OpQXJD8qxSnSmGQm2Os29oriE2AJzWMtlTlOwWK+U0fs8vKhkYubMimsidFH7am9CHu5sEaXHZyXzVANnPgaCchcbzNoSy0YtvCgM0Ajj5VxbM9fmmTuR+o4u2vc1o3aT599thXL5Tx0t8/MUUd7m0QlMx7wh0dftx8j/kWekPAkoXc+TZw8sWSHiX9g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab69f5b-a0a5-437b-48bb-08de949bb4a5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 11:49:20.9160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdW1oEXWAJIBJeVsK94ZLmJjzir+sgZjTHkIy/8n4q2PlhOQfL2vLxFLyvccA2UTafwvhWjo/p81GaLmi9UFfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7430
X-OriginatorOrg: intel.com

>@@ -214,7 +287,14 @@ int seamldr_install_module(const u8 *data, u32 size)
> 	if (IS_ERR(params))
> 		return PTR_ERR(params);
> 
>-	/* TODO: Update TDX module here */
>-	return 0;
>+	/*
>+	 * Prevent CPU hotplug. If a CPU goes offline after thread_ack
>+	 * initialization, thread_ack will exceed the online count and
>+	 * never decrement to zero, causing all CPUs spinning forever
>+	 * with IRQs disabled.
>+	 */

Applying Dave's feedback to simplify comments across the series. I will change
this to:

/* The lockstep update needs a stable set of online CPUs. */

>+	guard(cpus_read_lock)();
>+	set_target_state(MODULE_UPDATE_START + 1);
>+	return stop_machine_cpuslocked(do_seamldr_install_module, params, cpu_online_mask);
> }
> EXPORT_SYMBOL_FOR_MODULES(seamldr_install_module, "tdx-host");
>-- 
>2.47.3
>
