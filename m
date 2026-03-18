Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371139FCDE;
	Wed, 18 Mar 2026 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825045; cv=fail; b=BSeo2GOB+Net+eeoNPoQrgN9PO9xZm2sPFwKGVvAys+1+9806lRsUKUtHgCEIIpb3CqfOWacQ7knTmd6jBWCUpSMvXklTctKoTNVY/2YfBvxR49KgM/XTQw8C229nZZUeFjBfMngccn4rYd6qvzCq4b9czr2z8SjaRIVHkTQODg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825045; c=relaxed/simple;
	bh=LJGmp4yPorUfp9I8oFkPVLJgMDmeNVhNXL/Xv+w+Hc4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RnikFZO0ShSTILg/06vOMdYk4IJWORj1srN9Wy0EhdTM1u3gvX2PBX0kZ/YJCslc+DrEvlOh0vKYklnzVNHfrMDeM1DL45Ajsokg3NL35lFHV9Fkm1R3yleuYiXIcwb7TrbOoE9B1q9wsyoieKsPJ99U/vOeYCGqxIzCZhi/Jdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQhO1qdg; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQhO1qdg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773825044; x=1805361044;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=LJGmp4yPorUfp9I8oFkPVLJgMDmeNVhNXL/Xv+w+Hc4=;
  b=HQhO1qdgZziiasXMl4ZWwtCMXjTUkhG9CG5UhXhkWW1YUd2UuDxs2eX6
   x9XT5mf9bno24h+n+5QYVvdEwE5IlvcwWjz4E1kHJ4bRv5UjyEF1zP+sE
   MhP77iI2tDI4AX1Vj0J4rmlsojs28EVWPm39EcMKzQi0eRzlqf7n7mmNS
   pcGSivn08ioy4vi7Y4yh/A/kp2p9LVRJNgs9iyQ+tGTcq+GIZJ8ObKqvB
   Cd6vuKefc8qfbx9uwqwai5xyoJU1634ivSOG8wO2CoBoHm+/AkT2C98zm
   qbv+CnTT2+QOXx7Ej1mqf9bSCtXIvdBy9DGE57aV58zPghsRZtVmgpUE0
   g==;
X-CSE-ConnectionGUID: xvgA2439RG2z3GosGDMsug==
X-CSE-MsgGUID: mNrqUvBITuy0uWjoYIRfUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74761030"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74761030"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 02:10:43 -0700
X-CSE-ConnectionGUID: /s6V4oFLTRGZwfJ8papi2g==
X-CSE-MsgGUID: XBK7II9XSW2b3QTh94kwwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="222541854"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 02:10:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 02:10:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 02:10:42 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 02:10:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrxHriNLgcaJcl7xNzLUIW0iowz9x2dMQe+6ISGp714Z6/0ZTjQKhS02XNfVi7l0/ArKbVLPPA9YfA6Dae4/ZstVSg4ynz+NcN629CHCo/dUZ6TIVpZGcVHASIZpAb6yyqguAZuZoORhGSYLKNw36S+XY6HLM1XvSFdreIf5pNVudtEu79TiQlndbfSUI/ufcV+wb45rc2sOakN/IphnNA0KYi98hOkCmWzg91T/5CA+Z0OW2oYOwrlcVw+XNnpAA9FkdpZmhM3eHcwZgIFWxw/KL+omQOD/+KQZPis51nPsg8NuYrImC+otMStnDmI5fTpFdOgAf9tcsReN6iBEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ablychwdjJ4BU2CeLWzYs/EkGpm5sepeZAnjwmH1mzM=;
 b=CE520v1nIZDwV1/tnYLs6sHg1icIOtAK5rUgb8fYKCPXRbXu0ua6BRdS1F05M+zPqil1Z06bHrb/BPFJV9Y53S4neBXvZsELqToJzrppLLAV7fbiXYOKnbOU5JLhLBcJwlZnie9Bq2db0dWTgr2wBNYmfneJz7BWqu4BvObgI5dJ6qkWfPLlqDqPPhfG8rY8ztQpTV/iQJrJcTL40H/C3iv7rT1Byrk6/5JbZRuGXL6stU3S7xMpZQ5d/pnGqY3XMTK331yOFs8sjCxXYxhhBsOi9QYoGCIqXOY763PtxmsCSeIwzRvq1InO7rct3T7g4KlOMS4B2jqZqIKLoTjftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 MW3PR11MB4697.namprd11.prod.outlook.com (2603:10b6:303:2c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Wed, 18 Mar 2026 09:10:32 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::fde4:21d1:4d61:92eb]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::fde4:21d1:4d61:92eb%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 09:10:32 +0000
