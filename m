Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FBB1A9FA4;
	Fri, 20 Mar 2026 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773995532; cv=fail; b=Sy5g6efuIN1LEYnH7okK21k9UnxdbcUIfITzqm2DLJvwwieXIfLmpIZt1TngX97fKgT0RnFKlr10wOAqgrNS5496AgIInEfqCjVf/3pnSgInI5iitBD3zh+qG43QTvTvw9n8kCqhlo7oh3qEWA60g39Q3ZDb6xUCYoM26xtWRHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773995532; c=relaxed/simple;
	bh=YQ/POQcj3iJxeWUYP7D/qxibDaabFOXdlKJK5vwMTKs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cHxlItoFXVtR8sIR/i68gIPx32ipp08IPjiZt3WlnZkcqxzF3mi/N5MGFQqHfWwwVnCWEDI3OswMoiGAQ4OoAJ1VoXH3JRojWjZXkgA3j5K7kyl07P4Z8AdRLLWekO2d/dlwM3MvsTC0kASFbd+Ky9yU0DGqc1RxZUXWJQl3AKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NF/VbkbM; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NF/VbkbM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773995531; x=1805531531;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YQ/POQcj3iJxeWUYP7D/qxibDaabFOXdlKJK5vwMTKs=;
  b=NF/VbkbMhChA08xvkgeXZqTpuLKeGVMojayS5xqVhtdhMUYC6Whg5v6/
   +y30Y3i0Kw0Rf6qaG3fL0wbObrALbgh1LmHgPbv9e4g4sWQpeZGklTby6
   e5Np08BqaKfX5XWSOPe6BQTXb+yG6CPxQM35FVtOmSD8LlDykD4OAO4hd
   6VUjRGHntiw8i6ilWQOjVAbHB/MgbIOPaXHpgbIU8MRSkSm/StWdLXawM
   JRSXcGS2BY3MDp0p/ZCpIIsyV6oQjk3IGK8y2Rfa0rtkJx6xt8vceuuwl
   czGyQA7yIGoILEeLfNg5xLMf/cnhNUXp2NVaWb8RzIeyvv6M8QJJJonMv
   g==;
X-CSE-ConnectionGUID: wLNUYpkMRKiShZoJ80abQA==
X-CSE-MsgGUID: UWg+YrUORr2BwjbeaonrUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100533867"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="100533867"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:32:10 -0700
X-CSE-ConnectionGUID: /VDJo+HBTS6LGQ8STJ+x5w==
X-CSE-MsgGUID: 2ijw8xHuRc2JmJbLTVDgLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="218600239"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:32:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 01:32:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 01:32:09 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 01:32:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUKoDjhhzDZqUM9MonUAZ/InurYwuD6z6sbuFDrGuhJrXZ8uT2RJ75PfjtXObTjAMAlMB5YRRt+2kwE5PU40+hoUVNSriMAoqzhr6nDgm3H6Hkl6dl5jNK7DNG40Y0thFNVm86M9TBPCApglQsZN2OCkUZpbNYhHvRNxTqusjQbPjYHWlxOmQBMzIr7BXwUa7xxfQCf6Ua8Ocv5D6Ac/oGxcvXmzFIIKqF74XQ0/4uyud7jrXxp1CmTvMEofjfseOFD3iiYe9ascTik6TCSLhjJiGUx+8OJRoJvxqXj3WDRYYn4m6zksZXXPn/St1LG0RfhAVjYkDjU/P9VEZD8pbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSZcxuGrW1Na2QizN6hEbnKIQx9b8Nvj+OO/EXRc0ZI=;
 b=UFL+udc356g8GlIA9y+xgyI0nS0cI/qnfxdAfPZrLH0pKNXiistR8DErckSsNtFjex2mH2PYJOHUmLhmOF4tqVpMgclXA1FfySDMKkgHtUtY70mLEAGvIDzjLC4wqirzAP8+YjEX6yLFqkQAiE288w0hEZSyAZzKm9LWr3D9tuIJm/XdQml2H79nYTAUPOkw6tXG/Oz09f9jvKEJcY0Fa9QkyVQeaXD3jcTH8f2qePvs8qQFB6Go4pUl6lwMFZ4mz3AiAV6rYfNmvMQQnIb962LtnFdgotDNFnXi1ZUKrBz5rohcwGLMrYz5vWCGsme0n0+uhdiRzfUF6pIzu+0Rwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH0PR11MB5141.namprd11.prod.outlook.com (2603:10b6:510:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 08:32:04 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 08:32:04 +0000
Date: Fri, 20 Mar 2026 16:31:53 +0800
From: Chao Gao <chao.gao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 22/22] x86/virt/seamldr: Log TDX module update failures
Message-ID: <ab0F+RmeOwvV9oG2@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-23-chao.gao@intel.com>
 <abwCz6HsMopm2wFF@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abwCz6HsMopm2wFF@thinkstation>
