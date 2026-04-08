Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E30037F74B;
	Wed,  8 Apr 2026 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650640; cv=fail; b=s+qIVC5TvhoStW8/7Ucp/ItqA6GIsXx2IJQIHlJD2tmH7/js+0YjRoyc42ngeuHo70q0h0BkJMA/D9pNYmmkBZLSX5wcnh/TmnVFDCtvsdbKTAA1zfvRm4Ac2huyaZkXAn3gOi+taMY6kfoqO7BWZHkCgx3GD73Ew4Pq8HDe4C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650640; c=relaxed/simple;
	bh=36/se50RTL8Oq4OKLfcnaeMXvXJW8FehqssAwRbXrg4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QoeYLrnyDH6rwTwN0peCvkonseWTq91C2+3dlMPw96hNF7aH6EhwKj4y/zxSU2M36xk/IOTSTJsSVF2crNRtekR/4h+AnIqCpLsSv8Mpv5f9sqMZC4wxbsWi2x9P2Bd3CXXG7GdaFidySKIb/1y7kyX8SiJS/Dh+R4drg/uxObg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1yjQ8iJ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1yjQ8iJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775650638; x=1807186638;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=36/se50RTL8Oq4OKLfcnaeMXvXJW8FehqssAwRbXrg4=;
  b=F1yjQ8iJl0M0bbMRF3lTQ7PjKhr4/K0xHfV5RkC2TFZ4rcD6mBmvs3NI
   v6uCVzfaBjcZ8PCXRLlUsL0qI6Wxc7biqdFbmx/NpY7FbABPrszBSBKkI
   0AA99d0drcw+QA2Xkhk06BfTZWMc327LRFn3uZxjS9ejO/dg/jMQ4YFpC
   kyAIZHOIkdjs/Q3mYm8Jao/4W4Jbjz9O8KjErwUCvl0utlOtMEi2ThbXt
   m2OZ5M+BQxIPYvYVjo4JXPPN/rY9TT7K7lqA7CGhxiaIaORgddot96+cz
   HSGfB1zpjnZWAFJu77oBBHrdBve1VlgOA72XJfBEk72qw9C/0MsCQO5JX
   Q==;
X-CSE-ConnectionGUID: zOVmXzCETCSRWUXGeEvUTA==
X-CSE-MsgGUID: WM34TBWpRD2Br0AB2BL31Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="88015301"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="88015301"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 05:17:14 -0700
X-CSE-ConnectionGUID: T8d6LpZPRIOnOKBGBfYccw==
X-CSE-MsgGUID: NXPOdF6WQ2elNhsXbXSd6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="224156226"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 05:17:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 05:17:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 05:17:13 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 05:17:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hY2uv7BWTKiYJgUYK+ArsHNxMxKrZenfi2OYzXcFJu9gYkWkrJ2aOS6Kl2lxp9R3k2r1fPMu9HIKlDe/gU/NNzP7adkweVsUPpaJrX3Y+zQWmRMoYAQvy/3AEouGBaKpo51Z/i7VmS0BGVE3HmPncdSI62gx3y0+ImR+DFqk28yA7AVc9tjY4gZK5DftHz+eD4JdLt/buuaXVe7nzOtc4xBcyNQfAThohwX7GGD8dqcDluNNWMWnHLMN8R2tC07CIL2MUTEKmKQplX7CXt5rHcPOyMr5D5EmalmsuJGmFHzwW7z6pqmkqRx/z+O8+eJ7TW6mqZmCn2ljLcq8/EBstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBH81u9FVdPexyjo9yKnVmPPXnMQBKARIg6S1auHzbg=;
 b=KbBX0I1bFhour5jk4VMicbT1ifjdtaAQpG96MSNNa9we9cfD3VExbicWdPFFYBxJSh6SwCyjDD+PZPD1cAGnvkuO7IgjXZSvAmUwHkHTYgmw1ggmmGfmOQuF2QkRF5GD31/3xXgxr59IvtcjPa3ofgblzCOuuCqPXjq1urVr8KReDomNBz/3Wc/vA8pZ1t9QUAT4tyyhMvUnXEAMxG0+uQ81e5cd6zcvoZAnXptgSBqbDqfHQNckaLTkxTE9REYa+Hs0tqg3Gc/5k+EI30fuY6mMYxd8bPcoprjaehGmhB6KYRB0KaiTczSJDGOZ1fi69Q5VP6RmLRPzN5dJVhKPPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by LV8PR11MB8534.namprd11.prod.outlook.com (2603:10b6:408:1f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 12:17:09 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 12:17:09 +0000
Date: Wed, 8 Apr 2026 20:16:54 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <kas@kernel.org>,
	<nik.borisov@suse.com>, <paulmck@kernel.org>, <pbonzini@redhat.com>,
	<reinette.chatre@intel.com>, <rick.p.edgecombe@intel.com>,
	<sagis@google.com>, <seanjc@google.com>, <tony.lindgren@linux.intel.com>,
	<vannapurve@google.com>, <vishal.l.verma@intel.com>,
	<yilun.xu@linux.intel.com>, <xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v7 16/22] x86/virt/tdx: Update tdx_sysinfo and check
 features post-update
