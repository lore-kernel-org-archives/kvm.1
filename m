Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2224382F19;
	Tue, 31 Mar 2026 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951364; cv=fail; b=YApVVkZHzezx/UueF0Kps8Ru0okJGrfgOsvJwg6/oGyxETs/mUipqKQaW/D6vY0uvZX17ruXOS0GePhq6kiKyKHk4//jpPAXGxXagpuO3MmRyPTdmjih+HbAJtn/65vdFnKYssOLCrWMmNKvp6YUWpryFNLukbdIUD+iyiHWbB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951364; c=relaxed/simple;
	bh=UCHXYzgZtOtDDybKMI+Oxb3PvMtGSqb9YbX8ODeQ3KE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aX3kbvaPY4zbcIV6tO188svf1n/RK3N5MxIqgzdv/JfZm4o5CfB3mCoXbWTg0ETDMGFVa1+Qra/mj3hybprAnP2I5CdO+OyBk0FPvSVrC4vDKzUU7q5Uf5+0NV/xgTwitcW4kO+r4khmTg0u4Ca5Un+xFGiQTsMoupPFYbzpCrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giX3Buj+; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giX3Buj+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774951363; x=1806487363;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UCHXYzgZtOtDDybKMI+Oxb3PvMtGSqb9YbX8ODeQ3KE=;
  b=giX3Buj+g0jKoVv0Jpu6YZf1GoemX67GGXCHDUho4MgZKS0ccSsZGcy4
   Si1QjOMGdlfRraJKKBmQ44+ApbpqB8i/S8YS23+RDLKtXibInTmr+crnb
   QYkyN59AuDr+kkUvG03jKA/HZuSqOTliTx+6DzfQos2tVKbs+luX9wkQg
   VEbHEfufOZ2zuEO9tnPpSecJ01ir9jkahqsmTp8lPZjjRl6Gp9T5idXiF
   Y0+KOrSZw/2kWUHwONeB4rkrGiUhiXg6wPxhVKb20D56mEkMj/LK+rCQa
   d9upxERgRuFS+uTVZzMSx+P80PXY4Qpf38pLflYecsVTxzapLczejCj9L
   g==;