Date: Wed, 18 Mar 2026 17:10:21 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: Kiryl Shutsemau <kas@kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v5 06/22] coco/tdx-host: Expose P-SEAMLDR information via
 sysfs
Message-ID: <abpr/Sg3QXfDd1Q+@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-7-chao.gao@intel.com>
 <abkmceqUtMTnLI0V@thinkstation>
 <abpMHxwhYqbmrX8s@intel.com>
 <3614e6fb-bdad-4e59-9769-5dc9869e03bf@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3614e6fb-bdad-4e59-9769-5dc9869e03bf@intel.com>
X-ClientProxiedBy: TPYP295CA0023.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::7)
 To DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|MW3PR11MB4697:EE_
X-MS-Office365-Filtering-Correlation-Id: ea14e045-4e23-4e85-9011-08de84ce34e7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9kWST7J8w7Vnau5pukkkE66EeF1SHUbd85ChuIsS99R4bNxlxUhP6UdI8tHPLLZwhJ964KKlTUA/hH9b2BIRA5ZvQzHituAmePeUb9NTPr28/Pm8SlaKJNrijAux+IZT5c3kXS7rdjTFyNcNS7emhmZwqi1k0lsAH/QzG3sA3BEYN5u2nz6V77lYzvHUv7OU7OQJnfn1hJKCI+qZcca2QT0y1qRLO4jOMALJDmxZOH7qidTVX+Q8BIFmD3UNeqG3fYbLlPh5h2HJFX9JbaX1RI0BBJwIh014aqoT0LziO+lTcZ61zUZIp9fMH5aBO5khVn4VUdAr9PsdJPOHeF0tu0N8ED6zwFvBSfEXQ9Oju++Byy00ITE5iYXIqUxAnNYIMwtMj52pJzOHcxMTbThSM+tQLwh0C3e4rcrKJo0znAxqy+nV+fbC02ZgRs1I5Kaub656BT7RMmuJFJq8CIVkE2nWSH1J7gQKATh+ZKOBsmes/QcwpPZeVTWmIe6OOIqRJco+tdm6WxbubOwXj7dKPfkw18pGTZ+5K0xnb/+JSUUAKLshOJiwZqDT5NJ52I7kxzaJKSg7QFc5Tmb1EYV8NzrvcJ3cHdfvXaFcEnUrQIKb42kWTt62S+lSS2SSy0Gpeaiuy+c3BdaPsxNHDMu2GGUH0cw1wkn1a6V0RfeGICsNzqEaYUdHrsLlT/Faxvm53nij1FjIJ8XXNcgR9ZNTd472JA0lKpJs+lR2bHGpoKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Zo/tIhe8w90t2iQhlt/QfkN4CDEWauNjQaGup+sLLI8E2zpwCVfBjfzu+8?=
 =?iso-8859-1?Q?Tl3/mnLC2tqSM1teYHsJGFem/h/hbzWFIHT7tNUBhqueYiZ/PKgrcl0TBE?=
 =?iso-8859-1?Q?ReTFYfBqElOEWdfXsOVrhKGYlc4Rx4mQat40B593F6g0H9BZlYkFXnhMjR?=
 =?iso-8859-1?Q?R61OVP3SkAg7jYFuiGplIOFyMEIdGeblCsdCLjvnIdNGElgxQRcDXqu2IS?=
 =?iso-8859-1?Q?/spcWY3D4El4MbmZ2k6/WhWN9UMA9m46ctSkV+6KJXcYkuZ5WwgHV2gviz?=
 =?iso-8859-1?Q?a8cS+sUuSlUaSHZn6MpvL6+5GgAmXnEQlD3suGwPXQXz2qIhTfc9yzlhct?=
 =?iso-8859-1?Q?X+U8WsUZPgJx1Thygmch9dcpQrQ+LsC+4x7hzvnvzXp6hJMuJKUZ4trrMj?=
 =?iso-8859-1?Q?iZLch00Nv2h67n59+8dqC5QQMBsM0LKA1JwxSF5kL0XfS3HLu7FCpi53Rb?=
 =?iso-8859-1?Q?h64YTAMGxaYnkMnkd1Gie6L3gGgT25dolsp4rwZL7/R5CS0b/nAfel3X8V?=
 =?iso-8859-1?Q?uQq928M5O4SqVfh/fCwsFeupl2XmjlP/4GbUPSLdoA5sMzdUpZmeSSbZzK?=
 =?iso-8859-1?Q?/x6d38LhxjpDOVOmmpxNSxkr50XxDWAmqQETqJDbkqjmDJZtXijaX7Fgog?=
 =?iso-8859-1?Q?bN0lEbqe24xYAUcznVYOMj9XX3hnrfLT+PUmCvBCdRMZc55DCw04aQd9U8?=
 =?iso-8859-1?Q?wH/pDPrhS4G4J54GwDxXGs0/ZYMNn64I++DUnY9VtaExpFJsz0/0aTvDX5?=
 =?iso-8859-1?Q?3i388PdJ/AhiUdaLdgBSstJ7PzY13KUYtSU/Hs3tvulfWvw4s3NLsMwR4m?=
 =?iso-8859-1?Q?yx6CVp3VuAtv0Ig0svp659t1ht2fr4T5pAagCrO2cOWJm86IoWafxYKJk5?=
 =?iso-8859-1?Q?Uq00eXMg7DvYbTKN4Rpw30vySKAvSeXy8WCk81g3UsSWNWV1EL9kxI38rf?=
 =?iso-8859-1?Q?kBFMrvqmZKzaaAak2HtMXEzFaUUWg52p6trcPMxJjEm9Yq+uVcBLNDwG1N?=
 =?iso-8859-1?Q?ms+pvatUu9YE4LqbFLt2EimkoviP5N0HR3SecRGaMgORE2PFuPfoskYr80?=
 =?iso-8859-1?Q?tVzoDruEeYUGOUqReokxlKIGCX+RR7hEw5VO7aOe/C8UOudF2WE/GAypZO?=
 =?iso-8859-1?Q?lzLY+8nMHuqPlA0ZxMoozKUhRKxVjOkV9sqjAJrldqtwOsFLW8PRzjKFvP?=
 =?iso-8859-1?Q?z/m1hBpNFt9qkckX6+1ZpSGCZQHEzuSrJLEWgzRpQWTIa7H/3tYOosn2Qz?=
 =?iso-8859-1?Q?Riwib2bkiSIZhULSDtfNM+jhH46XCPm6IUoIplJCeav3l+lX0EWRlTwYPR?=
 =?iso-8859-1?Q?9bu6xfxoUz6tF806ZYBa7Ju3AEeLpm095wYCYnDEVMzCO+pwhfVX9H+sEY?=
 =?iso-8859-1?Q?pVZfN+HISeOuhuySHTpvQaFq1L3qSHqJcsYME6vdp2XVW1McvHEHM6kawZ?=
 =?iso-8859-1?Q?kHGjMJyTXHsdSzxqZHgLcUQhWhZYrF7RVo+2Vji0sHdQFiw07oy3i4WrYv?=
 =?iso-8859-1?Q?xZ1eK3ph0ZZWx0SGfwYWp2y7E35zMoUiFiCXL11sZETwR9kjLD7nlaZqxp?=
 =?iso-8859-1?Q?4jsRHFg8pDO9lVYW7o6cNjkfY1kA/TBFxAgGY+wX9iCzRBAsw7hUw9e/kh?=
 =?iso-8859-1?Q?YOWYnrEpS7+Ln6Oi9swmvUq+F5+Z+sqbrxebHRPPpLNp5ifmlXttTNOuFg?=
 =?iso-8859-1?Q?zuX0N0NPpxcvQOshH7BM/ebBFKwDA/52SG0bQ+9kj2iUiG0X3bJdV8MpIm?=
 =?iso-8859-1?Q?XRqzAvHbXcQz+/8kJyQKS7l8ezOZC9zGK6hfkMPPHU2EnQLXsYXAHl8lcT?=
 =?iso-8859-1?Q?QMtWD4pcvg=3D=3D?=