Message-ID: <adZHNjB7muAmboX2@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-17-chao.gao@intel.com>
 <adT1Tkz+/ysSZ1Ua@intel.com>
 <8b9d7fa7-6534-48e7-a4fa-c21260b1c762@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8b9d7fa7-6534-48e7-a4fa-c21260b1c762@intel.com>
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|LV8PR11MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d67ffa0-4a2c-4577-21e4-08de9568c1c4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Hmzwit8nUGSjv7NdkXqen9jIge7O6H9pfOgyB0Mzzw9oSMR7qdR2B/Tfz1t69JdgA+FTtXQt2QAoUAdNXdWHqlkoOrW7zFvNoOJSb1VOWJqtDlB7+LuZ/cSw8S482wfe8vp/MdxKR91Em243kgWUYrFQjg8lM+VOrnZynJMo5aD3yEE0HrkyAltzxSY6Q5usJKZ3MaBYuB3mVCMXNI5SbxurrpRFqcYlHU8YkI/dz3CKTO6iJ1idsO9CNZnklQyg5OVa1+5X1BUOKGQPFRPLqiWd2pjC6zh4IJXAminOUjk8lxfAONGgCVLHcyrmL0imTVdTz5QPvBDbrkoPVbAFuKioRaWEwGhQ8bOPCEgXt16dj+E5IlWLf2eLEn/I2YE+XVdmLHSyxBJw0raoSy9tsD7IC6P6H3Is577apJPpjCC8T7WQio7Q9QKafVhe9T5m6H106gMnXOad3utpKiDHjjwZ5/IZJZ7hU5nJ75lIf6I/ZdVs7VBimKYzlClXYpZcsZVqASg8wWktZY8d2K8o2BV69SXyFczvVyXi/Jn3fXohyFsEmzhX0S52bWSlEor7NPL9yQIt4m2qTyVmBV6u8yInBaY20h92xQfCBX6IyAJlX67O1Dgfss+A7hx/jUFgUfGiUux9YK8sWmaju6Ro16ycmnS81ljHloUVyBrpkZO9OMrCyPLENY3t4MEzIxF/t53TXMRqU4LAe7ZuH2T6c6ipUxxFUNe+dgyR7bkcw24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wc4h5c3ZRuU4XwfcdhKNykckPaOLV0dPoYp715glfYgx5Mlx4zNXvB9ITOQc?=
 =?us-ascii?Q?vsbMsODaCj2l/eAj1ryk1JQs2iQEp8vJkMtGzk9A5ygvrrKax/e+zon+QGOV?=
 =?us-ascii?Q?FtQvLlQfybCTLwa1DgW/IN3i18sdKOm9iNsadCwJgm76cQ9+6Vf0nLEXfMwf?=
 =?us-ascii?Q?JPjX8bG3ddGh7jNZjXXzSvZnPH7KL645HUg9GAE6nrs9W1ScdsYj7MA254Li?=
 =?us-ascii?Q?zkiE37Wv9BTIW1hgP995+caQZwLKewih7lYYbREVRoOQgomLuAKKqpsU5y2y?=
 =?us-ascii?Q?iPW6dIejIi5pRpLc0j19eVBtit3BK98jo/n25yEkOwQus8JaomQi1g7y9iTS?=
 =?us-ascii?Q?l5LVsT0eWRchrnHOw8PmtOJ7D5Z/s7PNwDaAQCw5v+vuZh6t18kH0x0zxr5c?=
 =?us-ascii?Q?md9C5kK/u4D08WcUFYZFVjVk4wf+mJ4X4C+O+Ytw/Q2PI38P0jzz/+VZEAow?=
 =?us-ascii?Q?BmdanoyhDZAxm+g+IMaYLKf2suyiHQUpCVC2HEQRIxuY5CqO1oZW+a2l+DH/?=
 =?us-ascii?Q?rQNqK0brIdwjIKTXr0684vbtyfSouvDj6MSZ3dpZdYgq2sjjuBQDjYHplp0p?=
 =?us-ascii?Q?EFVtufcPkyNgO+hsiJaieaxLfkZc+cShYwskGqDGVCc7+dlf6usQ6wsnOOsp?=
 =?us-ascii?Q?GoOFKzkOnYN+Hvnv7djuTjFCCa6Timv0pgpFUxUXLLYUojFc+FomzF+TmmT0?=
 =?us-ascii?Q?FuTmg7erJYTZMyGUcZyOqUH7TPBWR4ypcc4fp4Oj59gknlLHNEjXHLFmo73D?=
 =?us-ascii?Q?2jpleRHiq6nE2j3GDtF2C1zcP1Ndr9fpbmEYLUc4tMSh1k3alkalV4h4smBF?=
 =?us-ascii?Q?6iZCm0edHxi4RNihPK3eMsGb+TtZTYraOOtDPpiDJY0HmJEgEqPqpzbzMIsq?=
 =?us-ascii?Q?vl5a11ETq/oAYqTTUWKI9PSXk8phPJ1i6w6Ocv/L1aiAiFy2DXiBsDn7KOb8?=
 =?us-ascii?Q?hW2jYa7hSXpdIXC8PUBnaC049nvCwnGhtM3st6+Gt8sp0UXXQsu2k4vXoIEt?=
 =?us-ascii?Q?72FSkkiioqJxLWQmpYJs09QcRw9ZfaXKVoQF6kd51ScqiKP7obqKPF0+OJH5?=
 =?us-ascii?Q?XYnGGjFkocVxjh8SfodOifj0p0kHFXaTNI/8J6f37jfk6gjSC6LB44EwBkBY?=
 =?us-ascii?Q?1Q9zyHKzpBIsfgaG/2NkrtFVBuHDS5DUcaHdsmUJPmuj2uJJQnXnCKiP3ThA?=
 =?us-ascii?Q?4QYzJ62Lhw/0d9Bsolt+awVJ5/Z9XPH19ZEunZfx4LTVE3ox4SRE7bdwsTLm?=
 =?us-ascii?Q?mkw5NzUcpsc9xGGkyDPAtzzZzJq47Ry/JUuPuvaWsapL6sSVhtqoDHCWA5CY?=
 =?us-ascii?Q?PwjaXVFLyd9BdrI4qSzAEJo/FE8g2T/JcJkcbXWwb9e4dUdto7wkxt+fLBCB?=
 =?us-ascii?Q?gXvyV79bfNjZrArvly+dOKhuSV78cGXQNI7KIpr5y+qXx7rw5ROR2sDMYxoE?=
 =?us-ascii?Q?KvxbEu6akVmq7SXyZW1Pr62PxIbp0v+TN8VKSkrCDywmJohdKFqOGjOsIV5r?=
 =?us-ascii?Q?F2fgDUoLe8U0rXbZ8T78AWVRx8q9I41xUKxVnOhZ2enrcaa+/5pLe7zM1GAL?=
 =?us-ascii?Q?imf9CPGiiKiodk9yUfKo+cSFc5RcU4zt3cNWeKciJLxp1Tkvg6ygT3fq46Rc?=
 =?us-ascii?Q?XeTzBAsMuA3qYrjeP4sNScUOmQBJpxlwRRk81QB09z3R/W5JhZvzsHp9eT5G?=
 =?us-ascii?Q?JWShJ0E6+7ztoN9bCk9pufsvjqpF7LRx1HNZmjXeLvM6DPGjS9tIdPujXeku?=
 =?us-ascii?Q?8ZIafAuobw=3D=3D?=