X-CSE-ConnectionGUID: /0fOCgAFQ2yzbwWUsgtmYw==
X-CSE-MsgGUID: nVC0VekqTUyYebZdp58KsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="74992664"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="74992664"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:02:24 -0700
X-CSE-ConnectionGUID: tLVO6DcMTQCHVWzRIFLZaQ==
X-CSE-MsgGUID: SDtTj5hbSrCQ4RWqEWhbhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="264259666"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:02:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 03:02:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 03:02:23 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 03:02:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3l1VXvB7tjtgrahFTeI7H+7kP88xvQO0RhDyD+7FAGIF2RgUyVrUj9J5JX23azMzGOVZojOyF6E6WD9NkjdFcu1KjEaUks3Q/pSSgf+M/AAbQfgnAHJ/ID0CycKSlNpVToAZNHaf7ppYwVCPf2BuMWAYJEyoRdBjcKLS/g0y4X7v1qfRhTyNf9ngWoKddECj3iNvGriQeQXldEWsKP/kS3stCt5Pg/YuAyK5MCST+ElxWsvC/Uz+yfJXX7sYKSQL74/h15NmQSDSZOwTKQ5L43CxAZUa1Tpgr8GVhjAXsex8aDSFkhigOZq9E3bSXqx0T4BuWvvuh363rmHhTue2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGu9m2xgeZMgPLXMScxum1DdlKl8L4ztDKuHuvbUjzQ=;
 b=nnCwIrWDO2oqA9LbIu042OEMfId/VGYRxhF5ZZqLiSsbINPguAtAQxvZqAgI6PO73hNWGdWg63C/WFookDAnmR6xnUVv9NYALVommVFVGUkXTp7xLyhVQT62s/Rr0jGxd2OJBa14i09eVm4pUhO2eYH2uLT9iKheOYHIIBqs70/A+aU4cpLUJPKvLChdXYSVGSGzzvfwQ+wMuLe8B0v9Lf/Esb4XPAIQ5t6PQpLlKd2EjDgUtwbZ/ZsKWAyy579KHcoKPpQN3Qbv3Bo5arfJMxpqRc1VulTnEQVqoYuoSZMXRMqCl9yBkzGO+TMxRj9pcTHko4e9fgED58sypY5gmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by DS3PR11MB9648.namprd11.prod.outlook.com (2603:10b6:8:38d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.19; Tue, 31 Mar
 2026 10:02:20 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 10:02:20 +0000
Date: Tue, 31 Mar 2026 17:22:48 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>, "kas@kernel.org"
	<kas@kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: [PATCH 02/17] KVM: x86/mmu: Update iter->old_spte if cmpxchg64
 on mirror SPTE "fails"
Message-ID: <acuSaMAI1FAPIgII@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-3-rick.p.edgecombe@intel.com>
 <49cdf35c32e064ef5d6ca24bd4bb9d8b26bc2202.camel@intel.com>
 <acuRGgIEeXZ6ng0h@yzhao56-desk.sh.intel.com>
 <9d1078b85571e7400905217622b5aaf2ebd6eb84.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d1078b85571e7400905217622b5aaf2ebd6eb84.camel@intel.com>
X-ClientProxiedBy: TPYP295CA0014.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::20) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|DS3PR11MB9648:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f3391f-3d18-49a5-c961-08de8f0c9929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UkuFaMQSDFjiVYR81mrBAT1JY8e8kzRB7tVSTaPH1A2sfTcSdWdO0g5765wjLEOgG6hv6SMRAzxi6dYPc4riWb077kr+RlaK7u/00t0afqWGjJvH6MqBreMpQOgGDdm83cJm2w2NhhBNZkuykLDV0gFkLOPWKERTK1oHkY67D9gdCznO84mh+tj3lgKUIvf46PD8kmQmqw0cMDMaVx+k7j//JEZVhgERCJaP4ITm4iFYLNaWVaXMZPOWCXuuuLEWcBAXSiqZJpXb/BGKZRBI/i3WCCLzoOIzm4TiSo8UOqP+5pkEAD1IIXt77vMYbejbOD8GlzTE7uRMdJyTc6n19YQJBYLWUgc+MrjLiicr4BNSYTm6QPsNUj/fBYHxxSdSXHyrcYWZC8zzqj/MHXPUJOWOL7vN632B29rqzDlLeNGthDOnwFU9qkVEN/GhpZkUXkTE1Gi5xwDy3WCQKb1CNBnv3udYcmPIC+tCmhYpocvOYjloQjQqWVIFLEcRxE5HuXQJqFaM9/biTekVwond3GU6gNlkJvo6IZcKQqi9j4mvKphOA+9H3YxBROguytaeVOL2/wYSbA6zNeg/WSekwynR+Lra7ZXChBB4FX65a0U5rl09XWZuQ97HHSRdue3QanaPHG8gwQOvWNscSRElU08qVtCYF3ATausvxREVFnb2W0Zhxj3/46bK+1N2TXfN+fKrYVSQZL68IhWC+u9BmHslNzXUeAXtl2ZHM+GeU/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?cLfdYVWidxEYQlSIKzqJr3a8c4b1TBb9EWSxJHiDqNKkx7UctoxqqJUDC3?=
 =?iso-8859-1?Q?co1FRN7pwymIpsINJIFWAbm76lpxl32Hmxq01cDS8B5yMqt5IfnUTeXSdK?=
 =?iso-8859-1?Q?6x+EV/dVEBfG4utTJ5SRwTE43oV+gQAOmq3NFeF1WlJ9K2/44GKJAwXYIl?=
 =?iso-8859-1?Q?nIka0i7MaCnnNFLspqa9Qm3kj+N73KTrkOQzqPG2rNhHR3i/jMa3bqfvFY?=
 =?iso-8859-1?Q?s875/9F8Mhw3tfm8xeqfQqrHNOW4CQAGnbj536FVbIFOPZ5oVqX9diDJyN?=
 =?iso-8859-1?Q?g5K/vS3Cly81e7ku7SRQcpNFSIVh8tMMaiC4iM4KwvkLPi2yT5jnbJJHT4?=
 =?iso-8859-1?Q?s6y6D7IJvcEUUoRJqT4TCSmbt4sHaOK/LGBMOQt0EHDyounbXBzxJpzznd?=
 =?iso-8859-1?Q?iZH7mElY+NVqFqperAYqcWXVa95Q/OXGKz0DumiHG2ru8OwTnd/LeX4aiB?=
 =?iso-8859-1?Q?00kpUQlkip0kx2jIZFXM/w4K8Er9Ey5ksr9v/zHtaM87UYxEFlCOk4Q3yD?=
 =?iso-8859-1?Q?thcbHzQH19f9EdsGvdF5n8ze+dvGtWTJV8FiWcSpdDBAfetUdL8yoB/p7F?=
 =?iso-8859-1?Q?pqB/YT9FpEyKaj7c6lyr+CIVLFukCppLME9H9/JoPfpfup+NipVQdKQGpt?=
 =?iso-8859-1?Q?KT9jlk+suZrfl3rT5GHSSV6XK8wzw/f7Y9tBPkEcTq4CXSEvfTkNsalWZG?=
 =?iso-8859-1?Q?hD60oO+v6H28VpR72NVqkzelJ4bMZsIomL0adJWQNU2vghMmR4AjRHRHxM?=
 =?iso-8859-1?Q?yQNFL8/9xGOiiFeS+CvRlldADrQu2a/Br0d/uy7iU1GmuBU6uWqbNrcJ0E?=
 =?iso-8859-1?Q?f7rSC8pp1x/HYKXvFxbNAi8T15LbVABRP/06A9yus79wBHCfbkkL3dvjB6?=
 =?iso-8859-1?Q?sK2PtYKCwl1mSXkxqNhAuTS1+NhMN/a0hULxgzkpw7+/vS2NFKwYKLqTL/?=
 =?iso-8859-1?Q?9VIggp+1qBqybl7V1tQ6ip/Jri4BystDHOyDVWEtBT+rHFGC4/muUqqA+X?=
 =?iso-8859-1?Q?JJdpdRlJ+fkmcOZ+H1kmdh5S4vOTsnQeUZ9piQKxRHZqOTGZ1Sj1oFslNf?=
 =?iso-8859-1?Q?Q7HOZJJCq9Im44q3IWzkEET0yNMCZagKj2rxMwPAmeqkBIrHFGrT6Bt1NV?=
 =?iso-8859-1?Q?bbjkc1ftXBCwV+B6e77inyvUVQDEpDJow7TqfLDvfuAGxLrRCWA5fOJOAD?=
 =?iso-8859-1?Q?dQNW6KIWvWP/d+jo8bZSRhU9GZ9cWeUCpuldCzoyQCo69GE1JpEGwmREf4?=
 =?iso-8859-1?Q?8TyRNzG/TWx25UiuMsRmoqXwif0avJ0Npa48DUfVG9Hd59qBMQC+xsWnlB?=
 =?iso-8859-1?Q?89hkI64mtiK0Xqcv4UgEwFz55zn23Pyca/tcZ7+nj7FwSMlIy5442bmTw6?=
 =?iso-8859-1?Q?XXm5YLHF9cfWByUmnUhRDBlrMcuIDsCt95vnoM+YN4kCbmb1m4PSh5FYOa?=
 =?iso-8859-1?Q?q++S+Lsx2K1oZ3YcKMGtikBNBZ8Z5433qqKsVWxzBtz9Bvsz2/m1I/8Ftj?=
 =?iso-8859-1?Q?N7gLDxptr2yPZKuHTI6vZkWMGQk8/30FHepw1JFyp9zeg8sSbYKE4vFy5n?=
 =?iso-8859-1?Q?rdvqoDE+BpU0hJeOdwEFEd9AFeP+XDef89Mb3OyT388jvM01RHqAeVjYNf?=
 =?iso-8859-1?Q?EfCOcslPd29ZYNGcyLrPb+YqZzB+8MfHzM1cyYn3HiAfX29DquKHXd2YY2?=
 =?iso-8859-1?Q?I6ILam6kbUGM3gxjiHtnrK7RvV3k2uqXKLbgscm99h+Wy2H8/yoJlLQJr8?=
 =?iso-8859-1?Q?69HXQt3so6T8JDNVTk0poVyUZ+CbGFTvXCx4Cw62adtbIOQiw57wRrbfy3?=
 =?iso-8859-1?Q?LXCPSeT7rw=3D=3D?=
