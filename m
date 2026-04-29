Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EF6214204
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 01:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777424916; cv=fail; b=GfoIz5V33QuxSLiO+T2Vw/pom9paOlZk01saYagvrR9Md0VadgQ1WAJMTLofI16+dq1+INmiKKjii2nyih0Ni4ql0TH9x/0OhDnCrRyIKuTFNP7NFihZg0JMRnlaGF9UASg2Lcyv+QIf+WXL7hCHI3ALfedUyZZyec8aCmnpS64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777424916; c=relaxed/simple;
	bh=k9nBp5GVEVZCxJ89/Vc4DNgzyxUN71nY0o+OTtynXk8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dkRvIqddoFh62FvogxJK1IFAtVjA5P5p07Ml+6WILcQLYLHZ75rpPB1gPx8DLHZUxdj3WhhbnxcyQTMbSpfQO/jhSozsMF9lU3jb0t6krckv/XsIomDhikpRvizqTbyssXErjvaX+br6AmKeknDsyQktnpj43lvK87Yv1LN20FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDnYvKVc; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDnYvKVc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777424915; x=1808960915;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k9nBp5GVEVZCxJ89/Vc4DNgzyxUN71nY0o+OTtynXk8=;
  b=UDnYvKVcSBWlUJDDestokJ26f2VAk4/EXPehNxyy3OIWLsj3fdvi9hsS
   kP8fyDTrIHzDBpI12AxrmKoTVTSL8anpIhxvXc/g945CivNbQRaM/OJB7
   dkXGYubneTynk1HBoi0U24lV+MCEXWxVkBRnP3r7dpROyteMm5UbviELR
   EWRND3AR4Q6unjvgUCigksmDQP3SwFZ/LwmgJsZDAUJ+Vzmz9gR6pg11a
   qdDno3vlFSXLUWUrJjh09MUZR4ZD1Ri/pFPuc0xNBgxZ09oyL8jaddsw/
   E0K+2uY6Krz9WRbBDsVx69TuQOrmuOfegCC9+vGbtBSeimV10PRkUilN7
   g==;
X-CSE-ConnectionGUID: 0wSjIdCWQGqUcAJmDtc/kA==
X-CSE-MsgGUID: UQwgN40XQpqPvbQYB5ksaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78266376"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="78266376"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 18:08:34 -0700
X-CSE-ConnectionGUID: EUKACxhsTrmSfGjVtf144w==
X-CSE-MsgGUID: MCfnvIZFSTSruh2DWgn5aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="257668593"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 18:08:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 18:08:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 18:08:33 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 18:08:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPCAAgXbI4cQoB2mHR/Mv+AcVmbl4B9oJ9jWGyXM1ck4QomqGc1L1Uw+1uuWMwsiKPobiFXfU4niQLnnJQD3P8dLuO8SwQGlCs/MPvTXMhwXFS8n1/aqQYZNj/IotdNgWdTpupRPXZtC2zB62l8QwOU8gGTakpDwz/O0Cad5U89e2x2T626wyH2h6AjIe4IwmAoqNVyyzAg2AO4jchiJyncsI2a4mKrvimeY7d3+M1YFiZIvOyH9AtnPUGuqqkEId0rdihgbpWJNra4539rBRy/R9bnwkRyxsHQISMojQEEHeJb8E2davdOOvbkUP5990EaLeamCT/iMyi0IYsb6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OT8K8onak4HRJWoOvo8TGwVpFIGk8y2cAVB+i9n3afU=;
 b=LL7H7gjWyuk/BHcOfe+3jR2OqBJ1so5dC6s8M7hDg9jbEUW/dr0SnviMRAGzWWRFhuC2yxHv7r/QZMbWojIQyDp1OLJmGVB8MqDUKAHGd6MSqhIc7IpTy8Ya2NF16/DKef4Kn1PZnnxSFvf665XtN8p9NoAlpNKryN/pe0N8DViQT+gUUdNoPA2+EhvtihpZaS+kPY2xVBvasSz+79/0UFTB/dtjEAXoAd7jHTkoM8z3qajMSuhfQLdHtNPlA1MNz8xSVnmCaHvhEeSTR5pp0QvVcT3il1g9sDif5ZnX7+wLsWuMuAwbbXI66j3d3oKDiX9Jf3T9kaH6SGvsGxkxSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 SN7PR11MB8264.namprd11.prod.outlook.com (2603:10b6:806:26c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 01:08:26 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%7]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 01:08:26 +0000
