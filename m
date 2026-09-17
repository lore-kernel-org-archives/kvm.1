Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B394A0EE8;
	Thu, 17 Sep 2026 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789637038; cv=fail; b=rp79l+gmTnyK1j6PL02jcbZm474hSrucPQaEjyEgNYYG+fy0p1+IbTvIW0fFEI7IF67cefE700n7jaO9omKlTN0BlKxUjz9CZLCFmJ9tdaXVP48lAe6cj9ALvmzF3Y2JRZjZ8F6ZcDnRwBtELiiGaNYbj/x4YAmeCEZH9389slA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789637038; c=relaxed/simple;
	bh=IL4AphWj5HzZonjc6UKBextTNeJjmDHGyD8fiEgLRuM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AmuthmRxWA/jvVIitx4gaPTLGG2YE6jtEwrlrsNfxMNxGef8PaqTLuxC8GT8BKx5plN7kSJgiq69KQ1A9+C/13wjB1D8YLS9PzWxdKqJb6n7MHiNfOm0vcYY22INkm05W3ExwFgi7dpXZGu0f4Id55+2DukXtR0bzS1rpdzowYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvkLcLzU; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvkLcLzU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789637036; x=1821173036;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IL4AphWj5HzZonjc6UKBextTNeJjmDHGyD8fiEgLRuM=;
  b=KvkLcLzUlgctJ86/qpPfAZQvqc0PNL0bPROGTz94oSK2hLVou1BoiWw2
   gyJD8rZQqQobWS7J3e4+QsoFHOEDtg3xhaOE05+p+6SdrjBb7g2/N7Emg
   ZmUcmGFLENZmxBzQKF2w3SLK7uuLQna1oConNyIMBgwcobhLN1e4aULbB
   aFX66HUeZyTF498rYSNwrp58jx0kGH5KgpXRN6X+VITcqM8Wz+Jk1bjNl
   0+9WA+IB14tbYmfAuMB6AplNahQyNoaKCD64qk0+h9IFy/2O44xpeLuG7
   /pQl+M6EQkDQCOOWKAhVKxkNQ5R4LBYLEUXe78QLnjrl9pkPbPTj3rix0
   Q==;