X-Exchange-RoutingPolicyChecked: R5H2Y1SXhHzi7T9I22CsrVimG7jfWCb1NQlJwnc+qHMkUuqwO/FJgKjxGHa3d3/Xycdpw0ajNCF2tVjB7OFFphGNRcdANlSO0sVacjbOWmJD5TcKLk6FRv0tlHKF58cO1uXSjsK0w8s3el7azwYJmEuFhYdqYSkhwY2qgRwNl5gqlT0jTIDb66OzgJOsoaMGZeCtxre1OKWqHvZZIERcnEmfyCDnc527rZHuAahPaIsNwRm7Xzx52o+JlxYwl4PgslIiR3aIuB4N5t9hiKSNP56OcvVhFSWYf4OhBp+NudXoWCh3U3qvnpPEEPzvqKSdP2r1f8oNeEox7KtPptOXTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d67ffa0-4a2c-4577-21e4-08de9568c1c4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:17:09.6020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lozoZyvekiSZzw1N04MutRCXJ16c26tFN7kmL+MQNqGX38qX1pP7hIeuU9FPlQwscfsAlqltTQCN/CiW5DsV9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8534
X-OriginatorOrg: intel.com

On Tue, Apr 07, 2026 at 08:53:47AM -0700, Dave Hansen wrote:
>On 4/7/26 05:15, Chao Gao wrote:
>> Dave's comment on another patch applies here too: don't preemptively handle
>> errors that never occur. The custom error message is unnecessary, and
>> propagating the error isn't worth it. Will simplify it to:
>> 
>> 	/* Shouldn't fail as the update has succeeded. */
>> 	WARN_ON_ONCE(get_tdx_sys_info(info));
>
>This is nit territory, but I don't like that either.
>
>Actual, important, normal-program-flow logic should stand on its own,
>separate from warnings.
>
>OK:
>	ret = foo()
>	WARN_ON(ret);
>
>Not OK:
>	WARN_ON(foo());

Good point. Will separate the call from the warning. Thanks.
