Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F40331578E;
	Tue, 23 Jun 2026 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782189859; cv=fail; b=TPEZHjUMN7TjwVAJHEohyRdN2HpClqF1qS3dmLDcNpdabJa3czjGkJARkzBMjiJho5f2aXjCXzsITPa10LO0PWkbGBeLIFJpU4DGOUWbnEq6vMMVtyGZNCCrk73XeUKAPOVegYSlBuFfM4vK8kd/i6coy6ydGXJPzUOmdPX49cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782189859; c=relaxed/simple;
	bh=WzajeKrpxYF30V/F92MoKy/uRJy0ANPU4gOdlCLA/4o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XJz+rUMs1s/me2KMdABnVJqJ1U8iqDmXBFn2f9PC4ETDywVNAKur/R4oMbpUOUOZxNn3dyoGhrIjKbiAlJIdbtB2at5eWViMAkosrBRCySW43vGaGLXvxJbvBVFmlbeRtFV3f6JKDs2H9+nwB0vSwKinHT+47avkF2uUM+nx2q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qob99vv+; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qob99vv+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782189856; x=1813725856;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WzajeKrpxYF30V/F92MoKy/uRJy0ANPU4gOdlCLA/4o=;
  b=Qob99vv+aSLsWFzsO/KSIPXS7v/mQwlcRK+gxwjPjSArcTpzrclWpmWQ
   6CTBaGM4j6bhcyauu9ga5+0WXqKcf5py1JDCKIxw5xcQo9hlcZ7i4DZvs
   DicLLEZMnbbDHiAmRka9ETMO9P7gK0Jy/+phtOJOFi3Ic+58tQW8kCM79
   llovPuspwf70t4ZHk1MqbdieAElk/9EFFF1kZlkz6Jmxh/H0CYTATjyuC
   f+XGi5kjimpiqTadI8lmqobrRxalyDIojF0SPkSg1nwiL5Zkfop7w3UTZ
   m2Bwq0aHmWgAg33IvCFHqSPlwcNYivonM/Li93Jx82XoVbYkphXXRkDUT
   Q==;