X-Exchange-RoutingPolicyChecked: a6rz1V4SvY4ykJLW9ObbBCU9A6lu8XIx7qXBXjKBDufjfaobwOmIl7ECMBjwW7jKrPIH7pP4cZlGKsf/Nne04bcGj6Kwjfikao8CZQ73rhCR6zcEykNwBU6KSXJWzaO/RvB0vGv+Gj9J7Ry7xnI48AnjwXXoVhdz222d6SncjhUD16djWi8kD3KtkUpgkr9fa+3YjNodkqRZy7qV8rbjj3aswiRQ02b/YOk2oeR/diHBD7PUKwLLcuNnh9qMBlWscXJbLDZiVl3Edg9Jx/nl5IkN6TtQzKkBfL4FViLUTQ5GvTTqfd1w/Gbca6BxniReNoCtTTyZDxxyHgd8BMqlTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f3391f-3d18-49a5-c961-08de8f0c9929
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:02:20.6045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: malVZ0aXRmEyUwxpkb224iLJ2iCl4TuMMw1ucIhXMKzMze0h/23XOwu5ZFWkz+7gieSErTt/b+CUHwEWGeaVJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9648
X-OriginatorOrg: intel.com

On Tue, Mar 31, 2026 at 05:59:54PM +0800, Huang, Kai wrote:
> > > 
> > > The __tdp_mmu_set_spte_atomic() has a WARN() at the beginning to check the
> > > iter->old_spte isn't a frozen SPTE:
> > > 
> > >         WARN_ON_ONCE(iter->yielded || is_frozen_spte(iter->old_spte));
> > > 
> > > Thinking more, I _think_ this patch could potentially trigger this WARNING
> > > due to now set_external_spte_present() will set iter->old_spte to
> > > FROZEN_SPTE when try_cmpxchg64() fails.
> > > 
> > > Consider there are 3 vCPUs trying to accept the same GFN, and they all reach
> > > __tdp_mmu_set_spte_atomic() simultaneously.  Assuming vCPU1 does the 
> > > 
> > > 	if (!try_cmpxchg64(rcu_dereference(sptep), old_spte, FROZEN_SPTE))
> > >  		return -EBUSY;
> > > 
> > > .. successfully in set_external_spte_present(), then vCPU2 will fail on the
> > > try_cmpxchg64(), but this will cause iter->old_spte to be updated to
> > > FROZEN_SPTE.
> > > 
> > > Then when vCPU3 enters __tdp_mmu_set_spte_atomic(), AFAICT the WARNING will
> > > be triggered due to is_frozen_spte(iter->old_spte) will now return true.
> > 
> > The failed caller needs to check "if (is_frozen_spte(iter.old_spte))" before
> > retrying, as in kvm_tdp_mmu_map()?
> 
> It's possible the vCPU3 is already about to go into
> __tdp_mmu_set_spte_atomic() when iter.old_spte becomes FROZEN_SPTE.
Hmm, different vCPU's &iter shouldn't locate at the same memory, where iter is a
local variable.
