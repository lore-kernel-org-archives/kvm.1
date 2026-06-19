Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0818C35AC09;
	Fri, 19 Jun 2026 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854213; cv=fail; b=a8yTIU2R5zK2Qy/WPrcjyZpsL95Yi0tYvku4gK7BDr7kQpxxoRr6AQJWk0QDYJIh8KRVnotNm/pyW299erNVxlSCg3aj+6maTU+jKyxC11toO1w/dTPNoCJnirdIa0j1gI/nOsOPwZAYSlHGRp6d9H2nTLgkwqWRsICM2fI9kpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854213; c=relaxed/simple;
	bh=1TqzuL7wYeb3Mm1dySTXQG2SWajO0cPbt8DSZBcMR9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nqycd9Wl7/Qhi0w4tMGLiNq4adJy60RmiaNoFj3s61Rtb30XRtYYr9XlAmfYV9XMazIf1icI9KDayCllk1lvS3K1xrvL5Xt2oNvUiAGEe5OCzxbV1nuAftNph5WMnq/WUTaC1MlnpdoDl0YUJOR+S+AmpX7PsIOvk66Fg0B59dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVJpw3tA; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVJpw3tA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781854211; x=1813390211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1TqzuL7wYeb3Mm1dySTXQG2SWajO0cPbt8DSZBcMR9E=;
  b=PVJpw3tAFyGEZnvEYzUS71QZX6UPPeD8E70BfVKxeqGyNURgO8L7L+QV
   sj9eMREqRxrQd/QMI7RhBhD7lrxcurp8uNr4Gm7d3K9CUECXDXD9tXwbe
   f/w9mM6XXzxsIqkDfr4FmpaS93qnnusp0qCUYWCsFfVklYICZxKVO4ovH
   du83h420u9MGLA7IOANsYA3whmmEkrFojv2XZse63HTh48YVmduYssB8B
   EV2npxneV951pvgCpHzB2PgVAySzmXq+Q/xSsvkczPKDn63wTaXizxBhg
   +hiZjSDECSbeCuvLFkQkDsrBAMR4iw+CUi8XbTL8vpEf1nc0AbuH6tBnn
   A==;
X-CSE-ConnectionGUID: R6YZoGLbQ4mGn6Beg6caTg==
X-CSE-MsgGUID: T6vEW0EzTraUcAsRN/rP5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="100252233"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; 
   d="scan'208";a="100252233"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 00:30:10 -0700