Message-ID: <0dacbe06-5b97-4dee-b8f2-a235b70448e2@intel.com>
Date: Wed, 29 Apr 2026 09:08:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: VMX: Fall back to IRR scan when PIR is empty despite
 PID.ON being set
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>, Jim Mattson
	<jmattson@google.com>, Gao Chao <chao.gao@intel.com>, Farrah Chen
	<farrah.chen@intel.com>
References: <20260428070349.1633238-1-chenyi.qiang@intel.com>
 <3235eb76-9b28-4000-920a-491659927e67@redhat.com>
 <04c954e6-a23a-4cc8-8bd3-5882a951a8cc@intel.com>
 <afDXUwq6pR7SgxIC@google.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <afDXUwq6pR7SgxIC@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|SN7PR11MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c809f5-0d33-4cc0-17bf-08dea58bd133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7klALzxoUj6uJaWMuxr/HIpNzytmJcAXW2tsoxXObUuJJRIrWACIrnihhOnfMMm47wUFyqdZHleFVB35xRecfeM/7rQLSWq9hjZkYakaH9NtePD5+jPj8fmgAB9zYkpJTD5ea1JOvczDfT6nfu77lYkLqmC1kAhyXUPsC6b7DgNudbhVgZNZ53FL5Q80VJsr09rsJtxHknga9Zn6y+OAfSHmfhNhRV7LiwVKT8crPRTJmGaSa5MTGfskPrb0PigZs67gQoehU/3myDSYGJ8UyF925LpP37/KR/BKt/l8KFPmNEXHpYQVyNGKneKKKfVhPzhIJ4OboZIbacL7/ja/S9NMl8xnb0NgKAiRFD51dZJUtUS0h05asis3IL6WgqFLShEZRfK1izjwYJT1HWCO80EHhqxhQOQhV8bgBE/T9ZBGWZngeZZoziDasDyoZ5jma/mHZn19Qeh3Q/e4guVjNVl08Tg2f/IV8y6g/9b5BdHLAh2xYBGSikY4kjUPOdyHt6yyTpYqiAnbPzyZADH3QKLNa1I/vSoUBwgcnVT2kiHKTgrlf4tXpe1+yFcHTSuDSbTvHbP9da5sWpPEkWQ53Fbvf+W22Yab8+8ryyUdluqrKMZDq9Ko40Pu28kBKDMhF0XhibTvyFrooTV9EoKLUUXnuPgx4liE9QCqPtm8KR8iS9PgM1aNmNh3JfDVLliA5b+yPKoa16t8zwvf0KXlQfMMf89piYFQqhP3YUIJl24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlRpWmk3dDdVTmRJWTZtenhjcWZqSjgybXZmdndkYzhxZEVxTUZlYU82Qlov?=
 =?utf-8?B?RkVEREpHNmcwWGNNMUFYYS9ZL1JaRkphWGt3TUFRanJOQlBpb0FwMWxZR0dC?=
 =?utf-8?B?Y2FYeGc4czNuYTAyNW9uS0E4T0xDc3p4OEJQL1VaTldkeEJ1V1c2R1lGa3VG?=
 =?utf-8?B?TWppZG1TN200SDkwd2VvNmxmTHJrYWRxV29yMnNHN2o5andHTmJzbk1tVkk1?=
 =?utf-8?B?L2svWWQxQlpGdWo1NmRydkZic0tkMVExSWdHVGs4b2dVeTB4cGM1cElpRDVI?=
 =?utf-8?B?SU03N2pYZU9tMUZmM2ZEVDhXYUs2akFQMy8yV1VnWjRCS0k0LzVFcHdBVGk1?=
 =?utf-8?B?Y2pTZW15MHZrb2UyQ2FxUFc2Z1V3K2JPZTJiQWVPeXJmSWFaeVZxR3lVZmZr?=
 =?utf-8?B?UDJneC9rRGl3YXFhbTNSZERHVSt1S0xmUmNPaDdZVW9UVWJSaGVzU3p5RStJ?=
 =?utf-8?B?RStPd2dHN014VlNrdE45eEVnUmlzNkJTRTdtSlVFOUIvYjNJZUZuSjhXSlIv?=
 =?utf-8?B?WWhySEFGejdVUWZWVVJFQWtBYzhLNUF4ZUR0K2FuQ2pWcDRSZ2dMcjROcFR0?=
 =?utf-8?B?eGplT3dKdE8yUlVYUE5waWc2Z2k0L1RXYmY2dXNjMk5ybHN6WXB1bEJ4ZXAx?=
 =?utf-8?B?Z2w5VlF6NTl2VDhpcURiWWFucDFta0tTb1IwWkpkanJiRkVweEVzUE50WTN6?=
 =?utf-8?B?NFdtYVVvQTJSN0Nsd3RobWJYZU5oTFJQRk04a09YcDBwZDZVOW5LVzBUN0xD?=
 =?utf-8?B?K1dtdE1sQ2dyVFR5Zi9kMUg1bGtvLzdJTkNDaFN6L2JOaDB6K3FXNlJ0eVpQ?=
 =?utf-8?B?eEh0UGtRUkV6NWo1NHVLNnF6bHc4NjhyeXhxeGVjSm0rVFpUOC9HeDlQakM1?=
 =?utf-8?B?RFBXK2N1LzdTSk9DRUpUU3lBckdsZ2pXTWc3VW44T0dWWS9PQjBHRUJ1a3RP?=
 =?utf-8?B?ZXZWeGhsL0F5L1V4OXFvUzU0VlA3bUlCdVl5QzBLUStIQWI3cUxURGRzalN3?=
 =?utf-8?B?ZjFPbmlaaGxUbXcyRitBNHluTUpyVGNkaWg2MEdkV2IySitsTXVSRlFTSnZE?=
 =?utf-8?B?T3FVcXlBK0dBZWIyK3RkeGhxZmtvWFNVUnhkT2ZNTFRSMTBOb0xMVCtqUUtY?=
 =?utf-8?B?a0tOMHB0cmpBb25pdll6YkhpVkRVc3VlK015TUVjK3MyTjgrS1ltakVvMzVt?=
 =?utf-8?B?UC9hMFpab3hLRDh4UDlCNGYrQllLVnUybk5DY1J3RWxoTi81L2VHZ3pMeFFs?=
 =?utf-8?B?U25oQW1TcEVBSDdvWmdISUU3TGl5bzdhVmdET2lTR2U2Q1hNdFJnWGJLT1lV?=
 =?utf-8?B?aHFYSmhvWklOS2lJbHpINktQNGdEODFwSWRycmc0dU1zTmtsL2ZsNzBQNVlo?=
 =?utf-8?B?TjNZVTBiNHdESVZ0bFNybXZvdFhPQ1VFYmt3V05PYXFERTN1eDdLUGN0Umt6?=
 =?utf-8?B?dFVxZlJOT3QzYzBhRG9mUHczQ3U3a2lVU2ltUU9LQkcvSGpQY2t5ZnJaTVAz?=
 =?utf-8?B?bGgvT0RTUE82d0RjT1NLT1h0cjNUUnJTbVY2OGxVWGM2dHI4SzVjOWpXVllR?=
 =?utf-8?B?OFhuL214Vk0rblRaOU1jOVY3YXA4cUtKWGFwUVBiQVU3UnJkYUVCT2l0U2FD?=
 =?utf-8?B?ZzVGVGMwWlFSdEdoVVR2S2NzZUhTaGZncnlacUxVbi9HbTZkY1g4WnJ1QTNi?=
 =?utf-8?B?djlhS1Q5WEZZNE82eUtUVy9LZ2U2bGg1UXg5RkZMTnlvVFliZkhMa2hYS2ho?=
 =?utf-8?B?SUxBRnNSS25rZ2VUMHhVaHVQNThybGRwQUdaNGtPY1A3ZzJjL0dsaEpvdjJE?=
 =?utf-8?B?STFqdjJtMVVWeWpWaFZXQ2dQREF1MldKMS81eG5IMzBvVTVyRGJhdzNZc25U?=
 =?utf-8?B?Wll6Qmw0Qk93eXBWeFROQ2J0alpzaEIyaVM5bVppc2M3VldOMFhnbCtmUW1y?=
 =?utf-8?B?R2ZXaDFld0xoSTNDQ0NoSUZsQXpOWklqSng4SUNnSlNycFRCN1dOL0psOE1n?=
 =?utf-8?B?Q21YYTBWTFVidHlGcXpoZGwxclZGOGdOYmNFOUVaUWk1ZFlhalp2bHAzM3Nn?=
 =?utf-8?B?TUc1OGZVU01RZXA4RzFuaFk0UTBEdUpOZ3kreVhobzd4VElFaC9nVkc1Uzhp?=
 =?utf-8?B?UVF6cEoxbGlCTlNYKzVpU0QrWENYUmVMRmQvOHNIcGxpdjJFb1lxbFFrVjc5?=
 =?utf-8?B?bXl1Ukhid01HNW9vRUV1YmtVeUpHaTRLdUx4cmh4Y2JhYVpEYXZSNTN4Qmlq?=
 =?utf-8?B?NHAxUGhpbTRuOXNON0NDYUlLNlpVeEI3L0hxTTZWTDdCSDVIQ0V6ZHRCeWxt?=
 =?utf-8?B?QmdzQmRwK0pWYlZkWnZiaVZCQ3RNMS81dWoreEVyM2xOSXNQeDF1UT09?=
