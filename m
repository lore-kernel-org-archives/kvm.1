Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294E02F99BD;
	Sun, 14 Jun 2026 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781436595; cv=fail; b=AcvCoYolilCZdfgmw6pl/APy7/44qvsaet9ysVp4kvmIOqn4SFiUp9dBVrOdbzypI8Li7Jv+q9014oeD3h0YtjkgQTEmakxZjSONMT563cEqmDtDd3/+CzFq89IcqKG38QEPNipCm2HLU9FZ8GHtsm9Zvkbb/D8IVjcFuigsf64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781436595; c=relaxed/simple;
	bh=/sM7fSy1rByj/pO3nD6zPyegaSdrFyDZ+BpsVSayjaw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GJ9Trwm/ggTyhUJDVKURrFbTf246MKW/9cB7h2Bdj1qLB9uT6GnuZ0R8/i97E/VvSY+/YkwJtidN8IYmepcg21/D8F2Crh7yYVEXdKop2X8ezysYFPoub03z3Xj6PaEb0ETh/nqLdNG2NFairGpLL1LAeWI9DWylAm02MFkNai4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PlJSEmU1; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlJSEmU1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781436594; x=1812972594;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/sM7fSy1rByj/pO3nD6zPyegaSdrFyDZ+BpsVSayjaw=;
  b=PlJSEmU1Ipy0gQC8JPfpkIELSENWzQqM8FNRIAYsG8xleoCmzJTe/cxs
   WcH6fn/CDHVgPwjRNg820wVEfPakggoOoCt8Sgyq9iiE2tvdQWUNKgxfi
   fXyfU+3SzLIMKiASx80PomYZFuKtkMVv23KWy+EPb3qrfHvCpW1z6lXaL
   ah0ODLDd9hzIHUNzgSaSzQILgydHfxlIjfd44hY/Ydl/5zZPRMgyPmHKM
   uwA1ze00cXCoUWyvFlxaUM6VJJY+6lCFi3SFQqSB2o04NWV+J/GKiGv1F
   Fq+cG/2YwCIlaYFD+FndDJ057bXEQEu0K5jYRW6BXYiNG+JOCoeiYEcfq
   A==;
