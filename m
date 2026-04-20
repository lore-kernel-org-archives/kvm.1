Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2D03F9FB
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776723887; cv=fail; b=sDFrp+DKtMDPXx9DApOMi1u6IeocJa0SzGdrDSXXfU5ShvbA9qMiX5J5ttY3l3tTzrFfPF0RXsiEa6+0Tg8DD75FU85ZAMDObn5Kz0P4i/QPPVQ+nSSoxfV4FKRMhlH2fSSXCMjUICWEZNSvLDzTeOyrgWv73LVf1/6K71A0OeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776723887; c=relaxed/simple;
	bh=LoC96xCS5u4VS8R7qVjKyldiT0gn77MfCR1CPzHwBKg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kbKkyBKbz2XaL/wkSPkICWWXJGoRyxNY8r2No95/monCB1bQ0DIHShK6iIHvnfY7GFkoql3hrDDfNumVApBg1ZzhGanTWCy8ShJfZxrVaNI9WMGJv5wu96NsqnxO1hswnxrWHWE71FjAFPCQDCq5uTBpMdi80tMAGvancPah50g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DxRpKhOc; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DxRpKhOc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776723885; x=1808259885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LoC96xCS5u4VS8R7qVjKyldiT0gn77MfCR1CPzHwBKg=;
  b=DxRpKhOcGM865kDCkx0VsdkeeYxTBg/Pbc/Obs0BkmNUTaYmJYj+XzS1
   YaezoE5+MoG6xon9bXXNIjYawbYXYhMsXly2Wft9+q3u0CqeqndYCgGDE
   ddsI2f0k5vdEDBXnCfmtJhKHY+rki0BxLLLlFvgfRRaI7Bt4SgsW8deGX
   ifOjusCX7RNX3GgZrDBdFaF5s/9VhJIgGSy7c+Vciv3eTQa5SPQSbngwL
   6XLNavUUOdRRs4h9GNB5F1F2JfKhleA0pyKws1XGlGUnjKfTL659WZPNT
   SgGyb13YmweQ7pqGGaKInt+0Z6VBMHndcJooSDf0cKw7oYaLWTkNYfkTK
   A==;
X-CSE-ConnectionGUID: M/ka/WJrSBSTK9VDN9ro6g==
X-CSE-MsgGUID: Q6Od/sN8Q6asdoPIqwYStQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77522011"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77522011"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 15:24:44 -0700
X-CSE-ConnectionGUID: ZljqkVcaS5+lxP+P/Tplhg==
X-CSE-MsgGUID: qNxTEekUTQ6Az46NXjbeAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="255314844"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 15:24:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 15:24:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 20 Apr 2026 15:24:43 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 20 Apr 2026 15:24:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/YpIIB5qcF2VF+svMPjMufpyt+2d2OQlyJnvvkxh9aH62/FUz44plmLAUU+lceABHEBDLIl13O7MgSEl4youcSA9/DL8vRSktRadWosiC+sjqm5SipRppEG9MuLU0JcouvKnwtlwr3zdik1AzhCg9A07644k0GKL+K+8UOOekT10zkRlvcMT/7vxjyxjtwsad0iqyQQsDXMppdQECBJ0/PJ+8lV5X+ag75JgJRo/bivvCxMXwnv5wju6UZoEdBxg21J//ZC1PQSU3yv1B2rghu8jVXzqt5qZPzHSDdcO3n/pgcNHy46junPXagG2B3VevYcowIsZ3S+V9FQiWNjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoC96xCS5u4VS8R7qVjKyldiT0gn77MfCR1CPzHwBKg=;
 b=dLVxPBDEf81TIfDx0mUwreFxctRWr82rPoaDaPM8hHYHaVZq4uF3ykXyovgpIRsVs0tehCNeJzTD1gAnJugZZIoWrAmeaP6gv0JN5ualj5YtLLFEQXnqd32mmyBxpRGl9AmlIeqT3tWLQYn4uA7b9Pf0uSSEEzzJx1Zue56LIhlNjfZ3KVycIS8bUz9CLpgMzALMkzQ8CR/7Vw2T+w4ay2NZhJ62fRTEcgA20RiFryGtNnkKlZaYBl/MhUBl9YEY11pugxncsUs8N31aI9PP4DY9sMBMNcfm6Sxs1hOA5vhTxJAfkRKFOAS/6/jy1NWllqltaPByjL6GCRJTlxYgdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by BL3PR11MB6388.namprd11.prod.outlook.com (2603:10b6:208:3b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Mon, 20 Apr
 2026 22:24:39 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af%5]) with mapi id 15.20.9846.011; Mon, 20 Apr 2026
 22:24:38 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "tglx@kernel.org"
	<tglx@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