X-Exchange-RoutingPolicyChecked: GPxgpT/SicSqdmkMT9XUIzxQUkM8aomnGVYkQwL78+MgzXIt90htndAkkTTBZMCcUwEl8v8OsjFuKFOeviP+yOohtXfvc4Ic1KFc3Lizgy/kwIbiLRfVdCR2vajtRxucHkya8Xtl8f20BhmqgmEF6AfyWfRo0LIowINLAnjCG88HlAQcrOlHpNSOhJ5uR+tRUODct+SlQkt9o6BcHgWEkygmOiBXknxiCWeD5sSjCJHesxQUUKjvVIpreWju9m7TFJhsQOWxy4DB6n0QFVofISikogPiZJPtT031wr0YRM7b3SA64SJZPaWAqBUROxVmUQwLt7mZTzxiIEgaND6PZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ea14e045-4e23-4e85-9011-08de84ce34e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:10:32.0215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AU/UeGOzxUcJ5vPvVxe67TLFU0TruSoexQ8/cwo1mHm0c5fXGyHda4CyjJIh4vYox+Cglc74a5CcZxHvd9pkEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4697
X-OriginatorOrg: intel.com

On Wed, Mar 18, 2026 at 04:20:54PM +0800, Xiaoyao Li wrote:
>On 3/18/2026 2:54 PM, Chao Gao wrote:
>> > > +
>> > > +What:		/sys/devices/faux/tdx_host/seamldr/version
>> > > +Contact:	linux-coco@lists.linux.dev
>> > > +Description:	(RO) Report the version of the loaded SEAM loader. The SEAM
>> > > +		loader version is formatted as x.y.z, where "x" is the major
>> > > +		version, "y" is the minor version and "z" is the update version.
>> > > +		Versions are used for bug reporting and compatibility checks.
>> > > +
>> > > +What:		/sys/devices/faux/tdx_host/seamldr/num_remaining_updates
>> > > +Contact:	linux-coco@lists.linux.dev
>> > > +Description:	(RO) Report the number of remaining updates. TDX maintains a
>> > > +		log about each TDX module that has been loaded. This log has
>> > > +		a finite size, which limits the number of TDX module updates
>> > > +		that can be performed.
>> > > +
>> > > +		After each successful update, the number reduces by one. Once it
>> > > +		reaches zero, further updates will fail until next reboot. The
>> > > +		number is always zero if the P-SEAMLDR doesn't support updates.
>> > > +
>> > > +		See Intel® Trust Domain Extensions - SEAM Loader (SEAMLDR)
>> > > +		Interface Specification, Revision 343755-003, Chapter 3.3
>> > > +		"SEAMLDR_INFO" and Chapter 4.2 "SEAMLDR.INSTALL" for more
>> > > +		information.
>> > 
>> > Do you think revision and chapter numbers useful here?
>> 
>> I think it's nice-to-have. Without specific references, people would need to
>> read the entire 26-page spec. But I can drop them if they make it too verbose.
>
>I have some concerns about the "revision". The good thing is that it can tell
>what the attribute was built against while the bad thing is that it might not
>be easy for people to find an old revision years later.

I'm okay with dropping the revision number.

The intent is not to require readers to find the exact same revision. If they
can find that exact revision, great. If not, the chapter numbers may differ
in newer revisions.

Kirill, do you mean dropping the numbers but keeping the chapter titles:

		See Intel® Trust Domain Extensions - SEAM Loader (SEAMLDR)
		Interface Specification, Chapter "SEAMLDR_INFO" and Chapter
		"SEAMLDR.INSTALL" for more information.

This keeps a targeted reference so readers do not need to scan the entire spec.