X-CSE-ConnectionGUID: CWw8XbfVQyq+rEQmyOznUg==
X-CSE-MsgGUID: wEWN0hPbSeKExCDv6xJCjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="85834230"
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="85834230"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 04:29:54 -0700
X-CSE-ConnectionGUID: L8tcLNJxRyumoydKdvW/NA==
X-CSE-MsgGUID: UA9A/dodSZa7OhWytzqPOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,204,1774335600"; 
   d="scan'208";a="252165471"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 04:29:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 04:29:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 04:29:53 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 04:29:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/lcKYnIOxe8YpHMnVoKa73TOXJbVRTyB2+vkJiaNQo1fbQhHpIP9dANvkWtzNnhSIQNqSTptmWYytOfwutqVm2qNOZp48fxq2wZqO73Ici+PPoeFynC43rJO/x7+BiVgdsLpP5MMUpfXRyrVKd4ryG0xVBCLDaFpFv7BD6i7p0W4PsP9UXxgYyOctrfYe2svyCd0gRIm1k4R07qh8aeJtVe27VRu5VkKccAL0C+OXre6SoAnpNdONjeL/3ZcIN68/cm9i9SjhtP5TPEm2CgWrXTMxLKfCxkIO2PKZ30LlLACFr86mTHY23H047yCb3Ph9k41UKRx4Q5AR9UgCNeuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUiQ4RF/gIEz8BEaj1R0UeOm0YcYHEqD5Ad2jQ7Mdzk=;
 b=w3EXxzbPhSSd8I6Bb8hunxqzTgOtqUTNSmJ3f+O6GrBpY3aN4XA72wG0F9fkYIXHNJvE9o9RfioO2ztybnFKug59VBMignZb9JAHHmTw9wymLyil5nN0ex8sqFFc3/YDLs+L/gLvhcw9iPuDe3FyGbJUOgMdb6xuMoY9yeTkbYMaK9xkxRbLuUQJF9NhPlxJUoKVMU4SzE9vGGALJe6y5IwoioVEmGBi868pTUXG4jPKs/bszX3s1QkSDpHSWDG318Gqg7XeFe3THDYvY+6ZN1cJeI3k1BTEvP4UlPrmEFsWlqlmY9yVRQqGKPGsyzsG/p8MEiwuORAwx9nIJZ2V4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by IA3PR11MB8937.namprd11.prod.outlook.com (2603:10b6:208:57c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 11:29:50 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 11:29:50 +0000
Date: Sun, 14 Jun 2026 04:29:48 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kas@kernel.org" <kas@kernel.org>, "djbw@kernel.org" <djbw@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH 09/15] x86/virt/tdx: Add interface to generate a Quote
Message-ID: <20260614112948.GG3200182@pedri>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-10-yilun.xu@linux.intel.com>
 <a10ad58ed8092e4e7d81be1995438efd21647fde.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a10ad58ed8092e4e7d81be1995438efd21647fde.camel@intel.com>
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|IA3PR11MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2769a3-7a05-427c-f646-08deca083efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: AvLKuv00Ezl4fF7xr9S1zKj1G7bWBGg7RwJWNZhnOWvgqs152GLkLP4/rmyyqQma2m9CA1gghd8TojJz3VWB31AgISqDOlX3obKwcY1fqjN/qLTE2s2DpfM14z0tfu7cJU8AYKkraa2Rp3nJPnUmGHcKU7td1Gz1XM7ndA1txjFDY/ABGK7HIDGCLuT+yibh9gGeR8mcwE9/cxMXrRfrwZ1Sl7v5KItGTm/dbPYCbjn0GjQa4isDZoCLoa986aYeBDMpktQi3cYdWgY2TggfkA3l8Cj+gCZUobcDRePIpjghgWEKtIUMI19i+WmO7/N2PPphgbnUJTfAPU/ElsL78q+R05RY5jxFu+K/irTlF1MOnR1SWAAZf34GWsYYz2UQcvBYcDCrptIrbF/oyTdnl4DTU3mnTYGgiW9KHuvIecBzbNOeo/bw9uX9zaZ+9iBcLIOP/7nxJHm24Euo7OR19dkz1SaCiP2cnzzqeluYnNusdpTh/JPpWO2CkHoXT1tQpqJddfQOg/g92skwd9AW525mq3sygWp8SI8d1oXxNztxR6/TdQXU3cGMPbH2gr7NWpa2V7038hu7uYpIiu1bEluBeshzKbL4XkFeROAAUUG2QfpddSuMobW6uiTnzwnsBZJxTRiaULZ2AzqcxuRaP9mH75yk4lYHZdcOmWLpma9CWjzJFRyNPlUl8NAr9LHl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzlUMTE5dGFxM3pPaFhOcDR2ZU1ZRWRtN3NDbkhtOWpuTjJ4NmFwQlJCWlhN?=
 =?utf-8?B?Kzkrc2lsczFtck9YWXR2Wjg5WWo4bXJITG10czRwK2RqWjdNbGZsTjZBRXZk?=
 =?utf-8?B?UXgrY0FNZzJ6elR1UHpYeGxXcXkzWjdUNmtIQXJJbXpJQVJLSitMK050eXds?=
 =?utf-8?B?RzJlNTNuRFRMWVZxTSt6Nk4rMXVEdEN4Y1dKS2ZCV2MwMGE2NnJlamJVMFN0?=
 =?utf-8?B?QWtOQkEyVzI1bzZRbE1tUXhtNUE0Q3lXeE9uY2dTTXBPQTBUenF5cytKdDJQ?=
 =?utf-8?B?MHAvSGRrZHhRNEo2bU8rSjJ1eVFnME5XRG1keWs3VDhrdkltaHFacWNIZlNR?=
 =?utf-8?B?SU5OakFkd2RUczZLeHVPTllRSFJ1QmNacmIyWXdqMWNDaW53ZUhGbDBXSTJM?=
 =?utf-8?B?aGxQbWh4MStCSFZKYlVJMFpHdlFyZktEeG9MMEJCa2FTZUhCU08yd2RoTkZu?=
 =?utf-8?B?SzE5cVpaY280WEZaN1NZSGZJQ2w5aXhtTWw5MmtDRldMNFpEM2M3R3VGZmdF?=
 =?utf-8?B?ZWd3NUtmS2tDNmE2d3M3dXpqNWRad1dHM1BaV0tkR0xMUitpQzYzRHBDcFJh?=
 =?utf-8?B?MnpTb1NjWndPMDVBN3Y1cVAySnhSRWNYbzZOS09mcDFwMWhlMXFDRkZYUjBt?=
 =?utf-8?B?QUNYSUdHam5DcjFHb3AyVzhUdEJjN2ZlV3pXUk9ZN2tPU0taYjE3a3ZpRWwy?=
 =?utf-8?B?eVY2Y0RNSHFJRlEzcHA5citsT1gyNFVOdnQwSnE2dU9HTTNFWWtocTJVaktD?=
 =?utf-8?B?NGoxWFAzZzBndk5ZdDJhUGgwOU9ONlk0OWRMbUtFOHcwaEhNSk9OYWtjTWw0?=
 =?utf-8?B?a2hXdzJZUHZ3K2NGLzhDTUUrT0dOa09Sakk3WVEvanZKeDZNMzcyVmFPL3VB?=
 =?utf-8?B?a08rRW8ralRmYTRkblpLNjdQL2RIdVVDSmhoK1NOZEtQTXBuZjNHa1AxYTB6?=
 =?utf-8?B?STUvbk5oZ0ZSd1N1ODUvM3dJMHQ3eVJUcEV2bTlxOXBISlE0NnpMdHRtb2lo?=
 =?utf-8?B?dmpBOXBJS3N4N3FtaGlDSHh4UzlVMHFCSlRDd1I0b1licTVDMldBTFRnQjJK?=
 =?utf-8?B?WVh6SGswb3pUMkhycUhuQ25rNFdzd05peFNXNjQ0WUhkYkJFWFNsaTkwd1M2?=
 =?utf-8?B?T200NmExMGJvN0Iyczk2TjIwaEx4NzRPZzNDbDl2UEUwaW1wYzBDYll5VThX?=
 =?utf-8?B?aTU2ak1TajRDNWlNUXVZNWVQdnVZUHZ6djhNTU8vQ0FHcEdteU8xUWp4cVVt?=
 =?utf-8?B?dzVua3JVS2c3c0k5dkdJNzBoTFl0d0lrZlZpbWgxdm9zL0tkeVBjd3pTNEhG?=
 =?utf-8?B?MEZyQ1VXd1U2K0gzeXdndVJpYW8rcjFQWUh0Q1F3VHlzY3BIazg1Rzh5RE95?=
 =?utf-8?B?amRiQWNtUGlVZXdvMlAvMy82RTRoRHR5cnlMa2RXNk51eUU2ajRFSjNTVnR4?=
 =?utf-8?B?WU1KbjkvNUdoUHNVSjJOeHVWcHAwMjF0VlA1OWxXby9FWFlLNUU5ZjJ3ZXNL?=
 =?utf-8?B?ejc5M2Z5VnJSWEpnaGFrT3JjQkVwNWVqSkc5MmhubkVLWllBSFU1aXVqMEFq?=
 =?utf-8?B?QU1DQ25xUENzemkySUxEQUdmOXRmL2NMdWZBN3JNcmFJSlE1aFZmYi9Td014?=
 =?utf-8?B?SUozUU1KQ1JlTTlQcUpqbUt6cnEvZDNpQ0tod3BkRjVqbnlGQlFENVpXdm5R?=
 =?utf-8?B?ZVlnZW1rcFZNZFl3bzNLcUtoTzhiWGpwWENaL2hCaWJRTTZLcC9tVSttQ0Fv?=
 =?utf-8?B?akU5U285bGhRZmkveUtBSmlNallBc0FUY2l0Y2pCbG0za2dPSDA1QjBHZ3M4?=
 =?utf-8?B?bVJGQXg1MlRrK1M2Rmc3Ynp0Wmw2Y05BRXRKR0hGT25odGptNW5LVC83QnVL?=
 =?utf-8?B?NjcxY05yd2xkbG4rU1hibDY3R0pPR3FzNTZ3S1hIeEVjSFN6cVJBWFc0Qkda?=
 =?utf-8?B?RE0vanpGdXRhSnhrYzBIV29mS1F0RXpRTjczVEdobjcwVE5QdUxrVlBHTzR6?=
 =?utf-8?B?d2F4MGo0Wkk3R2hFVWtzbUJKaXhSSG0vZ1FUaVNJclM4R1g4U0laZlhoM1BM?=
 =?utf-8?B?SkdJcXM0U1VNR25LZk5EbUwvVFhzQmxROXlNSHhGSi9DZjR6VVBhb1JSZDdF?=
 =?utf-8?B?VGtaRVVsVjZ5NUlXNFI1NUlhZTJaVGdYbHg2UWFReTljSUpldDhFMlRhRThC?=
 =?utf-8?B?YkhVRVA1OGRhQnM1MDNnS3VJSUV3ZkE5dThvRk1aajRQeE12Rzg4a2JFbUxw?=
 =?utf-8?B?UVVOTHpYV2xJVTZ3UHltTE4rY0ZjaTFXT2JVUitDUHZwNk1qem5KYUttejMv?=
 =?utf-8?B?cExwN3QySXJqMXArdDdzbFBnc0JLajdwckx5bFJoT2JMSjF4cWRHUT09?=
X-Exchange-RoutingPolicyChecked: e+WoJhEeqk8Zap2HRnQiR+yho32aF3xO8Im+f/zFtZScl6ULakcm1HWB4P+XKk93n9FsP4u1adB9X47NPDK2jynDxDwcaaFdzNMqp5qWtveK/FcU3nZqz7ooMAUOrdd5Ha0iIebkkaXwzuqbTiOCBk0QUN5fXp165bJ0vJQGOHw1iUzp1dwBISJPB1dthUNdCTTULjur1hNZjPGH9WF/akR6IfVX3e3R94eeKMXi36Hrcdqvni/WCjyoc/dseeAGBMkkbQM75tCZ0bo8opgYBALK/f+eZlDZHvcjzeTK2QZCrX1LssMBlOULiEckeIOd68AUMnb8RzFJegdoy4AOkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2769a3-7a05-427c-f646-08deca083efd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 11:29:50.1606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YyAUlK7YM9v7TVNydvKNNGCK5I1O3pyd08ibEYHgyMH2jZdGqy7D35VttVsmUVZ5ReqYAD15axMDNytpaR0bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8937
X-OriginatorOrg: intel.com

On Thu, May 28, 2026 at 03:30:45PM -0700, Edgecombe, Rick P wrote:
> > +
> > +	/* TDH.QUOTE.GET expects the input data to fit in a page */
> > +	if (in_data_len > PAGE_SIZE)
> > +		return NULL;
> 
> Do we really need this check? We can't trust the caller to pass the right size?

There is a similar check for this in_data_len on the KVM side in patch
12, but it is for a different reason. The check in KVM is to make sure
it maps valid guest memory pages into the kernel, while here we make
sure it complies with the SEAMCALL API. That said, the KVM check does
make the check here kinda redundant... I can remove this for simplicity.

> 
> > +
> > +	mutex_lock(&tdx_quote_lock);
> > +
> > +	/*
> > +	 * Use the first page of the quote buffer for input data. The buffer
> > +	 * must be at least one page in size. @in_data may not be page-aligned,
> > +	 * but TDH.QUOTE.GET expects page-aligned addresses.
> > +	 */
> > +	memcpy(quote_data.buf, in_data, (size_t)in_data_len);
> > +
> > +	r = tdx_quote_get(td, quote_data.hpa_list[0], (u64)in_data_len,
> > +			  quote_data.hpa_list_pa, quote_data.buf_len, &out_len);
> > +	if (r || !out_len || out_len > quote_data.buf_len)
> 
> 
> How do these various error conditions happen?

"r" is a SEAMCALL error just like any other SEAMCALL. If r == 0
(SUCCESS), there is no documented scenario for when "!out_len" or
"out_len > quote_data.buf_len" would occur. I would assume these would
be TDX module bugs.

The reason I check the last 2 conditions is mainly to protect the
kernel:

  - "!out_len" will cause kvmemdup() to return ZERO_SIZE_PTR
  - "out_len > quote_data.buf_len" will cause out-of-bounds memory
    access in kvmemdup()

> 
> > +		goto out;
> > +
> > +	/*
> > +	 * The quote buffer is a shared resource, so use it only for the
> > +	 * SEAMCALL and copy the data out as soon as possible.
> > +	 */
> > +	quote_dup = kvmemdup(quote_data.buf, out_len, GFP_KERNEL);
> 
> So at init time we allocate a vmalloc for the quote and pre-populate the
> hpa_list. Then we use it every time and copy the contents to a new vmalloc.
> Would it really be that hard to keep the hpa list allocation around, do a
> vmalloc here and update the pfn list. Then do get quote on that and pass back
> the vmalloc we just allocated? Just feels like global reuse way has extra pieces
> in it. Compared to the whole quoting operation, this vmalloc_to_pfn() loop is
> probably not very expensive.

Hm interesting idea. But a Quote buffer could be close to 4MB in the worst
case. Let's say max_quote_size is 3MB, that's 768 vmalloc_to_pfn() calls
each time... That sounds a bit excessive right?

The extra bits mainly come from using kvmemdup() I think. Having to use
kvfree() on it does feel a bit annoying but that was the tradeoff I
made...

> 
