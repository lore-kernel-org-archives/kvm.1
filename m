Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592E0369D68;
	Tue, 19 May 2026 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187345; cv=fail; b=dq8ZKwLLWfnD3TIRJj42Ly2kJy2HDia1r28PBxx8gbk46sQXLD+O3WSvEa2nGANoLZ/rt6mrODCMGE1d7k4AXicQjViJNxyR7jj6E0PPA5U2POr4a93ABzrLOWq32NTGv3iGX3FB3RZhxHQdaSRoBVpMVGiixL2LLnFJ44WNC70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187345; c=relaxed/simple;
	bh=yNpBx13mM6u9LawcUWbkj5SJEfXJlu3HDkdjNfFxlaU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RRgUgyvdw8E62BtPd2t0FtuMC+eMxb40mKgg5hGMFJ4CjwJmOwU1k9DSHOE0HyjoGbDDNTb6G3Qs480CG8thLmyUUBa0F5nd35T9mVkrmklo66F+6RTAtJwti+g2bbVsSb5QTHwmMzTau6QU5Se/aQ9Qur2kYG7abWS4mqqgBsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XAfgDiVA; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XAfgDiVA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779187344; x=1810723344;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yNpBx13mM6u9LawcUWbkj5SJEfXJlu3HDkdjNfFxlaU=;
  b=XAfgDiVADEQIV9G2ZD5U1vZztpeZduZXv6iBcdcJ4frSQErb8DG552NM
   bIY6YVa50xnKLavOw521YEHsnyeUrsVI6CbV90j4hlFpgp7hidP1KzjE6
   efWG68rBspNP1cub3h/+4KWxBRlnDYiXULhb4rwEHwVI3W7GJNr/epYmk
   kCwWXO/hup4XmA8aajssCeGOk2OqGCGSJmM8go+bw0uGG6QrzwOrvT5mK
   m5ava00+W8fQD410bdS8Hek35ZBw6B5d049oJZSHnHPLHCHUjAHo7luBa
   N8U3AEqBRNtFNaiecad0oX2B0REM6xvx+4Ea2CTtlPzFNXNTe7Twb05bZ
   Q==;
X-CSE-ConnectionGUID: YSH5zyMSSTq3aBuxZjm77g==
X-CSE-MsgGUID: xYxOYpXWTmiBxUOUHK1/Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="90757187"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="90757187"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 03:42:23 -0700
X-CSE-ConnectionGUID: r1fpt6vpR1ahWaob+GeKTw==
X-CSE-MsgGUID: opKaUxhAQwmiZHYabzEepg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239980050"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 03:42:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 03:42:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 03:42:22 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 03:42:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3lnx3x/zZIU5bbJCgAsdJj6KSxh4xBYqTOM/toxPAaKqUt6lxkbqo214pG2Oo6v6tHZYXKQ7qFSRRGw5rzQrPOADIMQPcYTV1Et+nid9tv9Js8YN35wKlSBOrpw87tfbarAQNowXQdGi+BMYzAB6FQ3rgL2neUpr3rhJmZA8VBZ+rCa7QVZvaHloZdAfZF3nEfxB54dBA7uSbwmaESqVsBqIaIbKhLcRMmOwr5a29hgJF9WUVTNCRJhLEVVPE0EltwnQn20BzwPvndQEn55mkx7HTLZsOYBgW5u3MLA5h2mNv19DlgQWfuCaqvJGmtswEsrO2lV4K3sp3mEF/gxKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkWp3d7Kry91WAOip20RuPJxixUXE+5HCfv3ZLTZKjE=;
 b=g36SYQ+ZNvvXRIBgW3DuUE9LxZ67/yoIEnNyiXCxi084t+oNn+q2YoqTowQ22SYXwv5d+EaYcvN9UzO4lMJ5m6W0dU1NopJay3cXOnlaP85GyedDSf6U/A7BDDxhrbR0FJoV2fSY01nmfIfzo5M63Q65D+FuDTSi8RtoKgkRMZr1S/hBZo/3UpJ99YzC8/Ehx1gCHvrfpnR+LwJzEqSRZLiZTxi6pQg00Q0suDWntAioppmxKXFxotaVWLspXX+2YGg6CsTuouKYpv0hruefNOEpt2O+MmKSQ+jAgcDy7BZT9iQmO7Er30oNQ2X6rlN2oTSiXpjh1Wa4kRWcbDgwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by PH3PPF179F31853.namprd11.prod.outlook.com (2603:10b6:518:1::d0b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 10:42:17 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 10:42:17 +0000
Date: Tue, 19 May 2026 18:42:05 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "Shahar, Sagi" <sagis@google.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v9 19/23] x86/virt/tdx: Refresh TDX module version after
 update