X-ClientProxiedBy: TPYP295CA0029.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::6)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH0PR11MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 0567a435-b05e-473f-2f0b-08de865b2a41
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4194i5Tf5zRq8lIvxbbGAHcsIdPf4F1dJpEUi5Ewr0J93Nw9ZRwtmew74PBpIapg4VyfwwVz0IaqIE5wRKkOvHWUcJDpkriaXbFOEW0/c2JXYtOWEXaIZHfb9LoyjRu23Heapi+0iTbh5dN7YuVWPqJx40PC8Ss5yDQZzJE4R9Z8WZIC9F/ITAmpKMVOAJSHRbwZfUerCHxx3kPCraRobY7yYuSZ/epj//vdS4v8XGB6HG5Or6oaQCL/tklVG0tP9bJk4IatsckdfHwbtpfZrIdzv0lU+zd1nFGaMYzz6DXT5XRyD1ma93jjEDZyfsUsOZ7N8iea3G99xK3pYjG1aNsMC49wY2kQtKg7suhhOC4312W2dLj+NT/mhC6Mi6nNtLng5Ac9uJ5T2h0Cz4NFJTcEzn4YxvOajCIFOu9VJb7jmm6WfmCIMpIZ4WZYQClBUqHrR2FWUKDwDo4etpZEEwGAnPjQbyX8MaVqlz//TGCUmYsgEgwPmxHL1oT4wlDzJQILBOX5h8Se+u34VqVSRaDr9/61nbUvkuVGrcGfbLK9fArfquhCQJGzdMrsoROiC6g8fmULS8zLop4mAxBKHI1QHN+h3Ucfw0YvEZ0vZbbb/Ru6GvDQ+l2P+irqGoRcfLUf5ROe+YVKChWiKYnkGTVstXaKWj++8W+vJUlSCKR+ozt3tl1d5Czk0rkw/8BNXpgT+b82p1eXfMUDbu8pGyvTOjVGzklhZpXp58Vsnpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fhRIjJ3H+mNqXZ/gflWt90bVYxMYCCgSaBtTuyxbPnPxGeUF+7pTbHOKThm+?=
 =?us-ascii?Q?64ELq5JrbCfQzmNqHG1aOg+MvFeQ0RK7SBwEpGkjFu3LIxxLNL+2YvW5IBYo?=
 =?us-ascii?Q?DMcPszq3PReXUH/SUVgpuP7m973h1VCR2u3vgmbV9Sf4sIhe8kDX6aeNSFff?=
 =?us-ascii?Q?Y2LCFBuG4mdN5wS6LyK6YHvo/HBtbaZ7ZW5lMCBeNVaMNLHQO4m5vy2ddeZL?=
 =?us-ascii?Q?BNGPek8A2aV3Oz+4Ft++gu+SczJirf+0mmsuT+rq7f6nHX6nehSXjyiJyr9P?=
 =?us-ascii?Q?tdhsEU0k7m+13pYQe4yP+BzYEJ6HupdW552P/Fx4mkponiywOxE2GBDC3zT3?=
 =?us-ascii?Q?PnDzq/UY96px4zuJZQIsgAKNa9p+i8Zi0m/4LRaY+6TQEgfVpWzOIbpHbevh?=
 =?us-ascii?Q?2Py1CzRrGuBn+Q9F+nCrJr/YWCBGkRDHzsYmtmd1+c1RlSYa3R5YILx70hc2?=
 =?us-ascii?Q?4QXr1GqBbpsKZ/eew7Hs2eAwn3AdiVrp51WEKA4StsLJNEIvAoahfgOCwRkD?=
 =?us-ascii?Q?P9qCBYijCQpTPqZFVNqM5s+YRy/NRHw+kfeEpEra1utl1G/2dTwGpQ1kui90?=
 =?us-ascii?Q?EyzRnU07YJShYg2O82jjgBVHaxNtIdBzWJ8QwQPwB93L8HO9YQcIwmVSYplA?=
 =?us-ascii?Q?ECAG4Vb705Mr62oo9zeTCThXTW8vwFOhmzs7GUCzug185GLW2nEsRTqFYbsb?=
 =?us-ascii?Q?UJUlGdK6ivNB9losJrQWHVpxle7gHGBbXEURyAQ8F/SMFl4v/YfIg9R1kc9U?=
 =?us-ascii?Q?EIH4H2yghxU/3YbA+DQCEef+qQsKzYEq/TyA7BQoRtAXRRz34VvKyuHnNmfd?=
 =?us-ascii?Q?EXvIfCP96koSQfOWONe3nq899G+AsdI5Np0jaNHQ2jj42riJl676w9QUF1g6?=
 =?us-ascii?Q?8ozSgFRpTEJydKCVkdF/WyB4bn0bQeYnfBxG5yvg2hocu9FMoXSdGG+mWMt/?=
 =?us-ascii?Q?75F+PCTKtoGzsLhzhEHD1wQ3LlhMqEXE/VBKSrY9cDgdBN4SqnWvrwQ9fHRO?=
 =?us-ascii?Q?7p1T3/hoXckazKwpQYLtBvWckXwViypHqJ3UhYCiCoMbPZ5Mc2dlsjL9mUtp?=
 =?us-ascii?Q?VgcpCv6eaHwOhFsdvV9zU+MiiNVrhNHZ8bwr0D/HCGsFU/8yKAM6N1MMxWSd?=
 =?us-ascii?Q?ogUG6CUOBhAsRk5vKnpfjGcaCRsZ4WyNcOHQehLzl+up+b7WOKJl8uhChZr9?=
 =?us-ascii?Q?QgOouBtP+7nb/vFo3exK+Jt6AZFsAFSeDop9t8EZ4NX+DrqWvWdEq/ZMoHc/?=
 =?us-ascii?Q?ec4m36I+haqC01zKl2qEBmGwASVF673Q0F//1GPpANwqWFsUM+Mo/ZDcvnlo?=
 =?us-ascii?Q?+BoJ9ECouPuPpr+vva8e6IlpsKYZks6XLrBgM4qIfIVkbiruS5+L+l99jVt1?=
 =?us-ascii?Q?p9DjDZ4zNKgu7ftkn94gEzh6xVwObTy34QGMXKxtkgeB3QAIQcnB5sXWl62n?=
 =?us-ascii?Q?ts++JDMECEomqUG0e7WkDSLnX5EgPkuKCc5eFVHlivXC+2t9iTSP37Kf0sbF?=
 =?us-ascii?Q?mIaUBEAC8NN+6RMHDEhyJ2w/BcUu8wiEb3J6cKkBiRbhvMGX9n6LsKJ4MFwo?=
 =?us-ascii?Q?h+mVLxaleo8A2sw2CTmUksCS+bapZPlTEP7nheZmpZ8HaiPWsX1t6tBI++jy?=
 =?us-ascii?Q?NGiwDMpVI7/xGyUyra14lsc6bp6InTrtj+nwFczQFQ2dKUbEN1k7uVCYIobe?=
 =?us-ascii?Q?Uc0vbLywTxvngbmpgFe/V53anyjAIs8M34peTGL/zwdKQxH/joBET9NVVHmp?=
 =?us-ascii?Q?RtAmktJHVQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: mURVhQqRTyULJ6oOuuMIN9wrLReCxMYlwhb2VognTqCqfYEQGgu2cfdelOzqQ2gxlKPtl3HNNYZryeuqM/fmdSzhTYPfNDjmBwpGCwLSAxXOjoiMqmNsa8pQhhNzSGvkAWuPzmv6FpzsB3q46gSjncIQY2a/w6X2mq1u5xLLmIRM13DC1UVHXu0uE+dQwqbhPf/+qzKuIi3gD2Y/p4P0dGxluCQk0bDkvXYi7y+YoYo96EcNFcfOvOScn/fEMVtpsPpZR0DIFPEBiIXLuOYrpy4jE5ywi5fPoH17EObKlIuE0RV9p/fMYfDf+cA0HWMXVCdECHjt0sWj6Q+RRvv1DA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0567a435-b05e-473f-2f0b-08de865b2a41
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 08:32:04.3847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYOQjWtIl/qq20KfljWZW3V7Mojb8D+aiKeYS0fsygR25wgQNsQOCRsIlqGrznGgaNveUD2k8y0meTJOyfs4cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5141
X-OriginatorOrg: intel.com

On Thu, Mar 19, 2026 at 02:06:36PM +0000, Kiryl Shutsemau wrote:
>On Sun, Mar 15, 2026 at 06:58:42AM -0700, Chao Gao wrote:
>> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
>> index e6b7af410c54..4e1ad06506cc 100644
>> --- a/arch/x86/virt/vmx/tdx/seamldr.c
>> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
>> @@ -222,6 +222,11 @@ static void ack_state(void)
>>  		set_target_state(update_data.state + 1);
>>  }
>>  
>> +static void print_update_failure_message(void)
>> +{
>> +	pr_err_once("update failed, SEAMCALLs will report failure until TDs killed\n");
>
>Is it useful to indicate which step has failed?

For now, all failures should be from SEAMCALL failures. The kernel already
prints debug info (SEAMCALL leaf number, error code etc.), so it is quite easy
to find out which specific SEAMCALL failed (then the failing step should be
clear). So I think there is no need to print step information in this log.