Thread-Topic: CPU Lockups in KVM with deferred hrtimer rearming
Thread-Index: AQHczeKk+wS46Li00UqCaHMewgV8CLXoEP2AgABj9ACAABa+AIAAAX2A
Date: Mon, 20 Apr 2026 22:24:38 +0000
Message-ID: <04969e4690e146fb90894bfb22b391249b4174fb.camel@intel.com>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
	 <87mryxekxy.ffs@tglx>
	 <bb07d5ee721f5fd4e3a168fdebad1b450eb6bee7.camel@intel.com>
	 <87se8pcm1l.ffs@tglx>
In-Reply-To: <87se8pcm1l.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|BL3PR11MB6388:EE_
x-ms-office365-filtering-correlation-id: e34b89da-eebf-4fd5-c1fc-08de9f2b9c03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: KmivlGT//E++roQDeiFo2uLONugUi5WlW6afzE/il2yqMAI8Jf/nuv6NwCAh9FQTv5/rX0OuTeoUCKuKbNXDniorYb9+T0UjpQ10GUicTUaCIgIHguc20GyOoaVxUi+qeA6jyTZ2Ju5PE/sS9WfVwx9jQf1F4u5lsvejZkeH7v+C/3va7ztMUP6slW9Iiekatx3tWYbFlBgjfQnptss0+oVmYMJJ66nOHKaFaYvYQT4FTWosJc0CBvIBRAsipOE9P+J2sEYGyEfftvzseAWKN4FCsb2rTkIiJvzxCkomTFiqYp0sHgNkBJUwTiHo7Hcjbcnej1Zf7z4MgzgGYSUmazV9CwMzypplhP1qwM+Q7sO0jXv37V3tALlDC7tj5HTHtp1b24EggtcLvas7iYAcglW0oHBnXKlqZ1z0QmxXX4eCwbc46Hk9AcSo9kLNNar1oqFZLyMeLzDqu++iJED9idTyPDmP7o9gErtqZ7+KdmzB+kYm2QwVRS9nKM+LMftZqUcWZvC4VfJYIDPmiRFhJGlvxoflVJZqg8YtDTvo3F6ijXaOFY6LSNHdJjgXC0lipxlSFjYWFj5HTHF1WfU2cMKJLoPImHsj4NA6TCxg5tajubvM/6K34yRc93aeM/xECGVX5zEpTOaZIxUmEsAbY13C/Ex74N035kKD5JkBVhoVOFRe7W0kuK7Tqj8ERrfsNXjdPInkEA37TBxMmcq90kaMd43yP8LQhCRTLwVPV//1DaX8UxFZaz/rmxJCrWDp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGFmMEQzVGdNRUxTTVNQcmE3eTJuUUVwN2UrdHFWL2V5Vzh6UW02aHVCWFBT?=
 =?utf-8?B?RjFGU0l1N3hxVmJVNlMyejFyQUNqY1l3Z0diMzVwOUxzT0JnR3VCNUlGWi90?=
 =?utf-8?B?K2hDOXdIdWozK2hrN2hSaUJqRlVuaWRxTjZkTi9FZURGZnoxVFB1QkdvTkww?=
 =?utf-8?B?b01VNncxenZveW1ZeU1NWUUyQTFaTFdsazdpVUhrbnNpTXlqVFBuMmhTcWZt?=
 =?utf-8?B?TzlKSU11VURVcG9KdTkzTjlkb05qQ3VmVXRCdC9kUmFmWjN1dWMreklOMGc5?=
 =?utf-8?B?eEJDcFlLWHU2S0hPMWplQk1RSDgwT2VFdlJHYytHZEhLK0ZSZjdnTzdhdFZZ?=
 =?utf-8?B?YzdkQXpqNFVjVnpXUzIyUitUb2JRSDlwYTZBaTEzM0hCbTRjZXpJQ1U0eUFJ?=
 =?utf-8?B?amNSYmwwbjhFSVVhVDlRMmh5OWdHS1N4dkNkQU5OelZiVUhBdmduR0FWSlIr?=
 =?utf-8?B?RE82T0gwRTFlT2ZOY1g0Ym9XL3ZpYVVvUGNqcFlDTE5JazAwcTdKT0JvMGls?=
 =?utf-8?B?RkFYZnFsUktZNTN5VG5NWHJOeWRIVGZPbFgzRmFURVJ5MlBGNzJFa2R0WStB?=
 =?utf-8?B?eHBjaUJxaS9LdFk2aytNUFllZUI1MEFoVU5vUWdrWDc3UEp4Sjhwd3Q4YVJP?=
 =?utf-8?B?ZnpmMG91V0xHM2F1L0cvN2lXY1F3ZjNNT2NheFBhU21TL3N5RVZiVE1DNVRQ?=
 =?utf-8?B?bTZKblhaUm5ZcU12Ui9VZWEwcUxPaVhrOXgwV0MxeHBPNS9zeGorNExsbkJR?=
 =?utf-8?B?TEd3WEFVK090R3czVEIwV1AvOUhUaHJCdUh4RTErQU1mTUdwZXk1QmhhbHNn?=
 =?utf-8?B?TkRtTXp5cUVqTGsyZjJ0WDdQMUpnS1VGYi9PaUNZMHJETWJrcWFHRi9jNGJv?=
 =?utf-8?B?d3lxMlR1MkkxN2xIRWFyRUpnT2wrak42TDVPNURBa0ExQzNPTmdqSURpclZo?=
 =?utf-8?B?NHVEWXE0T0NzK0h1L3MxalcyYzhyV0FKUHJrMjR1SzV1dVg2STBNWnk3OHg4?=
 =?utf-8?B?UG53MDFMZ1V2L0JPdHFtTHloc05HTEhiYnBpV3lNY2ZYa2pVMGVTTGFKdGhW?=
 =?utf-8?B?dEd2UG9HL2Y3RE42TG9vcXYyTFRtN2xVQ1VtUmo2TlBqbzB4RTNPWWd5bEda?=
 =?utf-8?B?aW1VVHNaa2hyN2ZiN0l2L2IvT1htdmVmWTcvUThGNXhBck5BTWh6MG1lUjFo?=
 =?utf-8?B?ZFFKVG9wUC84Tm1QYkU0V0t6SFRhYi81a0tacHhOeHhxOEYyT0ZoVmVzUFhq?=
 =?utf-8?B?bHBIZ1ZmNXFyTGxwb2NhSHBiWTlQTjRkQ1lFZy9pcm1xLzlDWHVvMytTd1lT?=
 =?utf-8?B?RFFsaUg1S09QenBFNEpJZFduR05HU09mc2V4UG9wTjZJVVJQdUtZR25PTUoz?=
 =?utf-8?B?ZWZHREYzaFArY2hiaU83Z1hUU3Y4c1g5TFMzSTRUT1E1cE9LQ0wxdUdUbG8y?=
 =?utf-8?B?RFM3NkNsSlZLaWNLWVBmcDJhdWNEVWo5VFpKUUs5ZHE0YjEwZG53dHFneFZa?=
 =?utf-8?B?bDZ3a2ZGNXkvVEVVTUh6R3IxMkN5d1czc1YwUkRHUDlFUC9SeEk2SHk0aEZj?=
 =?utf-8?B?ekw0dlFDbE44a0JtTDBYdGMwN2tCVzJWaGIzYlFTdSsrSjJwai9zVmZEWW9Q?=
 =?utf-8?B?YjVHeG4wdVlLSXAzUU5pUVZyKytkYmRRVVh5TkwwN2ZIUkRrZ1BvNXBzek1P?=
 =?utf-8?B?UWNYSWVCS1ErMDdCa1NhSElLQ0tvY2dqc3RpWkZrNENtMmFpYXI5K280aEVh?=
 =?utf-8?B?d0E5Ri9QQTNCQ2lhMHVkOFl0MU9jUEE4UTllOHBLdWE4NGZkdDAxSTV0WGVL?=
 =?utf-8?B?WFpTMThzTHZYV2I0WXo1OEtUelB0bm51Sjc5WTM4aWlpNDdGQjhZRlg3aFln?=
 =?utf-8?B?QlUzeVl3UTVkOXlzSVk0QWRmNTJKaEpCcFQwM0RzZGNkVlpEYldRLzBhY25M?=
 =?utf-8?B?bEprQzArU3dkQTQrQ0RDak45WW1lNHRVSjIxSjJFRzRjY21qMzdaRnBON0xS?=
 =?utf-8?B?cmN2ZjA5RjJUSDBQTGZuZTJ6ZzNVd3hOMXlvZmFFOFNkeUsrdHYzdG5mSHlH?=
 =?utf-8?B?a2w5TG9KL0VSQVA2T3I0ZUtTUGxzVHhoZEVKbWQrSUpERnBLNVBjS3VOZjFH?=
 =?utf-8?B?eWVZWEU1RzR2WlpabnV0STJtV1kzNklzdkhPM3h1YUl5VWJ1QzRKTXJ3Q3FY?=
 =?utf-8?B?b1FaR3JwNlV6QmNYMWgrRFUrNzYxaGZwZmErbFRsR2JMM2ZKNFhsbEpieStQ?=
 =?utf-8?B?a2pJeEhPK2pVcnd1L21Ed01vSFAzbnlBYWpWWS91WGFPTEc5WVNlUnRvdm0z?=
 =?utf-8?B?N1N5cUJkREtmekx4dnIxZFkrKyttcDNIV3gvVkpVRjRBRmVpanNCeWdlRlZk?=
 =?utf-8?Q?n/Kf/gyTu76jOUfY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86F92A093D4C6D4E8A80C4763008504A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QTtbXSm3Uo8GEphaWxFMfshsVkzy72QrBZuiRsKLnstRHBpA1zIZ4CbqLlKpagbCRxtNAmvUVKb3rMpIjBEwlBg5iBckQCr/RVQqWJ0kuFNMzFvQonWxcHMqsRn2KDdpzupmTLjzgBcJAxDq/bHgM9Jtx2SAcg0RA5RTNQC5gSViYf7AkmX+o9gj9TZcmNUViVwNpWjQkkLlZGt6NkOCU/Uuuqxj6/ZOrgNLfYwHJR31tDqKu8Efjd7GlqzAuR9rXAVzszbGRvCoHHU8sP8xHuTFw39YkdhI4ky6ZPEXVChynXIsUHJfeTjOicx5eeA+ZRyRwPLE80YxOjLLSPE9zw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34b89da-eebf-4fd5-c1fc-08de9f2b9c03
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 22:24:38.2654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oUTKpxdqJ/Bwrpg+0l0BxqfK8EVyPQToZLkEbXnzDhGyj7weVzxdOnXVzFAIPAFwHDCO9in5V86bljxRfObYhPP7INuO26xJeKx9/NKKH58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6388
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTIxIGF0IDAwOjE5ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIE1vbiwgQXByIDIwIDIwMjYgYXQgMjA6NTcsIFZlcm1hLCBWaXNoYWwgTCB3cm90ZToN
Cj4gPiBPbiBNb24sIDIwMjYtMDQtMjAgYXQgMTc6MDAgKzAyMDAsIFRob21hcyBHbGVpeG5lciB3
cm90ZToNCj4gPiA+IA0KPiA+ID4gVGhpcyBjb2RlIHNob3VsZCBuZXZlciBiZSByZWFjaGVkIHdp
dGggYSByZWFybSBwZW5kaW5nLiBTb21ldGhpbmcgZWxzZQ0KPiA+ID4gd2VudCB3cm9uZyBlYXJs
aWVyLiBTbyB3aGlsZSB0aGUgcGF0Y2ggIndvcmtzIiBpdCBwYXBlcnMgb3ZlciB0aGUNCj4gPiA+
IHVuZGVybHlpbmcgcHJvYmxlbS4NCj4gPiA+IA0KPiA+ID4gQ2FuIHlvdSBwbGVhc2UgZG8gdGhl
IGZvbGxvd2luZzoNCj4gPiA+IA0KPiA+ID4gwqDCoMKgIDEpIEFwcGx5IHRoZSBwYXRjaCBiZWxv
dw0KPiA+ID4gDQo+ID4gPiDCoMKgwqAgMikgRW5hYmxlIGZ1bmN0aW9uIHRyYWNpbmcgYW5kIHRo
ZSBocnRpbWVyKiB0cmFjZSBldmVudHMNCj4gPiA+IA0KPiA+ID4gwqDCoMKgIDMpIEVuYWJsZSB0
cmFjaW5nIGlmIGl0IGhhcyBiZWVuIGRpc2FibGVkIGFscmVhZHkNCj4gPiA+IA0KPiA+ID4gwqDC
oMKgwqDCoMKgIGVjaG8gMSA+L3N5cy9rZXJuZWwvdHJhY2luZy90cmFjaW5nX29uDQo+ID4gPiAN
Cj4gPiA+IMKgwqDCoCA0KSBSdW4gdGhlIHRlc3RzIGFuZCB3YWl0IGZvciAvc3lzL2tlcm5lbC90
cmFjaW5nL3RyYWNpbmdfb24gdG8NCj4gPiA+IMKgwqDCoMKgwqDCoCBiZWNvbWUgMCwgd2hpY2gg
bWVhbnMgdGhlIHByb2JsZW0gdHJpZ2dlcmVkLg0KPiA+ID4gDQo+ID4gPiDCoMKgwqAgNSkgUmV0
cmlldmUgdGhlIHRyYWNlIGZyb20gL3N5cy9rZXJuZWwvdHJhY2luZy90cmFjZSBhbmQgcHJvdmlk
ZSBpdA0KPiA+ID4gwqDCoMKgwqDCoMKgIHNvbWV3aGVyZSB0byBkb3dubG9hZCBmcm9tIG9yIHNl
bmQgaXQgdG8gbWUgY29tcHJlc3NlZCBvZmZsaXN0Lg0KPiA+IA0KPiA+IEhpIFRob21hcywNCj4g
PiANCj4gPiBJJ3ZlIHVwbG9hZGVkIHRoZSB0cmFjZSBoZXJlICh+NzVNQiBjb21wcmVzc2VkKToN
Cj4gPiBodHRwczovL2RyaXZlLnByb3Rvbi5tZS91cmxzL0I5UFk2MVhRMEMjMDdYd1RWaEU0NmVC
DQo+ID4gDQo+ID4gQXMgZm9yOg0KPiA+IA0KPiA+IDFmNWZmYzY3MjE2NSAoIkZpeCBtaXNtZXJn
ZSBvZiB0aGUgYXJtNjQgLyB0aW1lci1jb3JlIGludGVycnVwdCBoYW5kbGluZyBjaGFuZ2VzIikN
Cj4gPiANCj4gPiBJIGFscmVhZHkgaGFkIHRoYXQgY29tbWl0IGluIHRoZSBicmFuY2ggdGhhdCB3
YXMgdGVzdGVkIGFuZCBpdCBkaWRuJ3QNCj4gPiBmaXggaXQuDQo+IA0KPiBUaGFua3MgZm9yIHRo
ZSB1cGRhdGUuIENhbiB5b3UgdHJ5IHRvIHByb3ZpZGUgdGhlIGluZm9ybWF0aW9uIEkgYXNrZWQN
Cj4gZm9yIGFib3ZlPw0KPiANCkFoIHNvcnJ5IC0gSSBzaG91bGQndmUgc2FpZCB0aGF0IHdpdGgg
eW91ciBwYXRjaCBhcHBsaWVkLCB0cmFjaW5nX29uDQpkaWQgYmVjb21lIDAsIHNvIHRoZSBwcm9i
bGVtIHdhcyB0cmlnZ2VyZWQuDQoNClRoZSB0cmFjZSBmcm9tIHRoYXQgaXMgaW4gdGhlIFVSTCBh
Ym92ZS4NCg0KVGhpcyBpcyBob3cgSSBjb2xsZWN0ZWQgaXQ6DQoNCiAgIHRyYWNlZnM9L3N5cy9r
ZXJuZWwvdHJhY2luZw0KICAgZWNobyA0MDk2ID4gIiR0cmFjZWZzIi9idWZmZXJfc2l6ZV9rYg0K
ICAgZWNobyBmdW5jdGlvbiA+ICIkdHJhY2VmcyIvY3VycmVudF90cmFjZXINCiAgIGVjaG8gMSA+
ICIkdHJhY2VmcyIvZXZlbnRzL2hydGltZXIvZW5hYmxlDQogICBlY2hvIDEgPiAiJHRyYWNlZnMi
L3RyYWNpbmdfb24NCiAgIA0KICAgPHJ1biB0aGUgdGVzdD4NCiAgIA0KICAgdHJhY2luZ19vbj0i
JChjYXQgIiR0cmFjZWZzIi90cmFjaW5nX29uKSINCiAgIGlmIFsgIiR0cmFjaW5nX29uIiAtZXEg
MCBdOyB0aGVuDQogICAJZWNobyAiRGVidWcgcGF0Y2ggdHJpZ2dlcmVkLCBjb2xsZWN0aW5nIHRy
YWNlIg0KICAgCWNhdCAiJHRyYWNlZnMiL3RyYWNlIHwgZ3ppcCA+IC90bXAvaHJ0aW1lcl9yZWFy
bV90cmFjZS5neg0KICAgZWxzZQ0KICAgCWVjaG8gIkRlYnVnIHBhdGNoIGRpZCBub3QgdHJpZ2dl
ciAodHJhY2luZ19vbiBzdGlsbCAxKSINCiAgIGZpDQo=