X-Exchange-RoutingPolicyChecked: DTKBmwiNCnb3vvWPkKIen+9oi2vYEMLB0fKQ59lbRTv2txbF/Ilkj38gh67e/PpjMjh5HYuu2fvlfLwalZEE4ND1Tciicsh4rP1FOOWZgo84B+1rClswxl3S4MBBjoCIfKV9CvpBD/PgWNkU18b8ciK/luXWi3q46l+rIZD0A7n8ex0O2WjaD1JzqJrwN+ISaxM+SjG2hB5+4+hDHDEd5OH8ADRtZtXtcIAZVrLxT7rraK9VTDvLSKvqxZfCL8wV0UEemd4UMRzZXd75tGojcg+jTWgHyfEPfKKG6GIdCgWmDXR4BT6dNpW5zfc5l62cGhVYI/r1V1Mt7ihYDP5aMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c809f5-0d33-4cc0-17bf-08dea58bd133
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:08:26.5213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2xiMrzDQxq5Sw0fRxxwP4X9EsV6KgpcNwfqau/XMeGabTOiJ6Rt+YfQBC0r2Kx95BxM26eoX5MP19Ybpf5Org==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8264
X-OriginatorOrg: intel.com



On 4/28/2026 11:50 PM, Sean Christopherson wrote:
> On Tue, Apr 28, 2026, Chenyi Qiang wrote:
>> On 4/28/2026 3:45 PM, Paolo Bonzini wrote:
>>> On 4/28/26 09:03, Chenyi Qiang wrote:
>>>> The interrupt is not lost (it resides in the IRR from the first sync and
>>>> is recovered on the next vcpu_enter_guest() iteration), but the incorrect
>>>> max_irr causes a spurious WARNING and a wasted L2 VM-Enter/VM-Exit cycle.
>>>>
>>>> Fixes: b41f8638b9d3 ("KVM: VMX: Isolate pure loads from atomic XCHG when processing PIR")
> 
> Cc: stable@vger.kernel.org
> 
>>>> Reported-by: Farrah Chen <farrah.chen@intel.com>
>>>> Assisted-by: GitHub Copilot:Claude Opus 4.6
>>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>>
>>>> ---
>>>> There is a WARNING call trace during a nested VM stress test.
> 
> Any chance the stress test is something that can be shared?  I've seen this WARN
> 2-3 times over the last year, but it was never reproducible, and so intermittent
> that I couldn't even correlate what I was doing at the time with the WARN.

It's not something special. The stress test is only to create and tear down 20 nested VM instance in a cycle.
It often takes more than 20 cycles to reproduce this issue.

