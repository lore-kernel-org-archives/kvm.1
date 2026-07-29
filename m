Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E140B38D;
	Wed, 29 Jul 2026 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319204; cv=fail; b=kMnPScS3WpEAAReTTNOZ4f4+8eiHfQ8XSg/iWm+zhe+5lBwP+l/17L8wrc/64VnxkMsiwUfihlhNxtt08JG2I44YWulbxVy0s9U0X3EFMR4UnNej3G6cweYERBNZ2zz+WwLysfqnJ6FEp/Ev4tW94eSS804U0359zBFaBctO32E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319204; c=relaxed/simple;
	bh=UANyNUknCnYWDZOTbsbCCJPKy8NzNEUO9/NWTE9OezQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fBTzw2bJpI/EKc+Y9mOf9maIA/im363nUQsjVSBA+o7oOJf3xj+xWCZ69ijy8Vugj/S4GBWEcQ1hus9TZzHxcPCwrpnxrz8r4iiedT4lUEWpkMdhSyP3RjvQh/B5K/WHBnVLgFMWaQ8pad7u2dUH2ByiuXA78LeK2R+ig4Kc83Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYldGnAw; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYldGnAw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785319202; x=1816855202;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UANyNUknCnYWDZOTbsbCCJPKy8NzNEUO9/NWTE9OezQ=;
  b=FYldGnAwa8PgeTF4vLqYkzavDsVolHjNSacOlAYDfw9emBrOLrMCugSb
   gLJ1Bh793t4eEjuRzr1x4PfUcacOC/vrkdqj8WFj+gvXY3N6nlbno73I6
   Cq9NQUFbOLeFTT3PiutlcIUeLfiBQvKKLBWuEdbbt6yZ54brUcOucdYCC
   EM/257MN2rkW8sWPOAL4oP/nTPQJllvUg+WS1zqFnlmDZQMmMDAsncl3P
   PZ0xUAIQgDwfl+43O0ERMpSWx6hM0iciA5LgY7sedpMgCyrSrQGp/kusp
   lccgCAAuEFjqWSbpDV+yv/1F4Vqhh7XuEqHkfwsL3uk4xcsQXoHaD5RLg
   g==;
X-CSE-ConnectionGUID: tSuALRvUT6GB+OuBnGzuBw==
X-CSE-MsgGUID: 315Kb89CSuKdKbsSLx1GsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86110370"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="86110370"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 03:00:02 -0700
X-CSE-ConnectionGUID: bDtVrIdKQsuG64O2kriMtg==
X-CSE-MsgGUID: DL3UAdpqQ12E822rrehWyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="258195397"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 03:00:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 03:00:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 03:00:01 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 03:00:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DA6f+mETyW4was7Q4Q5XaYuhjJ8FlXx4Cgfk9x5NEcJ9227WQWLIvo5F+nUCmfoDboOTRCDMQZHAgbqDAuvKGNNMz3feKHNtlM6NKh0MeSdzVbzKoBO/0q9ZY719NJJSFtOg45OtZAgrCCH3PJfXTGXhX5OgB+Nv1wTWP5RT5EBTH+YhexNpTrSBa/Y7AxKnE1W2pMM2N7l1z0CPkLph3zz6tAadFEpTWw7swIxJQhJjO757X/9AIhnv7oppsxkvvikLrgnRmXa6mrPyFUAaBy5HqIuH932p36s6OL6DSgOvgPX2iOLhmZG2V21+gfHRqyK0OQUOvKq2RuXQX+LdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UANyNUknCnYWDZOTbsbCCJPKy8NzNEUO9/NWTE9OezQ=;
 b=Ax9543q8+18JMKOw4OZ/LY5ARP03d4Z3tXluowy4kp2h+kA4/Ge+YDAsThG/4SSO9MxmjjWDxsXZVgctJlA+wLsiyQFySpXo1JVMgyRTh6sjFKYHRFmJ7/x7sSdZum/lV4e4yOlUM0nU9/J2tnc2uQjsVkrIk9c/12KHe49a6PLxT56qvXRpJxESH/kuP4ioYEWs340REfh/zqFfRUvnLEHY12J9/0PJBhifJ1h/4L7ER47nWAj5Vi9ojlrVX3U158/MVTuFY6ZPbMYcVilOY5fJi3cXxGD2Gxo4y9VI97PrXayKXox73E1554AfjwB/zgSOkaTv3tO7XScocyf3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4450.namprd11.prod.outlook.com (2603:10b6:a03:1be::20)
 by DS4PPFACFC9C99E.namprd11.prod.outlook.com (2603:10b6:f:fc02::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 09:59:58 +0000
Received: from BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068]) by BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068%6]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 09:59:57 +0000
Date: Wed, 29 Jul 2026 17:59:50 +0800
From: Chao Gao <chao.gao@intel.com>
To: Jim Mattson <jmattson@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, <kvm@vger.kernel.org>, <isaku.yamahata@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/36] KVM: VMX APIC timer virtualization support
Message-ID: <amnPFlSvI3k95uCV@intel.com>
References: <cover.1772732517.git.isaku.yamahata@intel.com>
 <aliWoldWX9/9tqNn@intel.com>
 <amlYsJzUurSeYlTm@intel.com>
 <CALMp9eSKEMotL19H4WxZN5iVfUxnDScpW0TqGLAEGSitG4AAbw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eSKEMotL19H4WxZN5iVfUxnDScpW0TqGLAEGSitG4AAbw@mail.gmail.com>