Message-ID: <agw+fU2KlL9Rpxw3@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-20-chao.gao@intel.com>
 <dbfb8fa01ee6035576c6cb2f665372323117a63f.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dbfb8fa01ee6035576c6cb2f665372323117a63f.camel@intel.com>
X-ClientProxiedBy: TPYP295CA0023.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::7)
 To BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|PH3PPF179F31853:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d30dab8-cba1-49b3-b61c-08deb5934bcf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|56012099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Qc4C7btkSkFfy8UstcBPfCg7pxB5dB3+TueswByJsyEUX2dFL2cLKPVfPFZaQplMXOke9o0bP3QVgBAByfDRYpgIC+rPYgKtN2wy7ZRE6m+RGcoDRJ/Flo7Sp683F96Wk11Dw7JS0aw1PybtJ1/nW5K39KwIangP8wH1UVCrMCevl1OtCbzzr0NcoS/C8TcRy25Y4zwzWAaoIXLVQO9Jn2yfn3YLgxa3ZThRtZF2CSqqip0GtKXA/AwyGiPiWUfI+cgGErcHmn8lGnMeNbpCGdgO4VYsMidsotFSJMsKdSfFYhJ8UVQFdLG0Mnm8epaTFKKj/gT7HJiUz2eUfNchskSn5NdjQATPTzAGupn44C0d/IzKLwnBVsDQuQ5MKqgY6pP0Jo012weTutJTGTFTEE77D1BXD63pheDPx93qie0aT2rQeRoj2z0jiLo6AFWKFDXQ3dHRsLvE+Sg/4xd5b4Ei9T2Awly7+Tf+wOzj8Nmbr5HgvtlAQN/LTYB9fQVCGwb4NYPsPa/TW1RPTl+JTndpMMdzVR03M7HH3ZXtaNJDn2HpEERXbnYxn4DjriDiJ8LoHEt6k96P5cfbzk6erFtVNeK3mKy6YuWx3AOAYnS0HUpB6Um5xeUBJ5kqneBbH4PkII79UXMR84STvhevzJrbxevUyk0QscNd6bFgF7sLEdt2ap33xq3X4m7vzulG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J3wVoXeFcXbb5QKK+n5Vdj1udlyMMmmbqaPHo8UmJlX2RVrz2fxSi0HnI1IE?=
 =?us-ascii?Q?cx880BChUP+JM3UJKnPJVy/D0uPS5BK0q98SxoCtsK+nCJ3Z7h/SrIpF7DyD?=
 =?us-ascii?Q?8EYoqjFwDjCeRGYDJAoFszgu2PIu0nHfocsOyH4oK2wM1AJneRLvEvK6CF2C?=
 =?us-ascii?Q?1Rj6In+96tkoq/VLqy8swx0OSOwMfPbv9Njq07w5GAQh+o/If1GaymIQTO3d?=
 =?us-ascii?Q?+H7M4Zrz1mJI6IyKBOTV6wgnHiUiPy1z6mjYQxm729Y/WRaOrWQ3qCZGWWlK?=
 =?us-ascii?Q?TXpcBl5J5xgw2lFpsF0ifUY4Iqvqg9gMppcTh/IzM03aZBCdzzh0xx+BfHC8?=
 =?us-ascii?Q?enNUxh2YrsVgG2eJiNKHCIJrSjHop8LN3MUYPMn4fK0gc4rBHzwpRswI+j0l?=
 =?us-ascii?Q?R3R7ah3c+HCVnPeM8eowEej2B8C0ZOUl2DqT/uo9ZFjQ7YOEYx0yKrtA0B9J?=
 =?us-ascii?Q?Z8+B6Bw4QZ1vMYYP+0ug1o0amx/QLYvTPk3wH9UJbrpNWtT3dwlO+DYwCS4Y?=
 =?us-ascii?Q?/HGAVu0w4udUzmT/0RhdPW+J5MZKXoNlZidDFbezlHp8tEaJewmzjMUo3cN/?=
 =?us-ascii?Q?c8gXmJB//YN79whj1XfKLkHECkP3OY52GVDf0ED7K2bt0GMI4WXfZY/XA6tg?=
 =?us-ascii?Q?rtYRwHQPDWdIm+IfIF0uXICPtfAeBj3k83/2QxWf7EChCFF6+sW5r4PncJVQ?=
 =?us-ascii?Q?wPPz9O9vCD/qjmbGOIP8Mj2L+hz5CzzJXwcELWxFaaQktCh6l4nrXXRCSMfh?=
 =?us-ascii?Q?3ClTf8TCG2u/g8r2ura/Qr1kDU/LKhXn7WDTPiKC7cWlkyfROR/XYxO/vXT1?=
 =?us-ascii?Q?NWHJPWGbftQYoqK5M9KebDL5twI3ix/hLJkI/6v41GlvDc09LAFOEAQXnDqF?=
 =?us-ascii?Q?faBdgOKwad8dxrudxO0vh8MJWfBYyTbDpBHxeiHpeEtYtffIlEVdtNavvtsA?=
 =?us-ascii?Q?NswZIZm9GQOmS+dp4zbGSEa6D+5zUSZlEVXFnUzrTrBucU5wxHevs5yrUI3h?=
 =?us-ascii?Q?t4m51m4skmWepkdCXuV2KbgYEp3y6sGh8H6kJnzcQ7sxqDBn8bolarYxIJrJ?=
 =?us-ascii?Q?G6OR88lrASgmOuoU1JemHtE3YMAFSS4oky+pqoJFpQcoaOhpC6g/NaqA9Xab?=
 =?us-ascii?Q?KNvAVx+7LXfmFR7q2U08bfNXF5j2DJIHgfwuFu3wp/CB0lgJlfRit7LNYaYm?=
 =?us-ascii?Q?rXbN5wZl47mBXQL36M+Ky/eK8U5qtPNgd0CqQhmC5zOiOIzdgn7KofnoZ/1H?=
 =?us-ascii?Q?CK+s01ft6ylZ/Q9uvNWHxvNk+GchRoWdC/E6BIYGuY4uedXvatg3WCdtJLuh?=
 =?us-ascii?Q?QAGeAwhv67mlWwnwCdEWTr4TIXB1kckERlOunGU18KhTTxE3tMkKo/hrKRoO?=
 =?us-ascii?Q?7R4PFOU9AeeGzqL2rABxwj7oiVD5e6bZQnyAI1IZ7MQddn+1SM5YnLvaREHn?=
 =?us-ascii?Q?dMUsdVkhpFpS652sBW0rGUKlzi31W3wvdVTdfDr7rORbwMwoqj1UmSR1SDbf?=
 =?us-ascii?Q?PTH03Xh4h4+Au+fN78N5bLRbqNolse5VKQIWO829jHxssC+3d0nZmB6rP+0v?=
 =?us-ascii?Q?Zxp4HKyMoGWr8DPUmDAl62JrDlU5v5Spze7Umz8UjfAP2lcXTbQ/Estzhayi?=
 =?us-ascii?Q?rFDf1rG0AqZXEDWDzzb7+/EREhNrrE7The2dndnNEBkaf1s3bYyMlHCCxfSl?=
 =?us-ascii?Q?gpg0ViOHBQLlNw5ptg6ofIfqFm2KkhMMguKiqFSCkRJdy0WnwNrWF8KgpItA?=
 =?us-ascii?Q?yhXDWvKDug=3D=3D?=
