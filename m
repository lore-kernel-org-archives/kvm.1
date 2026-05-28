Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E2332B13B;
	Thu, 28 May 2026 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997854; cv=fail; b=Gn4eisu9vASNhRtVozpL+G81Vt8nmdevqYI34r6f729aK1Icg1NGfPYuAWEgg5cun57wV/wknBepz+KtWCRIjkpCptQ6PBnS8zzYDF5fuV9zFcVXxMsEKcKlGNExaVXCtBGXqO5XYfqgDn1hJ4ZtHslbB+SXHEQlS38Q+5P06pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997854; c=relaxed/simple;
	bh=V8ScGGVMwiBP4bdtTQ84Ki2ycE2mC6QBhPjLpuGS8uA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bn5vtBZChG9OpYdJNlQBOc14JPsMdX8sZPdzjp2wbZIr+W2G+MpQHr+KgkVCoS3FJV9PAJFZTQcx+DuwnK8I9kgnG/jr8mtVJN4Qu03gdIKH0c/9BdnJDqaXx1JEuiLb9pMx0XeNjbc6pvCbveVssgdIvym07GspnVEBljLiRRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhWHktqe; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhWHktqe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779997853; x=1811533853;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V8ScGGVMwiBP4bdtTQ84Ki2ycE2mC6QBhPjLpuGS8uA=;
  b=RhWHktqeGiK+nhls9+728CrQAsMpM87ofwsqhVY5LbttnU2+52xQ0FSY
   I8pxUkV3hFzpSwsGolXPI50nm/0FpsM6ImRLrYUdsbKodbkaxAmMYWa9U
   OkMtFaKnhHVpNa0qfe6MSfLtmGp/6i0itH7QvUL2pFT0rLl8ajOUJo3/x
   ++cb6QoD8pYbNt0JtWFQbaeIK/GlS3ORkvuiahgQxw81WgiBjGRY3JFDd
   twpzvfEkajkGe0gDpYk9ByLTwlU5rBFvo++xc9OfVBT838xKoOh4HPfJZ
   yjrZVCBNF0BxJVY0w0j0HlDuMqZyH4LVVuQt4l6FGxg0aYp8+FHjGGQYH
   g==;