X-ClientProxiedBy: TP0P295CA0046.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::9)
 To BY5PR11MB4450.namprd11.prod.outlook.com (2603:10b6:a03:1be::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4450:EE_|DS4PPFACFC9C99E:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b70dee5-2f4a-463a-2544-08deed5825a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: gp++ebmV8TVHrxCMcBNPI/ivobDWWTVm32MHM3z7WfOa7vsgUSKsXKq9SSiT1m6ueJRmOywCzfsSAi5aTmTzikMN7kQKvxM9O06yicWqYHA9G8fR1iQItoAAwLhdNyx9xhmFPHjOrQg67+Pg2DyAgAB5oBFvP2qg7jym7iAZnzNTCP13uXEQr49MT1VuKsBf0Pw51J4OHho0QVLYlUO9M2G4J9OEeZ8hfaG0+hX8kIrs+/TuCOEuOAWFBTBPWWqeW7CLB2oh/1lvH6r6hXlGZO5jEaRUdUo6q+xECUmdqBWOFIpNUfEs5W42gQVctrVsXVe1LxgiDqyxUBs1Z3gjqLbvfbiWLi5qo7TY1S4xTA/ws3E06gx86o09jT/GgN+dN4FycM2rdJCcdhvho5B9wnfF7FQxnEWJAp98E4Wk4v+msIE14gB7d++0i1/x8Dzl/LEFBK/NSXpV+uZsnOpjU1Xo7RlZ8M+y4Xcfl7aG72k9CxbXnIKa23lQyqpIdp1vyN9hxZDEpOyQCTVaoglclosijIes48qcSoEUWGlIIxUGZeoXLsk8IsZRkvdpiJD7SxFuoYLe3ghvrJ/nftGG2eeFEVjuc2L3/rE64+eVrWDyA8JyKoAdwGTYZZEwGBEyDM4NWq3juw0ZC/gRq7cunDWKMb5Ektv/84xUg9cXeA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MS92bnlFakxKVjhxMFRoNXhrQzgremVNRFJmdHdBY1FaMmJWb1Zmc3U2THZ3?=
 =?utf-8?B?eGlRdjdlYlpBWHVnMmFiWkJZZTJ2akErd1pNT25Fcm5kNFBOU08zSXhpdVZ2?=
 =?utf-8?B?WmtOaVdTSWxaV2lUeEFSSSt4Zy9mdnhQblJ6L2hNRFAvbGhQYWw0ak5VTXhC?=
 =?utf-8?B?NTVKOHh2dTFaK1ZaTDJyRXRJbFVPbFUzM2s1SnBUZUlBUTVPb0ZMNW4rNVVy?=
 =?utf-8?B?aEtXeWxtalNmOU55bUlvSVMycXh1S0tjelppQVB6UUJNMXdOaTBVN1hadm56?=
 =?utf-8?B?SUtUUnlJK0hDTEZWSndVTXVid0tNOEh1elFhcU80cXRrNHArRnNNRE5GK0c1?=
 =?utf-8?B?K2RUTDdvMTBJTE5pZHR5aTA3UzVXZm15RUo4Sk5RcmN5MlRlUEhkQ2huUXVy?=
 =?utf-8?B?TnorSkFTZm9ybjgzS3VRWGoyMzJmcVlwWFpJQTN0aEt3bkE2WGxFT0pzc3pl?=
 =?utf-8?B?SGZXV1pnZSttanBJNUNYeVRCY0x4S1VoVE9uU1dOQ3VUekM5dlZ4WnExbGVJ?=
 =?utf-8?B?dlBLVjdDbWFGQjdYazJtSmdRdURWaWRHWDdTdHM0R0dMdEpxSEtyMkZ5aitt?=
 =?utf-8?B?VXo1RG9UYjh6L3RVM2JzWS9ub2NHbE9qUUR3SzdVbWw1REp2SW1YZkJ0Tnpq?=
 =?utf-8?B?VG91QmhxdEt5WFE4a2ZFYnhJZjh5TXQ3dTkxVGJNQkxISTFOOGhoK21PRnc0?=
 =?utf-8?B?V3RNU3BLUmk5aFkrcjJKUXl4aU1sb0JaWGI4VFo5Z3dmZS9GRHNoeWZKMno5?=
 =?utf-8?B?ZXh6bTRCWlJCVXI0OUpHaDU5NXc3b3N2MkVsTWhua2dObitHdnFlNktuOVQ5?=
 =?utf-8?B?dkNQa2ttOFFZdEJ4SE5VTXgxVTN5S2k5TFlWaEJsMWc4bGRaN0ZLdE52NlZV?=
 =?utf-8?B?TnpFMkw2ZVUybTB6WFJBYVFvbWVsYk9IZWdwbWhYc25iNkIyMXNNWXE3TEJX?=
 =?utf-8?B?ckdqaFgxMnJEZ0RQNUY3Qm9XQ1BITWpTeHdzaHVXeCtzbGNhSWFiY0RVUFNC?=
 =?utf-8?B?dWVwV0RGbmwzZmRRa2pkY2hVZEtkbDNBT0ZzSnJVZEN1RHNZclo2RVNBdnBl?=
 =?utf-8?B?VnhVbWk2dUp2YkVRWXlKQU5Ob1YvT0tOVWU3V0pvMkwrdTNEU1BNeGZyRUV4?=
 =?utf-8?B?SzNlT3JNMUNEQ1JhSlQvQ0JucW5hL08zY3hPeW5LcTVXSmN2Y3hDRFFoMGNG?=
 =?utf-8?B?Wm9ZWFFsVVpaRDArckVZNDNLNzBpQi9JL3JCWHNQVFJCaUdzYUQ0R2MrQ2FE?=
 =?utf-8?B?cWtuaTNLUkl1S0dnaWJXbXJOZWJidVpRUCt5SE92UVNYNWxYejUvRTJFT3JJ?=
 =?utf-8?B?QTlsaWNtNUhvYlBPNUF2YythTGZ1c1lWaFltQll1aGkwUFVKd0I4TjJJcDZR?=
 =?utf-8?B?ZmgyVUJlbVIycStHb2RPUy9XQVFCNHE3ZjZvbnJCMXU0RFQ1eEpQSURYdkFy?=
 =?utf-8?B?aXYzK1dGWE9raWR0NHZ4ZFlZelkwOG03RnJ0bzRNcUd2eHdwcUNGQWNHcDZ0?=
 =?utf-8?B?cjU1TmdiWlB0akZZR0FRMk5TUHJmUHJ3UUJjQ0VZYnlROHNXdXIwSExMcy91?=
 =?utf-8?B?QzRRdzdtYjJ0N2YrNDhDUFV0UmVFelZ5a21ha1BRMElYclBNcW56bkx3bmZP?=
 =?utf-8?B?UkE1SlA3eXp3MTVCRVFPMUN3TWRHYjg1bEFTbTVXUEdkR3kyTkVoYkxiZnEr?=
 =?utf-8?B?Wjdnd2JJSmFJeGVGWlBncThKSnZ6eXRCZlZMU2ppS2tWdVJTdzBUWHlOMWxx?=
 =?utf-8?B?WGVKM3lldEYvSGQxMjdnTTB5M09ZSTltbER6S3M1YXdmWDliSUFyWE1WRlF5?=
 =?utf-8?B?bjVXaytXeGpWRk9qc2hJSDltcFM1Zi9vWTRYWWtyYzVwOHZoTG43ZlA2R0NE?=
 =?utf-8?B?MmFwbGlMR0dKVTZuOTNuUE1rZ3JFcFEwOUYzNjk3eEhlSE9LS3VQbXRFQXMw?=
 =?utf-8?B?TE1mUTFhZHhtdTdHd0J3Q1NSVENSTm5MOVFrTytONFJ3YjRtcEk5VnBXTlNE?=
 =?utf-8?B?dk5RZ3QrMzVRMmFKaWluaUxhUndkOERUbXRLdytIUVdlSnIzaGx0aFZ0eGkv?=
 =?utf-8?B?OWREVVU3YXJTN29EU0tvZ1lzWjJIMjVyRVhWVzB1bzN1OVM3UUVXT2JJOHo0?=
 =?utf-8?B?WmtkVWtHQnZDK09lOWl1ekRCeHlyblNkbGE4ajBnT05JSEMxbFN1NGV2dE9o?=
 =?utf-8?B?d2dockhZeVlnaHE0VzB0SisvWWd1RUc3OXVlQjFIRVlHeGNJT0ZNcmJVSlFw?=
 =?utf-8?B?OVdhR2p3WlVMdk9QWXl5SUxQY3RJOUFpVm1EelVoRVhIcEM3RlpRUkxRQUdt?=
 =?utf-8?B?Z3lQRU84elZDN2NjSmtTM0xYa0MyRGlqYzJ6ajUvSmtHc3NWb0QvQT09?=
X-Exchange-RoutingPolicyChecked: Q4726ZT6zaH0K4JiKUqKsDbD+c5p5SxxzeFzuOmzNCzVMSngFJIo35eRL0VWIlg+e0Os1ZU+Hap/NR33OhNGaw4KF0TDBMXdClSM5WOQWU8MD2vFI7aNU6DaJ9fBQJNV4zaR5Uh9a7pVDrqNMF2ADkMLkq9ikeddfWP9pOxmOr/SOZ6teAfmLr/wS4HK3ciQyQCMSDxMIm/JY1NC9deE6XWJlQZFMle3+rTG54eRoytrteF5hpuSl7OC/ehRIy3m81g7heze37w0gRHrb6j88Dk5gEq8HWzabsj3Bul7D2vWtJojCyxOBNcMHSfSo5dEh0hp0jbrSmYXJ5vGZ6RXIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b70dee5-2f4a-463a-2544-08deed5825a1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:59:57.8768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FarGDFAqka9HeHHrnVXeNZWyCpaOTCpGUPsFQfsXMu4UHaF+s25+jU3my2leOLhc22kUh5z2L6HXyXjz/b1ZPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFACFC9C99E
X-OriginatorOrg: intel.com

On Tue, Jul 28, 2026 at 11:05:59PM -0700, Jim Mattson wrote:
>On Tue, Jul 28, 2026 at 6:35 PM Chao Gao <chao.gao@intel.com> wrote:
>>
>> Hi Sean, Jim,
>>
>> Any thoughts on the approach of reusing hv_timer for APIC timer
>> virtualization?
>
>Last I heard, APIC timer virtualization was only available on E-cores,
>with no P-core intercept on the roadmap.

It will be available on Coral Rapids as well, so it is relevant for
server.