X-Exchange-RoutingPolicyChecked: ucoRms/PwQovLRzNirQhL3B8AhIIB+i28qGaCRSyZqzYk9GCBm2TmRmsCDHttJmvnfkJjhkf+M62yoMebDlXUxLxgIlJ6M4ikHTnNQ7YED21MkW9ZQkV63MExTq0G3eb+yxDMXtT8i2ROioG2FO+DylG7/cYILa4Hnb7gf8joKLTNkPCllLtmkZMuuXgZNphuXjXqxoXDlOBE5Az+OjA1Z9XOnERF6nhSmby8zBECFVwas0rIEcUU5i5EAi8OaLc6RzuPlzOhwRjqmTG0XoBG0K0b3qwlQtr/HEEEdUG4lxjgcJkHtfltxrVE26RtE5qC+m4fTP8SIf1dwNV5XNPnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d30dab8-cba1-49b3-b61c-08deb5934bcf
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:42:17.1877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWrRp7Ein/QmTNdo7H45wskJnOafiIer+2MKv+WMy7Tgn4tY/0kD28xlkA3/2oONdMt+rCsN2iz0jSlxlVDFQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF179F31853
X-OriginatorOrg: intel.com

On Tue, May 19, 2026 at 11:16:35AM +0800, Edgecombe, Rick P wrote:
>On Wed, 2026-05-13 at 08:10 -0700, Chao Gao wrote:
>> The kernel exposes the TDX module version through sysfs so userspace can
>> check update compatibility. That information needs to remain accurate
>> across runtime updates.
>> 
>> A runtime update may change the module's update_version, so refresh the
>> cached version right after a successful update.