X-CSE-ConnectionGUID: 0kBY10/oR06Gzr+QIjddcg==
X-CSE-MsgGUID: +AP7JxFRTxqoMqo94+JY2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77604617"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77604617"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:23:55 -0700
X-CSE-ConnectionGUID: M6WrSC0SRKyvSEi2dNx09g==
X-CSE-MsgGUID: qlaAgBRARya4Jk27BIRmJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271050971"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:23:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 02:23:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 02:23:54 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 02:23:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHw6JyX8DcrRn3dJdSeTfzuvGdHV6fnoNo6tX/Rxv/nQYCB7R2j2BpnTLrwToiNmwfIBvNscnWdP8KNwbf5aszHFTfYGCS0AEX4NXaCB7fbtqFc6MSxdfKKl8O+cTW3Sd0LYewJ9b5zVmsPHro/Oye+MuZWRgyNecsANtUzjrAbBb1sS8+Aw07vXrW7qzvDtGglAY2Bhr8WbcFqNVv6FtR5UgHq6gGZWdn9DpN7Xpyz05HltbEnVt9TfgEM7aloSIHc7krAdzwBbjjAO4xa9Jsf7RInRGh7dvEUlJAymeFDEaJazpB0ds+SWdFQquL2iarrchjzsnNWTJW0kT7Lmjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLikv0KWAC+6nJcCl5NylzEusEpbJpPqAfNDyorNVtc=;
 b=Is7G8Kw2r2uVMDgrrNn9OmUUG5CVOcBC/yQvqBvPyxdNTT0AviqyilL1X3qi45CK/p/mNpP+gsTOLZZ2aWclPiXQk25viv3CJ2whnvgTr3Hf9CmxLvQjsuPtID8nZA/hKV7lT0vGU0YKpjsK6wYfrtP08kYyzP0vWd6UQB1Fq226pR5lj2JKVgaYPx75eh3pC+3j5AF26aoce7u1Q2GjE4IGAomzR4s1jJpE40D5TMS271KnwBXEJfrYQHeYpHLCChTKHDP3RJ2DEkd3wAVZX0GkEJbfSZrk20xZE38y1UcoYGmB8kp6i2atXzYE1uP/LACOHKmbO3jmL48HXxCeaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by CY5PR11MB6186.namprd11.prod.outlook.com
 (2603:10b6:930:26::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:23:48 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 09:23:47 +0000
Date: Thu, 17 Sep 2026 02:23:45 -0700
From: Peter Fang <peter.fang@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Tony Lindgren <tony.lindgren@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>, Artem Bityutskiy
	<artem.bityutskiy@intel.com>
Subject: Re: [PATCH v4 4/4] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <aquxoUeWqA07NiyA@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
 <20260915092632.2822169-5-peter.fang@intel.com>
 <aqqL8uUxfIYhN8b8@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aqqL8uUxfIYhN8b8@thinkstation>
X-ClientProxiedBy: BYAPR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:a03:114::18) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|CY5PR11MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9bde95-5323-4c5c-12d5-08df149d60df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|366016|376014|10067099003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: VKRDkUVfia8FYbRVJipa2bJ8IgfRSYNXfkrA1q9mFF+qbAL8lnfvvNRIVf3KvxXKtp4bVH+VRC9oOmj+HCt4/4ZEgU4pjICSSJmhveWIehkMbev503u1e5vX7nqFiTKt3pURJQ/iek/ArhXoAna2OkgnIdXOu5pTMqaWwPxRqW/8XSJ/66bftNNXLTLdWs5yJQJCCYBmz/HkwtrC9D7QDmyFvIdV1C9ZYDVg13iuMEnNuQmE7B6cT/hG+tL4Qrq8neVZ3lxjnGCGvHBMolDsTaThTIDXrEyZ4RqTHyrilFT+yv5eEclaEW16bqtC6gDBt8erAsVTPXyGpVkbhEOJzHWx6bR95iP3YFO8IEyFkfJ1Ba4YjxzOVZSDGhr9lTxvjbkKvFOYEfct1TH3hcvsVVHPn/lwLiPCPzvThOATq5blz9b32Y5EVM3iLwq5iiQTQ7jZPMHiBvj2t7Wxs07owyKrMaVv6M83Oc1vbJ4EEa8QxGFfH27Elj1uB4gYc8DlWtqeu8RUlVYCPOl8KcNOtkQGoo9+Nf4SEcQ2kvLYlVdcI9RXj7v7VqkNUV4bGcyUFtbpUUDLbkWiW8ozaV29myD9ssa26psUMuux6w1Yc/YJ0OFU1fYkNTkReR9DSl+3UfVLPbOwlFXflfkPvBM96DZ2C2GkjDLcjHeXGN53nCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(366016)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BLOT2FLytYCVcIegrMdILjmxg720xHF/nW47DMCVjNDcDRpBrtcWVk2v+Msi?=
 =?us-ascii?Q?3bWKHx35NxIjgXuQjQh0anA2ha37gd5l0vqVEuzDZ/FB5Hc9X66HDK4lsqzx?=
 =?us-ascii?Q?7LTLNjd6a4hkNixiDdscMct3erGjCootZF0qShqCMhuIvinmLMdmDbFnzURM?=
 =?us-ascii?Q?J6YJupDNVCiCK2JhDT0hHu2OA/vCPyWPe14VIY10g/5hf/ZFLV4zhnSO4Amb?=
 =?us-ascii?Q?lLIW/vhQaAL1G8DXyWhEOZco3KP/0x4Kkzo5aoH283IcGBjX6leY6prD55rJ?=
 =?us-ascii?Q?Ty2R3hxG5RoVOYzqeg323FYX179cTggJX7UObmwjpBUADSubTnxpxBgS8KDg?=
 =?us-ascii?Q?9GOitAO4bUtek6p8uE9DgVQboy2JwUTTVMaxt5TrfWYxCFtOuR83seLgZW77?=
 =?us-ascii?Q?DqBK2nHxpMUpjqZfo2+FG3ZxC3/EWmZTEoGOlU4aZgd6rfI+QR3wnML8RKzD?=
 =?us-ascii?Q?NGuVShqWAqdP3rwq6deAVpRZIKWz+bdbrWrtYfcYQZOEPej5Md0jSiRfx3YH?=
 =?us-ascii?Q?klY3rCgfXpRNq5m9qhLrlP4re0LTOHNsxT9iOQBI/BqX899XIIUBRzsfRMvY?=
 =?us-ascii?Q?nVVxCc4sxwedj/X4fHMhvD4VqBK8oQRj9FxBkw0Hs8wfzCo6PLWpNvUCh7EH?=
 =?us-ascii?Q?/a/s5YA93A6LNtctVP1vHLxa1zdwJwF7nWqQeOz2Gy9Lj7XthHMAMYapxP7f?=
 =?us-ascii?Q?YMFFEqNsXx4fDMZBwflmKOhIClHXFRK9LFASfENXFF5WWmxJLezkFx5cknm9?=
 =?us-ascii?Q?SrxFaK66MVb0LsA8hCUS9XNg0kCEKXfWnLfKcBPjoIf8otAgYMfQqj88WMIu?=
 =?us-ascii?Q?+oT4QXXYF3YfhRoYq1WHG1vTX87oNDd2+/ycY1fClbyt/vCvCdAu7Wp3YKuu?=
 =?us-ascii?Q?vhIVXBgPtdLNlBGgIUCN+UYmyjREyFQcmN3wNcHiOb5WFDM3g9d7y/xIBv1A?=
 =?us-ascii?Q?Oln4by6LObw2Kn+tWQodZtICgLk5EIcoC9Zp8RALkrLU8RR98w41OX7xrhBb?=
 =?us-ascii?Q?3dfwx0XtUtWXzCdBAR8l6GtmjzoJbDjT58lk30A1HWiukg3Mv5o5wg7Q41tX?=
 =?us-ascii?Q?VRcJ/NVaaqsXmhhn1lWKNcYA7Yl+5vH33WIx38FlmuQku9oUMg+Mft6DBd88?=
 =?us-ascii?Q?Ua8NzX1mayNV5aANfeZykI5SrXsw38+fUls54DWzdCweg6IOk69lPOp+YzZG?=
 =?us-ascii?Q?Mbafj1tVBFmdM0rtqNzmWyTsSaxkLQd8aIZ7/WL+DffwltkfvKiqtaP/2Q8s?=
 =?us-ascii?Q?sKZHy6HZKNixkonLaVSb+/nmrNG4Oob8MU4wrMjVMQY/Ohd5K/IxPie640LG?=
 =?us-ascii?Q?Bht8rUblyeeBtsPxYswG3iohzXLF8ISyPO2a4k2ZWp/1ZSZurwmlSOC4PucB?=
 =?us-ascii?Q?+xeFmxjMFLZZTJuAnQg8/FYoNEOZ0zB543sOkvVERre/k9WppFQt7lmGDxDu?=
 =?us-ascii?Q?M434eRw4svi5Yk+RaCNOj/kHYdBRLZ7/ZplbXo7lXaVAQuC8xxgVBTAXywBk?=
 =?us-ascii?Q?61Py2EEHfdcd3Cvdiw/FPtj92w/GS2TkxFDcQOR0fdxsd+89SwwIngxJ3mJE?=
 =?us-ascii?Q?uQeWrSE4d8bsby1jPuqGdDfQe2hPK0YrPOEi7iBn/kkJEzdhTZWc7XgPGCSM?=
 =?us-ascii?Q?mLeCi+OsKUPQMofpldH70fHIvrtJr3Lif3zw5PDNBup9rXtM6NdK5sCMFTPC?=
 =?us-ascii?Q?GjOCMgpslTKmjYswrWWxzz0FhuzC4wz/rvlJ8wg7hdLCgmQp8XehfKzzzgUn?=
 =?us-ascii?Q?a1iZyze/Fw=3D=3D?=