X-CSE-ConnectionGUID: lwc4RWP4TdKoSZnRv1QO5w==
X-CSE-MsgGUID: eomAeEnaRKCkS26VO0L7qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="84475597"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="84475597"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 12:50:43 -0700
X-CSE-ConnectionGUID: ao0BeRfMR5mXriN6NUUaJQ==
X-CSE-MsgGUID: qNzmg83+TFeljiTNmpS7rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="272971160"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 12:50:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 12:50:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 12:50:40 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 12:50:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYBoyd9uPB/fImmqQU0eVhQmvJjyjMxyqWK4XIKkBwpllInQP8ouAMJSETBRn7FegTSE7tfYbnOnTHiHWhwr9Qhrc9d4GILiBc31OCTZ8XmIZcAqDyKsGQVvDtT8hm3UnR7TaEW8hBsnRjW7BYbBwHbtUDiEX+oQX1l3ZNOr4tMC2joxLRQPYfNT7x6+kZ2FbFWkBtxlJFyhL3FDHEAlnKgLcA2OoO/nwtXbQzYJ3yHKQvlizzH6JNHZTjBdlivfzNJeWOgBj2Tpdz9X4mEcOkdsOqOmL7DANjdtczbEaGK3o2d+uayk5JgvZCNZrbCl6I+zitIn5qkx6M2P4Jzz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bSLB3/RoF7W45TV/g7B+geEB6zu+n/mrETW+y4mhyQ=;
 b=ENIS7QpvG4n9kWWwUFtSz/N+pmTjsEKQKbSRYzaOjol13nQls61pHs19uxC0y6vUppTW3HxH9BzIgyPcR+PJjJvVGtjDGxh3PVyATb8WX2KlR7B4ZMhOumHfwXwLmB09Gnay0brfH74gaB6+WUiLwWgbPGGx3MLtDP/CWCBLuWOk6tBL69R5roRIzd/F282JUrpdmelh+26qdXwXjDwefVpnL5rpQLeOdQp8wd7mMLpDGXxgSfGw15MsD/duk9TdrUHp/gfFirdVxIwhWTRl85HWVrIikT6ZxaGwfxTund3Ixy7+HWuI0xmJNRSw8QffPaJf0Rs0TrFQWFpkE9nZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SA2PR11MB5113.namprd11.prod.outlook.com (2603:10b6:806:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 19:50:37 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 19:50:37 +0000
Message-ID: <7fdc27cc-22a8-4442-9c9b-4bace9ee0d23@intel.com>
Date: Thu, 28 May 2026 12:50:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Enable TDX Module Extensions and DICE-based TDX
 Quoting
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <kas@kernel.org>, <djbw@kernel.org>, <rick.p.edgecombe@intel.com>,
	<x86@kernel.org>, <peter.fang@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <yilun.xu@intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<xiaoyao.li@intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <2542e761-57ed-4170-8ce9-1de3fc685dea@intel.com>
 <ahbJnCFlGFwxrEkw@yilunxu-OptiPlex-7050>
 <e9b8083b-6747-4adf-9e48-ffae70dc6508@intel.com>
 <ahfJ9MW+kJp+kE6A@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <ahfJ9MW+kJp+kE6A@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0140.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::25) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SA2PR11MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a838969-dbe1-4f78-ac6c-08debcf2638c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 3xu66D5TrecCYnwKmdjmI9fs1KfK3b9hHmLBXRBoac8j33zMWbfaczDfhm93nRuT2wSEJWbwbxiHVIAIvbNPKwg+fOqNUwbM4CIjfLfSHnkuacoEYr5R9JqvW3bpOnoW1L71+YqgIBClm37hTI5VYXBhUiDNRDrejUhaZNWpc9Pgc4m5qzmRRXbbN4JjNVZ6A+tYZD3HfW/AbgWc7diJcTTiYcVXPvGnEYmkPlmpGWXC1ZnRKG1k55hHDq39apdJD6cP5bhIQU9HreT8njxTyYfQFr9OXTf6Bh0EZ0B23YHE7Lm899ndRrgmXtJ/kEN3pIscB7MewehJEryyZ3JqeBgYbPrS3Hw3vMvoMiAuD4HFMgv2+ApJ+oAnUhJLXaJekWX+u/xNSlfDM5uf9ZyPsnqHsg42aKbdhAhfW/Y/BphceO1XMISfTMj3/x335VqdASHKBL3mj2/lbWrgCRUGDB+4zENU8sjCIcz/ENidm7ELMpTTfcAlBbuV1IvkgLexLMI/SwzYZB6/jHrE7algSIQ24tQjMevOlg0ZpvIvjy+zk6VYM/wsgfmX/pSju8E6AsQvYWQtW+enANj5+8d38pBpU2v65HyTxNuAdDXIu6z0+oekll1BmAmOzTQPThZkpBdtxq+gAMqNm1KnxrHnvuAPe6vBK7Lc5tgaISVxyzbXwj4NbOtBMKBojtM/JZKn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHF3cWEwWVlWQmZjU3JLSG12dVQ2Rkp3UmVFNTZIT3JKL3FqZEhTSDV5NGZq?=
 =?utf-8?B?TFRGU1ZBd2FxbjlQSVZsaHRlQXZpZ3phcTllbGx0Uy85ZmlFamNtK2hMWmlm?=
 =?utf-8?B?eCtnUGFXdlIrRUxsVHdLUXVyK1ptUWY3cDZTcmRldzVCaTRQUVJGQkFPVFlk?=
 =?utf-8?B?SkIzUDNUU3lFcHpIVGxMbmgzemF6WjhtemlieU5uQ1FjZ1lXcEhpajZ6WjZN?=
 =?utf-8?B?VHh4RS9WTkpLbWU5R0pOa2hMRytGMEIzY3RMcjMzZmlTdWgyWWRpUWFTd3hw?=
 =?utf-8?B?aEVXWEZJSnlPU3JLaWdHS3VLc1dzOE5QWVMxODBsU28rRlMzdlRCcjlaK2ND?=
 =?utf-8?B?ZHJqNmorczJTRG1HeFM0YUh2c3plSVluUXk3R1dHOEJ1Q2NHcDFPWmw1bGt4?=
 =?utf-8?B?cTNISmRhM2xXZmNmcVRtbDM0MVF2a3h1OWI1Y0hDUk50OThYS004a2VRS0ly?=
 =?utf-8?B?bWxJN0VLcjY0UXhpNE9sTEd1WHdibi9TSDRjbXdQNzBsd2VSZXpFdFF1MGhm?=
 =?utf-8?B?YitrR3pFT3JRS3Y5OExUMWpRejlhNlM0UWk5cTRsOCtENjc3dFRJWC9tbGdS?=
 =?utf-8?B?ekRsVVpMcDFCN2NJS0NzU2FySHJHZnM1N05Zb1lmd0NWck5kT05EQzdNWTMy?=
 =?utf-8?B?TTRvQUY3K0ptWG04Y1VzanFoQnJtZ3JyaFloZCtqMFZIRlpRbVBaOTVvNktl?=
 =?utf-8?B?aVVScTFwc1ZUVDQxVUtJTHI1cnE1eW1OMitEcklXQUFFb0ZCZEpac3E5NUsr?=
 =?utf-8?B?cXRtaHNVN2JjK3NXU1lEdmFmNmllOGYzcitrSFVyeUxZa2JMQ0UyajhtcEpm?=
 =?utf-8?B?dEliR1JGam00Q3NmVjdzREFzSGVpM29CcjV3YkdFTkF3UzNPSVM0SGdUb2pu?=
 =?utf-8?B?cER6dFZrRTVISnJ6akc4djFwQnNoMmVBdW1jRlJ6TnVSRm9jRzJmMTROcmd6?=
 =?utf-8?B?OVRlbXEvZmozSjQ3N09qY3N6bk8zNkg1NnRpSE1GZXNta0NnWUNHSzRhWG9u?=
 =?utf-8?B?MUpOUUFGeStWeWlrQmcrblVVYmo2U0ltS0FDdzMxNkR0U0M3cUM3SGNoUWNY?=
 =?utf-8?B?cFlRVXEwQTE4d3NmcXZwbko2VFVlNjhkYnRTZm1WcmcxbGFzbmR0VDNiSW5r?=
 =?utf-8?B?L3M3RGlINDB2c0xxZGN6UmlvNTdQa0VDOHRQMjJoOXpZSTZGMFNQOXNZc2JU?=
 =?utf-8?B?aXMzL3JPOXBLTTlGZEJ4VDB0UzJNSW1jVmFLdXY5ckdNUjZSSjZxWWl0QWRO?=
 =?utf-8?B?bU85UUtBSUU5bVZaTHdaZGpzVjg4a0NXK2pDTjBLT01xYm12R3Z1SDljRHMv?=
 =?utf-8?B?T3BERmZ0Y1dNTEM1aEUzK24vZHZ6KzlMbW9IY01kZEpWdEZuRU52ejBxYU54?=
 =?utf-8?B?OHZTWHo2dGlpZGZQV1Q0NmhUQzBJSWFKSEY5bHphUXArYUFTcGdMQmo3ajlP?=
 =?utf-8?B?aURXcTVESDdabGFNRG00aE02bFlNYUcwT3l4VGNSVm1oQmRvWHNseUpJdm9a?=
 =?utf-8?B?VytnTkhBT3dGbmFvWkJvNHBUVVRhMWZlWTNjTEZMYmcrRWZBdjJ0a2pBeEIy?=
 =?utf-8?B?bmQ1a21vckpSV3UyK0R0OVl3dW1WMjkvSjloM3V4dzEzTUZFR1JncVZEZ2ZU?=
 =?utf-8?B?bWhJRklwUXl0M2hNNnNVNGQ5N0g4WjY4VVVjclZyRjFLKzcxQ01EMjFLVlhY?=
 =?utf-8?B?MEU3ZUJidTV6ckdoSWhtRlAyREhwckplMUNDREVjNysxVVZNbHdxbW1TTUpB?=
 =?utf-8?B?NzBNNlR2OHdjeGx5U1UvaVdCWDVSc2lJUnorTjVSUzV6cStEWnNQVlhiVHUy?=
 =?utf-8?B?c0J4Y2R3dzIvSHhuWHdGbGJGNExhRHBpUk1wMGY3eHFXSGtlbXY3Z0VMM3hj?=
 =?utf-8?B?bGhUMmN3WWtpcm0rRWJzWlR2eVNMcEtwVzVLNytIckRObUJSTHNDUTZrSU83?=
 =?utf-8?B?WVA3Nmh5Ti90TjlpOVFuRldVWFMrUytxYTFsZS96RzV4d3NBeld0WU1sQlFW?=
 =?utf-8?B?cDQzUUd4U0NRRHhIdG01ZUxBLzdSdDlpUVJGUGlmRGVQWTJDY052eDl0TEND?=
 =?utf-8?B?K3pBYnJhMjVyTVVPbHNVbFp5THMvbDU0a3ZoUGIzYUtOdGxvWlkyallzWDhO?=
 =?utf-8?B?SEpGYVIwcnVMYUR2M1A2SUtHL0ZPNGkrZExSTzFqRDFSK3JMZDl5QkFhTkFr?=
 =?utf-8?B?aG5EcDg1V21XbHpGTDJQcjN2bENPaEt6QjhORE54MGcvb0s1ZVFjUHB1Rk9i?=
 =?utf-8?B?NUdRRy84UjB0RG1ZUzhnN0ZCMGpVY1dNTU5VN2ZCSklYUEp4elIxWTFTaGor?=
 =?utf-8?B?MENySENWMXlLWkRqdEd5MC80bVhoZmgwSE1tRFY5UGZqbDU1RERrZz09?=