X-CSE-ConnectionGUID: n5RJXRzrTuuiv9ZBVEhcrw==
X-CSE-MsgGUID: P0qbkGrzSSiVmUkqSZiG0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; 
   d="scan'208";a="248427741"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 00:30:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 00:30:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 19 Jun 2026 00:30:09 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 00:30:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5aQuBM01sdSLp/gHS+6wKI2g6QnplgVaKvbDJeBEI8ajMVQ0WiTLadeTu8KjlzG9Yh8lgvKRLcXFa5hk0X50LBne4W5sOFeDyr2Pw5Lggxc3+vN30geNf50Hqa/4KXh3zcst+LL5kAIavGBqBGzwdkhNdWPeCFqhicXBsHDZCaOltsJct1+3vqxfHa9vFWIyYDNVd2Q8m0uggZAo+h6mIpUk13TpjyAVEK+KMFOGn/r20yXCJ9zsZne0qNbM7qH7lJsgMhnkqH5lK0p/+crTbxeTBIFK52mpd3liZfNC6dXZv0fFdcpMDi/x/AW2w5hDbd15idWWvzmXRbhb4cglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TqzuL7wYeb3Mm1dySTXQG2SWajO0cPbt8DSZBcMR9E=;
 b=kA1VOm5e7gsX52eHltQAiSnRga25XkphSB6YXInguj9nPVV9gfp9D6jf1KAiBJ37rR1wcZHxPv32Y/3soKmAjhgBn+jCHzaIJgusuWCyB7IvYAHV4rCoSQf9rFWls1UgfM+hSSjHMbWgmnNIl3xvqJXAbjJaDSIXPeNU6Jw0MPkOYLRlAtJ9OG6o/2nWE7P6hUK4DveX8yT5FLkkr4MMUwKf3cpMVC/7Cr04cnsHCP90naEjhUN6O4g2p1VsOrVbW09J1UCCOhoWFk8XZ0F3VX8T81/dBlsJCjzCy6bHkH86HHwhKsvyjY2IIan+rn7DYP+iOE3hQMszoaPJPfES0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 MN0PR11MB6160.namprd11.prod.outlook.com (2603:10b6:208:3c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Fri, 19 Jun
 2026 07:30:06 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 07:30:06 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86: Bug the VM, not the kernel, if the ISR count
 {under,over}flows
Thread-Topic: [PATCH] KVM: x86: Bug the VM, not the kernel, if the ISR count
 {under,over}flows
Thread-Index: AQHc/1Prg9g6L9qgDESt6DgoqKeIfrZFfDwA
Date: Fri, 19 Jun 2026 07:30:06 +0000
Message-ID: <4f2306838b1a6bdd0effff5ea4551877bc7b4256.camel@intel.com>
References: <20260618185350.2020845-1-seanjc@google.com>
In-Reply-To: <20260618185350.2020845-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|MN0PR11MB6160:EE_
x-ms-office365-filtering-correlation-id: d662e8d7-cd4a-41e9-944c-08decdd495e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: YjzQOhmU3gX1uWXyn/uZ4mU+TZkW2+gJny/qM6ZFM8bLtbU32ffPUjUekMBRBA+sWqhWpnYAHN0nZY2TswhHYv8uHi6BfXn2Q9vAFgVLmV1LY/lJbcGbQm6jw4hasSpjW4/BIMPl5W71zdk6jzMdQvrz9P5fS3loUTiI6aj0p1GtA1uBI+NNwtbcBySKcSxYbXLB7EcMjpn0vQv/f3yM0ghwDT5D7MLeaRwj/tZWchFNDpY10qpKKJcFp2XPWoXDkwOR3rnuBtdvkbk04fBLxf9RqIFJPwarvdD263114sRl33tUzHIaqrjSc4ACi5oAS3XrpZooBjDAmbUwX2Q7blJkl7MhCwBTC+MTyRsFT8u57MoXAF3x9iDR7NMa4pIzMnW3vZvFO/qAyV2bgCEBq6h+n5O/LhBQkBI2YWO+CPj+eERwSyHuye7ntO4uEukbOQRFp6VFLa1oF99kJpAdlrsFcztTVCDRlZA3wunTRGzITHZqGW8Ru3pBEiIjFg8+qEfMb2KRy/xhCdu88W/T+IC5HUXaNkQNeT+1K5Fsi2I04DiP3e6pG1dTW/s2cgXUxw72bcjzJfC8R0lqDgp95CSQsSDoajZru9iH1Teng8yPhU9BhUE5lOzmhgCTXuYiLZPw2vlkdKiYNijMr8RF1b3vdqKkmj7K6oUr5ZrGVgJMQJJHXTYSW6aApRoaGeUcX0kMRZBuSyX2DZZOcMfKCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUd6K21MSm9ZSGNpbEQ5cWxaYWZVblFvazVCblBEOHYzUEYzbHdJMUg3ck93?=
 =?utf-8?B?TU5KSjNEVllwVHNGRU1MbDNhQjFmbTNyUzkrR1BVOWhuY2tyK1lvYkhJczRZ?=
 =?utf-8?B?QUN5bXlaYzlOT21PSm84d1JpOERYQ0lxeG90Um9CdnNpM3BaL2RzdTN6Skdk?=
 =?utf-8?B?YThKVTB3K1VZemMwNTFVckVGWitmc2RqcXBsQndZNDlOKzI3KzRadnVGR09L?=
 =?utf-8?B?TmxRY3FnSUpVdHYzSHZjbnRKdmpES1FIc2h2M3p3MW8veEJZZVd4Mm9kVU5D?=
 =?utf-8?B?NlBjNDhLUy82UkkyQlhNTTZSc2V2SmxTQnJ4dXZ4VUhEOG5UcVlOTFZ1Qjh4?=
 =?utf-8?B?eEFtbVhPbk42MG1jc1lyU1lXMzBhSkw3aTV1b1F0N0p2SHltc05PTW8wdEpD?=
 =?utf-8?B?ejNqZjBWSW5Mc1dVL0ZpV0U4ekl5QzM1VlgxSUwzUjRhZ3RiQWFOcXhObjhw?=
 =?utf-8?B?WUVJSmxtWnFGblBidW0zTlZwK29QTkRCRnNLU3ZqL1hMNTVvSGpiTUUwUVBh?=
 =?utf-8?B?bWNsYmM1T21vb0VkbmtYV1pQcXFTYi9XM1F1MUFoNFFzODVBL3Ntbk5MYlJH?=
 =?utf-8?B?cldKY1huVkloRVFaZ3lkdnowYVVhTURDbHpqdTh6cklFQWYrWUJnY2pUVitm?=
 =?utf-8?B?KzZXQVkxSlMxWTVXU1hLVHduOFAreFVzemVPQ0lDSFpwU2lGZXJxL0lXYUVk?=
 =?utf-8?B?Vkt5eGluVE9aOGFwTjNNSmhGMGVJNVpubHUvUFkwQk1hTVZXckxuQUtDSEVp?=
 =?utf-8?B?T2EycCtzK21jUWpuSzI1NEprN3JEN0xWL0l5LzhvT2thSm5FclV5R2xKNUdT?=
 =?utf-8?B?ejhiZkY5THgrM0d6VHA3UkVUaWZJTzllZHVvWHUwRkpOQ0pvOVc0a2d3MFFF?=
 =?utf-8?B?bVdVRll4UGNUVTNUam5oaGhqNGFPNHl0emkyb1lVdVBhVUdZREU3NURkcW8w?=
 =?utf-8?B?aGMxb3FNcU5BdTM5elJ6THdxcU1xTDZtQllVVWtJQUh0dDFod0tGVkEwandi?=
 =?utf-8?B?WTVneDV3b1hpR1hKRjRnR2Ezalh5c2p5NGFWS2tvUkc4OElYV0xMaUlOMVkz?=
 =?utf-8?B?azRDQWgvWTVPLzJEdjY4ZWFDODdXSGxvZk9QTmkvY0plZDZPaXh3R3JFWDFu?=
 =?utf-8?B?aVNiY01YM2ZtaVRyTFZuNFVicE9xcnJ5UHViSHpiN2NEaWlVUHFQV0g4aXZO?=
 =?utf-8?B?V0EzaXlDNUxBME5WV0pabXJjZndueHVud2wrOU9pbTJ5R0V5cHRnU1VMQWJL?=
 =?utf-8?B?U2oxV09qYnAvS0xmYnlGUW9vNmR1SGU4eGpFZm11aU85ZzFlakF0UXc5VVps?=
 =?utf-8?B?Mm1EMjF4NjZjNVdsVGdYemN6VHRBYVNMZTJYeXg3L2thQUh1Zm9OSWpJWlNx?=
 =?utf-8?B?UTRSVHJaMHpoWDdET0JtSjZMTk5lQ2RjakN3VnJJTXprdGJGRnR6S09pNm1j?=
 =?utf-8?B?dHdBYi9Mb2JJLzFPR1AxY1RoSlQwdnA3UEFYSnJFbjRHc3lNYm12MDgxVGZT?=
 =?utf-8?B?VUhLTkFvdWJpS2R0ZGdsQXVMT0x1a0dNbDlKOUhJTnM5Y01XQjZ1N0RtQ0ZQ?=
 =?utf-8?B?MHBKQUU2UHpkVUFEK3JVL1ZYL0s2V3U5eHZiZWxvS3M2bU9HZDdpVG5vOTZt?=
 =?utf-8?B?MGlIWXp2MFV6b0hiVEZHQ29TTE9DM2ZFbUhHNDBHNWlGT01uamRrblhVYzdm?=
 =?utf-8?B?WE83a0Nia2VHdlFFNFErU0E1RXlCSG56K3VibHRpVGJWVDBSbVVwNkFlRm1y?=
 =?utf-8?B?ejJDTU5UZDZtVlhrRE84OHZpYURnbC9BOUxvdldaYTQ0SHBsZ0s5akcvNThY?=
 =?utf-8?B?d2xwNndzTmtvdUFKTXpERENaRFp2OVhaTmFLOVA4WGFmNWczZzJmTmpzUXMz?=
 =?utf-8?B?bDlXMWF6eTkrdkg1eHhMeWJ1WEltMW4xZVVvSk1hUGpOV0QreklCNWpUSHpI?=
 =?utf-8?B?emxia2JGcXZ2VU1zTGhpWlNwZ3dQRDBRU3I5Z2oxVDNySHl2TW9iT1FEVWxS?=
 =?utf-8?B?U3ZncmRTVlphenl5Vm91WHh3MStmU3IwYXhUSy93V2tuZ216dTJmejdOa0RB?=
 =?utf-8?B?bGZ6MklOV3VLOUU2WXYxaDhGZlJFTFFyNUo4S1JWRmJDT2JMSUs1c2hCdDlZ?=
 =?utf-8?B?L28wT3dvdkRjM3BxOXlrR2hPcmU1US9mazNWVGZ3YytmRTQxclFZdG1EdDhG?=
 =?utf-8?B?Q25kZGJoOGQwZlRsN2JXRjloSVAxaEozUEJzdDRTZWFyc1A2UUx5TU5jSENp?=
 =?utf-8?B?OEJoZFQxWHpzUmFQam4rUFBlTFBTR0lkVU1kVTBiOGIzQ1lyRkhBRDhzcTFn?=
 =?utf-8?B?cHVPWjdkbDhDSzhINnF3KzM0aUNUSVo1bUV4WVNxak1hUGdPMXpydz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66275977374B2B4C8964A7A2746755A5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KIWTzmuJdp/BfmBcIhNSuTl0sW7nxhgYWOk3gUYeYXi45l78oITLv7axMtUwSKXdbB1edxDxvltbPK89tSZUam4GeGBXLa10qwpnIR9fG7EeEYTQ2gaWEsRv1yQ/Wj28r5iI9uIATh3mMPIouOtBD5rkqmYI4oM8DwQygJ7o1HPPzcig187kbd6Rq8NdGZ9S4Mam9HXMiUDnoUQPqr1udx7ey/eCJELcKqKTfnzJxKe4XxG4/fIo1uCK0P5vz+A/nIPYZFROlQKHLbVIMsfR97EWM4gKBrE1JdecMqNOXLIu3PyonMOufGZeMfUQ5ursDnsXD09OUxKvb1eWvWo1cg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d662e8d7-cd4a-41e9-944c-08decdd495e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 07:30:06.4225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UibVfEb4jkDPoXDh4gN7m45RuQFjDfFvkfgz4f2NMCOIeMHGd8EbhjDIYVpopM5Je1liwPUMYYAJio3SCoT7sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6160
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTE4IGF0IDExOjUzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBCdWcgdGhlIFZNLCBub3QgdGhlIGhvc3Qga2VybmVsLCBpZiBLVk0ncyBJU1IgY291
bnQge3VuZGVyLG92ZXJ9Zmxvd3Mgd2hlbg0KPiB0cmFja2luZyBpbi1mbGlnaHQgSVNScy4gIFRo
ZXJlIGlzIHplcm8gZGFuZ2VyIHRvIHRoZSBob3N0IGlmIEtWTSBtZXNzZXMgdXANCj4gaXRzIElS
USB0cmFja2luZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNl
YW5qY0Bnb29nbGUuY29tPg0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50
ZWwuY29tPg0K