X-Exchange-RoutingPolicyChecked: ETPjRa4QtmtAgCVdfpBxdRytdgwkH3d61wjoKulVToNtcBSQFJWcCbLq0riekTJkr43bXaIJ7zrkbLu6ZHYc+PN4Kpphc0Xs8VpH6pIbUIA2au27vu9FN06d6l01E4qJt1nx590WWywFFW9kRMk3/69LlzlB+R7Xd1zeMFgR5uobHDAJwWz3YF4rPvf0JiGa8FFby5u6WGsK+Wg9yVj/o3UnV3S8Cc76TsewiFkIV3ocSNUKS0sW4F0pRxHi7hYWNMilSDEM3Ay7sVrLVUAAw6h9htvlXulJsH5wfkfWrbocnyjX2fw6IjCXW8RX+h9Y/GqVCHti+X1ekCy6tASTKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9bde95-5323-4c5c-12d5-08df149d60df
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:23:47.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfBVYESPeRh/k8vkAczue0ozW/cfjou1nueyQxvS2kRFRaEyhGj59GfbJ4gcvjuKrkQPa32+hNhbXxcWv7TbWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6186
X-OriginatorOrg: intel.com

On Wed, Sep 16, 2026 at 01:31:07PM +0100, Kiryl Shutsemau wrote:
> On Tue, Sep 15, 2026 at 02:26:03AM -0700, Peter Fang wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > A new TDX module ABI reports the Quote size limit in a metadata field.
> > Prior to this, the guest driver uses a fixed 128KB buffer. Intel derived
> > this number from current Quote types, but that is not sustainable as
> > Quotes evolve. 128KB may be too small for Quotes using schemes such as
> > post-quantum cryptography (PQC), where larger certificate chains can
> > increase the Quote size significantly. With this ABI, the guest no
> > longer has to rely on some empirical number.
> > 
> > Allocate the Quote buffer based on the reported limit. This avoids
> > wasting memory on platforms that do not need larger Quotes. Older
> > platforms fall back to the default 128KB buffer.
> > 
> > As a result, the maximum size of the "outblob" file in configfs-tsm now
> > depends on the TDX module.
> > 
> > Because the Quote buffer must be physically contiguous, its size is
> > bound by the buddy allocator's maximum page order (4MB), which should be
> > sufficient for current attestation needs.
> > 
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Signed-off-by: Peter Fang <peter.fang@intel.com>
> > Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> 
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Thanks a lot for coming back to this Kiryl!

> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