X-CSE-ConnectionGUID: t6iDNWKmQC2rlur0/su5eQ==
X-CSE-MsgGUID: mpYTDBfjSEKIHgKof1b1+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="83017028"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="83017028"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 21:44:16 -0700
X-CSE-ConnectionGUID: Xf0OOP/4TaapkqsOFz4Q6w==
X-CSE-MsgGUID: 9ciEQmL3TjOWtfmCSssbeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="253298939"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 21:44:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 21:44:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 21:44:15 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 21:44:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhiaUtOg4Q8dJ+5F30FTsS70nmxlUOPxaNokLglZyhLLeIbUSP3CYxyFfJRrn7yH7cI6VE5BWBNKJIepSERdwn8NjKnWdEUKNT9EncrXPIKDqMxGmSl6wV2pKaQr9G9dkAmapmx17zQZHjLd/3evc3QVXGCu2CJPLXWJXbpe+YEbdNh0xjGitvC+vbXtHGloM9k8QCj24F/2s7sH0ID+8DN+Mcaul0O+SF3tWI1YHOI9GqLDXxDzYMzxc45BiJxB9hM7vzQy89ayWMb0JhoCspBl8dYu/oBsrGyP6x/+IcDYLMKJtOmCGl4nJwBNzAHyqHhZZtqKh04CilKCs6M2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wy7rtatlhl/pXGnImbZKbX06gWBaOWdnOD9TxAUAO9Y=;
 b=aEdTVuBWSLxudwQBM4tk5Grg88fL3qQd/rITCL8dUZMhWMKhja9Z+M1hxXbOX1Hhdq74P48A48yOS73u5zQ1MoEt63wcMfqc39jGAfe5jFO5991crqoz0oXzbWs8FFdbOZgPLgdRhimeVicgMF+PmeNXDxQxQxrfJzeHGgafBPA0oTllfGVW0KFv/BXFWwAd6Gcy+qcuNxBQUTEnSvaBEKXeeyf+eQGKmUgqR1fkdzpmd2CZRl8UsapkCqyCi9d83NpYoXIn/mGyScNLNG6zUQ8q/YUg0TVlBHxkKtOYJm4EKW+ysI4OHXE1x79MC8MKFSRXPHQmayB4nFsfBEF65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by CH3PR11MB8413.namprd11.prod.outlook.com (2603:10b6:610:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 04:44:12 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 04:44:12 +0000
Date: Mon, 22 Jun 2026 21:44:11 -0700
From: Peter Fang <peter.fang@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/tdx: Add helper to query maximum TD Quote size
Message-ID: <20260623044411.GB923079@pedri>
References: <20260612110853.3188196-1-peter.fang@intel.com>
 <20260612110853.3188196-2-peter.fang@intel.com>
 <49728a57-a996-470d-92b7-209a010b4761@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <49728a57-a996-470d-92b7-209a010b4761@intel.com>
X-ClientProxiedBy: SJ0PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::17) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|CH3PR11MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: acfcb30d-7563-4577-9c0f-08ded0e21257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: OdBkzkFXfFxDvK1uqGuBAGvFdUsSGYgIk6mkWbH/ig3mfNr0I3+MG7U9SRgYtm/WVZkERUv7Yy6BFeWa+Q4Ofe+9Mbuqyh6KSzm3dpu8ndpozmf2fKOBTvfADaOYe5F0X2/I48pVxPSXHnbLpazvX7R/PYV4Vyp4Dk7UTGVvKgQIMMhHpTa/h1Pk4slg0Dr71+MLrj5N31gPzGSYlm61BUgm2hSTZ1KO7UDeVVN5keNvSwLHH6Ee9fpV/ZRMv31fVklr+BXtjm2LnMp8Z70GYmo/3Fcr+y80eceLvPbKrf7zZGGUbakAuuz7/+gD6QExDnFE/inLXvBmdHr/gBeOQK3Qj40jvNo/0BUUMVGkbVlKXpdyeOx2RAx+pTgUT7woteQOco6Un8EJ0M8FMPTsCnDWj4NQMn6fig8xJZ/pSOWSDE6MyZXsjm++xrxem3ad9tjWYmLmQcSDa6GurMqLFnDxFHAytjfPO1G28n69NHRLGMgPsn/O6Ap8dNdeW9VVBW7xDStanKo55DHInD764LYoYvKNCKHZ4bD/teGENRaQVbk+w1X7R3Y22PVg+U02Yj47UH59PG4z+r+585OJaWPkwgPthE4GJEIsi0Vfys2+suKH393JKcMxYycTacgKvsuJ8aMhvsSDM2GEcxSpverUPhxBVT15kgNw9CfZ4tQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vwQaegXEPnQd/UIPVVeCeeL9/zICwnRgU6XC6c9yM491J4at3ryi4IK4hqNy?=
 =?us-ascii?Q?u0Wj60wa8aG0XWMuaSUk6+meQTQ8+mP0yYYSO5jgc+ct/JptVpAUOEcdTaOm?=
 =?us-ascii?Q?l8+dpuNRcoutva0iNrtSh95qDHBJjuRhTeHMq5SMDcsjwEGk8sDjMz7A8lsv?=
 =?us-ascii?Q?i0EyAbdpR3N4NpO9Ge+0lWINnh2Z5b2A1eHBudIb0ZfTT78eMucSycN3F//9?=
 =?us-ascii?Q?VxOWHCh6E4y+ox7mLIju76Qrx/8M+btEf1vPr/UbU03M+a9YjfuVYjaRXjns?=
 =?us-ascii?Q?IFnn8MN00kyhildKiljpbPZuzRhMnr+AE4Y7tfTzkJCLjGlkU6tjKLBUk7jJ?=
 =?us-ascii?Q?GSzSzjk/8wG0SUmT+8zfoaS+AJmoQ6KZpVutMiQjji8o9YjauFY/G+LLZq3u?=
 =?us-ascii?Q?dnj+C5jFcpKqS788wF+r4zH/alBp8Z65cPf9kONcOcZn1pdRnzyhMKkrIKA2?=
 =?us-ascii?Q?yQCpoqYqkVswHyG/ubpMCcPF88T5rf/zIY7MnkhJzYgOL3xhO0Ak8l6u4jyk?=
 =?us-ascii?Q?iOlw55wFUEAC0kXR0tVQDXV8jsyvJCsEGR/25AGlsIK83/NcCOCujgJV3TnC?=
 =?us-ascii?Q?A7tpBsOPMRI220QOFH/5MyUKV/SC39J9pv4oBQFevPs48OYSj2u3tvqmcsIz?=
 =?us-ascii?Q?idoP87uMvp0XlmXjPE1hGD+7+xc+YEO8WnYOfMqhqsCtB+xTfBX7bLsEM+hn?=
 =?us-ascii?Q?jFhIuU1/0xqBfIzbOGp35Xdsbqeo1PdiNUnBJ0j2tUWqMa7UvPN1N8rDtPAT?=
 =?us-ascii?Q?eO0bWfKYZOpGuc9UxGcMQj2gm6snjnF/IXZ9l94AuyPyEWjQ/IpKery6ENNj?=
 =?us-ascii?Q?xwA77ed5S5f2x/LKPP1cZo6wK+h5AYGv0HVlbuxJms70BaX5rZ4Ack1bBLCx?=
 =?us-ascii?Q?A2AcDFnALvcRizN+yby9goPXUNXEm2Wm5vpr3a6/Y0idGdDSMabt1V+qQNbR?=
 =?us-ascii?Q?ZDJ6s4aOnOzsYV4zl1UbEG5MqDxrZwwZJBRsxuXMHBEoD3AhhYLi7zpX22J4?=
 =?us-ascii?Q?UPYg0Fz+YdlUgTZpxW9P1cuDlcKF8RQ6HZR1P7lS2g3g9+nSWoIk6HpPOQxy?=
 =?us-ascii?Q?HWRLxu5ZyZVYEAPx+e8TBK4wlT5Ure65j/iNDpnfosOG7VLuWbJIS+KsW75n?=
 =?us-ascii?Q?IqeOkOaMbjxCZ23FBC+a4PHn1Pr9kV/nFbVIwUPvbvS9Cp8WiHt6l22xFZy3?=
 =?us-ascii?Q?1jJpwwbqHwnnjpOAdF+78Cn/drUTBGWC84hA4NcQasxm5KOomGAtbQ6ou1Dz?=
 =?us-ascii?Q?uQLFMyjlCtVULLnC8jQH9qSWf//6aK595NSPNPlPr3OJ46IqSdWbxQ+0dTec?=
 =?us-ascii?Q?2fY1thWSbW6z/ACv0h2fzgt7I3HCZq+ENh/JKGafGe6KKZPB8iDHX3EzdgvL?=
 =?us-ascii?Q?zoeWRRuKhbc0SOyFY0o0Ku1iOcl3mt/CcfGAtTTwu8akN1cUtduiHuLAZEXL?=
 =?us-ascii?Q?7hEAPpX40Py6Mmse5FWig9c2jYrT6TAMN4ZhFZYF9tRgqI5K6hcgp7DbHTbw?=
 =?us-ascii?Q?cP4MV8Jp/KZaJuwvolKRdE96raUFeX7W5ZUJxSFuepMoxSgFBWV1dGUa8//w?=
 =?us-ascii?Q?yGpXDx28ZXryvADzkjk7Yvv8uyP44xb9kgYNwn4Yj5V5Ij6BBn6t66nQA+5A?=
 =?us-ascii?Q?WNL4FqOv8SS4zktkJcvdrdCugx6i0k6xDDXLzlCSBAk3J5yGI0UzV2ePCkK8?=
 =?us-ascii?Q?o3XbkDotQ/K608WNBBBc0Kh08qczhiUG6Ukjb62TTfiRoQLFAzy9EBLjQFKy?=
 =?us-ascii?Q?n5UxPmd+5w=3D=3D?=