X-Exchange-RoutingPolicyChecked: PxPW7J7x4lUsdGV2ac3oiLkXIght1k66UrRbqEoOsdkeAw9fGAGgORfQnebTJqfbQgS1hxH3A4HFwZ6AJd67MSBlcGykudqT07BTg/0cZ9byLA6ywisw8G7sewoAF81Wu9PEYjnXmRtuGp/cvkQ/kmgoLP9Z2yyugdNkg4hd8hDq1uCgC3LH2xTgRTOcPKEIGs1wH8bThXG0LDIDQ3X8FKDHmSqmbtZtehyjJCtr015qkStMBzTr1P1TChP9xAVIMKxEmhmIMeHkegsBSzrPmAiCERMS/wEd1nuzgsedq1VUmnc+IsRlabuzmCxx1WxfGf/qIOm72JVJvSm0pqN5hQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a838969-dbe1-4f78-ac6c-08debcf2638c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 19:50:37.3083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KD3qA7oJOnyYoa86zrHXpNR74YVlOIRwvjPQSQOcCLK2tyd92htHzSWbZRm1ihBYDI6UsKp+5K9uigJ5mFJwhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5113
X-OriginatorOrg: intel.com

On 5/27/2026 9:52 PM, Xu Yilun wrote:

> No the memory needed varies depends on the feature or the number of
> features. But currently I see the total requirement is ~50MB.
> 
This is important consideration when defining the default policy. Could
you please elaborate on how this will scale in the future?

How are the memory requirements expected to grow with additional features?

Let's say a future platform has a lot more features and needs
significantly more memory. Wouldn't loading a legacy kernel with this
default policy lead to excessive wastage?

Maybe I am missing something obvious. The struct in patch 1,
memory_pool_required_pages is u16. So, will the Extensions support never
require more than 256MB?