I will use version instead of update_version there. There is no need to
distinguish it from the major/minor version fields.

>> 
>> Drop __ro_after_init from tdx_sysinfo because it is now updated at runtime.
>> 
>> Do not refresh the rest of tdx_sysinfo, even if some values change across
>> updates. TDX module updates are backward compatible, so existing
>> tdx_sysinfo consumers, e.g. KVM, can continue to operate without seeing the
>> new values.
>> 
>> Refreshing the full structure would be risky. A tdx_sysinfo consumer may
>> initialize its TDX support based on the features originally reported in
>> tdx_sysinfo. If a runtime update adds new features and the full structure
>> is refreshed, that consumer could observe and use the newly reported
>> features without having performed the setup required to use them safely.
>> 
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>> ---
>
>Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>
>The only thing I saw missing from Dave's last comments was:
>---
>> Note that major and minor versions are not refreshed because runtime updates
>> are supported only between releases with identical major and minor versions.
>
>I'd rather have this in code than a changelog comment.
>
>If they can't change then warn if they do.
>---
>
>But I think we discussed offline to not do this, is it right?

We didn't reach a firm conclusion on that.

But I think there is good reason not to do that, as I explained in my v8
reply:

 : Maybe I can just drop the note as I don't want to add code to preemptively
 : catch theoretical module bugs.
 : 
 : I added it because Sashiko pointed out that assigning the whole version struct
 : outside stop_machine() could allow sysfs readers to observe a partially updated
 : version. As we don't need to print new module version, I will move that
 : assignment into stop_machine(), which addresses that issue. After that, there
 : is no need to mention that major/minor versions are identical across updates.