X-Exchange-RoutingPolicyChecked: jEHQ5S1LprjGVklXVp5qKVoWOnP4oZzo63UO6270MLYRnVNt3Ror3vhnAV9+L9KTfoY798xeBlvUw9Ylzge7BfuR9a3vR/kRMZBKLjykun5/fTbzGj6WLmhUcphxApP+vCiCUIqF1PrDkraVLXLUOn82+Dz6bZhV3lWdQUPDNOPmZreZnWOq8R7NzgcP3JsX/bmgXhj2ZKNLa2X3lyyY9PkbIbyBkRN8MFsvTFp5jkr+vOKTlK2mgbUc58omqD7QGqMM0rFIouOq9VAPW/n9C3khQUV4/bKR73+W22cF46or7Yt8f7iynmKIkdedhUG5kGqI3J0XjdLmtI0NHZlQfQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: acfcb30d-7563-4577-9c0f-08ded0e21257
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 04:44:12.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSnOC6KOGKsgYSTZAGtl5FqE+lyJXfO9GRpxZCIb/YY+3JETxnQIDghvvyK8d8rdfGv5s1vSBdXfPjwnk3MK1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8413
X-OriginatorOrg: intel.com

On Fri, Jun 12, 2026 at 10:25:03PM +0800, Xiaoyao Li wrote:
> > 
> > Assisted-by: Claude:claude-opus-4-7
> > Assisted-by: GitHub Copilot:gpt-5.4
> > Signed-off-by: Peter Fang <peter.fang@intel.com>
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks for the review Xiaoyao!

> 
> I have another nit other than Kiryl's
> 
> > +u32 tdx_get_max_quote_size(void)
> > +{
> > +	u64 val, ret;
> > +
> > +	ret = tdg_vm_rd(TDCS_QUOTE_MAX_SIZE, &val);
> > +
> > +	return ret ? 0 : (u32)val;
> > +}
> > +EXPORT_SYMBOL_GPL(tdx_get_max_quote_size);
> 
> Do we need to start to use
> 
> EXPORT_SYMBOL_FOR_MODULES(tdx_get_max_quote_size, "tdx-guest") ?
> 

This makes sense. But can we use a follow-up patch to improve this file
later? Right now there are only EXPORT_SYMBOL_GPL() usages, so using
EXPORT_SYMBOL_FOR_MODULES() here might look inconsistent.
