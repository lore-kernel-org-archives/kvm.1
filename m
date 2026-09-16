Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB43038A73C;
	Wed, 16 Sep 2026 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521661; cv=fail; b=bF0kJjAqiC5/+LNU8JaLLLlTnf+uH9YCLRDNAZ7ccERw/odp+jpByI1ZD+DJBCRCe3/aAzMd/MGUV8ala1jhHYA5wEu21xrBjhvZZK6Fi1AUyczYYlweJ6typJQmPee/PDxLAdg3vJIt6yXIi543ii2FYT3uJBfl7R00iPCLI/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521661; c=relaxed/simple;
	bh=9rPZ+ac981g0iiSxnVw0SAzunZe3y/qEb2hw9dCTFn0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R7/dbumYe/aFdVjGlo0LtUuCg1i984PWnoJbE52DIn8/ZqRLHDXL3h+vd4qViHy+b4xoGtzmYTDyUne7xHZs7+7HO0sPil6OrvcJ/5diL1en2fhn+XI7Y1ip44IXAmFl/qeQqAHo79FO1NjCoUCjtgLNk29WLKAuwpoIvJQAaS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PjByIE6I; arc=fail smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PjByIE6I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789521660; x=1821057660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9rPZ+ac981g0iiSxnVw0SAzunZe3y/qEb2hw9dCTFn0=;
  b=PjByIE6IR/AjA4PiTlJ3L7ecW+5MCD3Co/4lIpbk5/bQNh7uO5t57swJ
   TehIpg4DYiJxMtJkiC97snpardCTEPcAIBBcVD/3rl+ayIKrBX4zYe0iL
   YPnmYxcTYCBY7l1MIqAjeN2E56avdbEA0dw5IxbDGAJu8Gt1PyImajUEV
   PA6oamyvGeDcHMbfny5ioGMP0EiW2Z8hhFlGocvUUbgWXfsXtImv3q7I6
   b/H3UVeJyGiUxTzzT6KEz12up3n305AJ3H09CdHyOLCNs6ZUcv9lTLJ+b
   cdQcj444W/lZL+FJHDIF1Po5lHo8r4BfQu9iJD40CJkdIcHQgrEpV/4o1
   A==;
X-CSE-ConnectionGUID: c5hkPWabROKcosXfecqc5Q==
X-CSE-MsgGUID: DQlKROtySqKwSQdLvMBvcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="405507"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="405507"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:20:59 -0700
X-CSE-ConnectionGUID: JwuVtK3yRqS0P382uL5Wqw==
X-CSE-MsgGUID: azHTYxq4TeybgwfF0pq/DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271736730"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:20:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:20:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 18:20:58 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:20:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHaH8n5nKH5LeQiS3CZvNBmeeFVvhGZATa7udwMLXJMkAtz02cpxbqlSFi0pMHhTzY0BYlKCY6OtM5HXhHG6/LFqiGcSsFAWha3VIkQ8gVJHzOmhOdZ+Ln+ocQ7EHfGF2z4IWr7PJBy2GVHFzy5+ZPZvEjpdUrAUXQLCLHAXkNzqicBvTD+OlkIm3tLWl4LEmvy9IibXZdrL+7m6KpfAdZJYT7ZBkBigcTKKzEvWqofcM5qeeMFsYl0i88DA5UFCXLp7BTpWHCjzoeQ7Hy8WUKEinVVJpcHL1yWE4mB6ITtgjrMky5Pf7KAg61Uf6tTabTS/o6S0q4BX3y6OIkAmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rPZ+ac981g0iiSxnVw0SAzunZe3y/qEb2hw9dCTFn0=;
 b=Gi/KIPD0YuZTpm/1eBvWIO2CCn7xRY60tpMKso+SxN2dG+pYX/mppny1YXxHIE//ENfIpv233KqAbAwnDGhHCjqwIpG7/wZWSeb4okqUc4uPj8FBBnbSSxtXIIKlg6TdgQqA2H1oOlMOdX8JdK5+JNUjrl7xyKPFw8axvP3AYOM8q/qw8b6+BA7DdOKr8siDNI3NEEZqRE3VChyszlO63ghMEIvuJ2gRdEsWxfTgFwXV7MsWAp2qtTn4PXdOdCAHIdrEKbsgGeFxBTvhZoOuG8NeCXS0pwW7jssL/SRFgk7u/TQSt6CNGhSOGY5D5Wc7HJdF9z80LzuPYCSOX7vr+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DM6PR11MB4515.namprd11.prod.outlook.com (2603:10b6:5:2a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 01:20:49 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 01:20:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Fang, Peter" <peter.fang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v4 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Topic: [PATCH v4 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Index: AQHdRPRpGgpLmgOIuUaxLUBjd8KBF7bPrRqAgAAiuoCAAHNLAIAAEVaAgAAH8ICAAACcAIAAA8KAgAAIiIA=
Date: Wed, 16 Sep 2026 01:20:47 +0000
Message-ID: <05c7abb9204eb27a0331206c2ea804134aab9921.camel@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
	 <aqlRETiO58SWjFLF@google.com>
	 <96c33d465635c1858b943960f09ebd3bf82d31f1.camel@intel.com>
	 <aqnO6spgsfN1UsMU@intel.com>
	 <d071ce6cbb86cffba21ab7b078c3bd0c18fafd84.camel@intel.com>
	 <aqnkHUg3o890LYFM@intel.com>
	 <b32cd186709b93a02495a1efcb347f8f9533b510.camel@intel.com>
	 <aqnnx3aNjeDzobaq@intel.com>
In-Reply-To: <aqnnx3aNjeDzobaq@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DM6PR11MB4515:EE_
x-ms-office365-filtering-correlation-id: 91bd7c4d-0759-4738-5add-08df1390bd36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|38070700021|56012099006|11063799006|5023799004|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 59hIHdYLKJofF/Ex+AAC+PzRlYv2rliTGGhAGklgW11JwM+4wfRByP3GCwd96BOTtvNMQ+Bi1evC2Kf9tALNBlft5d5hRYTAoFfinFVD9c1VRUHfiQSi+EA9PJmNtiPf35dcyiahsmddssdTwvIsY7Hoj6KDCkIlCoZ8bI4Zt/8lbSosriV/Wo2gqQgJ1FIouTZxB27X6pWkE5nHn1OxheH3yuwuLeyz6+C2YA5bCMs3zTgaV5VnuQVOyp4c1fWZqwwec6FMLLv+gjifFblvLf2FXJLS5vYokpMTKH4CqRduwymzFiVCBKqZjBLWsOij+C7hUYf/D1axjbkwuntmP5uy+f7Bq8vEe7/Y1xv1hW3vEfx2nFoyYri/ixkUTP/hk6VzDGPZyhOKmzXr3cCLJBB3mV60y2yOre7qIusrjcer49mdAI59BiK7G51oDygImnBWnZ9PoUnQUlYLJVjO+MMceUkOXEaUaHqXHS/6Vp5FwX/rb5QhRo10zDpG+rhwJj2MMh7uY3eKMfkg6K2m4e+fVNZS66zl3rDdsjyio9Tr9t/hHLO1sdKY558/MShA8F1CXEgqhXhchjJzlrAjUEoiAK0n0wsKLmfWw+YMgwWIooJ6mSXX/6wUhvjtORlM69Svv2eDdLVVaJwVsV9ljyJ1u930RaJvf2l89F1fHlS4wQIjtktgXlP3VfE2WWp8W91lDoqb46zvt4X+EKAaWJW+L3WznOMOcGLpsRjs6dM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(5023799004)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFdVam1ua01PM0ZDMGJkQS9VY0cvTjhlZjRuV2t5eENmdGxSeUt2NVcxMDBa?=
 =?utf-8?B?SFQ4UFdTejRBejQvKzA0L0tXS0FFOFduWnR3V0luTGVyMldlZGdydmlXeVlH?=
 =?utf-8?B?YjRGd1lmK1VYWkdHSTRnbWVCSG9BSXZqNE55Vkl2Zm5pYlh4c2s2S3hKVldx?=
 =?utf-8?B?RVRDV2tTcTQwZHJsVTljeENqOGVMR0l1NkZ4Nm5FVlNGeTdpKzJLc3I3Z2xu?=
 =?utf-8?B?eU1Ga0M1VGNmMXUva3J6VU9QekJlcTAwRnZwNURBREdkY0U0MEJuTkJsZ0w5?=
 =?utf-8?B?ais1bjBOQWorOW9vSU9ONHVuT2hQQytpNndpU2daOURaTm05YUZVOE9VSFVF?=
 =?utf-8?B?K1ROUDRMSko5THNCMStmSGtQbERSakZIRVF1bnZPTFhXYUR1VTVjdHpOMjFE?=
 =?utf-8?B?RVFFdWNLN1E3c3hkQ0tiUW02ZzhnVTNBcnRQSEU2ejcwcitIQ0xlbWh5dmNx?=
 =?utf-8?B?WkRtYTNnQkNKeGQwU0tUalVCcnRDQ2JTSVY3aUlpZEd1OXF3RmY1U0JBSTZo?=
 =?utf-8?B?d2VSZVFPSFJNZlVESEpzbTZCT3B0OXVLQjRxY0dqZjNmVXRzWTdaRDA5UUhu?=
 =?utf-8?B?dzIxTHltejZGTU5Fd3VmdkxpV2pxYTZNNUpVNnd4ZjBjWjgwSUFzZkVjbEJy?=
 =?utf-8?B?V2RnVjVLUkFwTnY0WEZiWFR5djVha3AyWXpUQW15SGRDbzRhTHU2bVg3YWpY?=
 =?utf-8?B?eGE2cHlMTzRia0JLaVdpb3BRNExxRzRSenUvZWFUWW5XckYvUTBOYUxTM1RZ?=
 =?utf-8?B?V0xZbmF1YzRualBacmNhRTZCNFZURVRxTmZaTlR5OXI2WVpGTytWVFloNTFR?=
 =?utf-8?B?SDFKZzN3VE9WTVFpRCtiSXBLMkJuNWVGcHp2MC9rSktEcGlVOG93NWc5ajlj?=
 =?utf-8?B?UldBaWJsMXl3Z1M4QzYxNWU5OTRlVFpBMWVtSU4xM21xR0RQbW9IMWkwaEVl?=
 =?utf-8?B?cnRESHVCamVpVDgrUHVRa21KeDVuNmVWc1V2WWpQeHhBaUZQVDhIVThQODU5?=
 =?utf-8?B?Y1pxVG00aEZiUlhRV01kdnc1YVVZRSt4RWpEcWpobi91QW82czg0WXFGdEw2?=
 =?utf-8?B?aXc1M05VNXk3R1c5bFU1UUdnZ3ppM1ZManNhTVhpSUVMUjl3R2tRSFhLcDZ4?=
 =?utf-8?B?cmtBeGxzRGVZYVMxanlKaktaZmlabGxweUFNVDg3RUgwcFFFV1U5akcxb1Na?=
 =?utf-8?B?bHlBZjVkY0JMdTk0djY1NjNwZURhYk1rSEZ0RExOMGNEMUZOdGlYNkhKZmJ1?=
 =?utf-8?B?MGpSZWl0cFZBc3BPczJCbkJUT21tNTZZamtVYmVFUHpUWnFLTlAyUGRWcno5?=
 =?utf-8?B?VU4wYlZ1M3U1cFRhYU5pY1Zud1hTeWxkWEUwd3dzSko2a20waHRuMnFEc1ZK?=
 =?utf-8?B?a045TGIyTmg2MU9tN2h2NTcvTThMcXJyWStaUEc3VklQWWVCNUFlbXF4RDM0?=
 =?utf-8?B?bTNSZzZsSUlzM3FSNFVLbTMrTldpQ1hjVzhJc2JzVGFMemJyWmFkelBvSVF2?=
 =?utf-8?B?V3hkU3pxd1VuZU4wNXZjK01GUllrMTBENDNWdFlxOHl4c3lWSjNTcWRMc2ty?=
 =?utf-8?B?Mk9Zd0tKUHZjMjF2b3Z1RDZVdTQ1LzhDTzdiRTlkYTdSd0FqUy83S2RFTmZP?=
 =?utf-8?B?TzdmRXNLOW1QblM0cElOd1pucENnRFpKZmlYWDduTzFXYlpyUGV1ZXdidGd1?=
 =?utf-8?B?dHB4RVBYUTVOdU9PT0JUbldSNGFtNkMrZTBNSjRIY2dtdEFXTzJPZTZISEh6?=
 =?utf-8?B?c0dVd1I0cXQwOE81Mm93MkIxYThTaDkyL3RaMG5JUkEvS09oSUxDRjBMU0VR?=
 =?utf-8?B?UnBiNW41U2dYbHlONVdnS0hKc2RkQSsyZlJ3WFNCd2gwQ0JGZGs4NlJJYVlk?=
 =?utf-8?B?L1BHTXZhaHBuNjNpeWJ2Wk1oVGRPbHRXNXpCVytSOUZiM0ZUbFQrcWR4T3Fs?=
 =?utf-8?B?a2tBQi8zNVFiMG1YcCt4WmprMVVXelUrSVRyWmhadTUxYlFCbGpzaUdEbDIw?=
 =?utf-8?B?bkFRVVpEdml0eXNJV2RqTUx1WE5UZVNYN2x6c1RBRUxWOHd0ZEo2aEhGMnNP?=
 =?utf-8?B?MHJXM3JTWnlNMkRXL0U1ZVBNc0RZTDIwR3B1bHNIalJqWlZ2bC9tclNGamlS?=
 =?utf-8?B?a3dVa1htOXdiSkFuNTdLNnE4L29hWXAwUHF3WngyUmoxMWhPT2tSbGxUUEor?=
 =?utf-8?B?RzRrMzFwenpIVFA3K3dPZ1JoU3ZFM25LMHJwU3B5QVhPbm5DWnFRRmQ5aXJT?=
 =?utf-8?B?bWpxNC9PS3ZWbS9XcUExNGFHQUI0V05pajR0SzBBZ2ljL2ZZLytCQTBHV05N?=
 =?utf-8?B?OFo0M3F5cjJzY1VhQkJ2bktHZ0JjcXlhRUZKRDc0SGtqVTVIeGNvNGREUmVC?=
 =?utf-8?Q?spQSbz5VmTSUckf0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91624536F9B04E42A91A7CFDC13CF29B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TLhLaEQyGKmbnnLWlcF7/4Rs3Q+6WIn4g5dqp9QtF11WOh2L4KlbXVCYY/sDzMybbp++wXwSzzJ6ZoG3Br8YjGAfnHDVQgf+1D68ayYUAIaZ51rRGnye2ZYMpymHkK6VtUroRuUBeI1EOUGuMnu69aWAX9JekbY6jRgqgRYMKAkFcC+k4Ir5HmDtopUw/7vdPIJqqMKztQ8rv0xQwTJYemZR6wCKvkTV40BndBl8S2N0Z679FNT2GQkNBgmyPvo9vXkjCCXsMjukNr7oaMoG9wplx7iXfn+uhOPN8l79SGnIYSnUjNgb7e0JV9/WQyAuCTbie3qN33NaOChldQP7NQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bd7c4d-0759-4738-5add-08df1390bd36
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 01:20:47.9972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCzqV6ZR4onMg4ukG6NDZUD3sE96w5QyjtRMBkRzBN6a330qh9L6smUCeY5SN0cVKHZSw23GaTHoQppJ8yFsUU0qut1NItz/aX5vKQ57zbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4515
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDE3OjUwIC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiBP
biBUdWUsIFNlcCAxNSwgMjAyNiBhdCAwNTozNjo0OVBNIC0wNzAwLCBFZGdlY29tYmUsIFJpY2sg
UCB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjYtMDktMTUgYXQgMTc6MzQgLTA3MDAsIFBldGVyIEZh
bmcgd3JvdGU6DQo+ID4gPiA+IElzIGl0IGFsbCBjb3JyZWN0Pw0KPiA+ID4gDQo+ID4gPiBZZXMu
IElmIGEgbmV3IFREWCBtb2R1bGUgZGVjaWRlcyB0byByZXBvcnQgdGhpcyBmaWVsZCBvbiBhIG5v
bi1ESUNFDQo+ID4gPiBwbGF0Zm9ybSwgdGhpcyBjb2RlIHN0aWxsIHdvcmtzIFsxXS4NCj4gPiAN
Cj4gPiBTbyB0aGUgcmVhbCBzY2VuYXJpbyBpcyBURFggb24gYSBESUNFIHBsYXRmb3JtLCB3aGls
ZSB1c2luZyBsZWdhY3kgU0dYIGJhc2VkDQo+ID4gYXR0ZXN0YXRpb24/DQo+IA0KPiBZZXMgdGhh
dCBpcyB0aGUgcmVhbCBzY2VuYXJpbyBhbmQgdGhpcyBzZXJpZXMgc3VwcG9ydHMgaXQuIFJlcG9y
dGluZw0KPiB0aGlzIGZpZWxkIG9uIGEgbm9uLURJQ0UgcGxhdGZvcm0gaXMganVzdCBhIHRoZW9y
eSBhdCB0aGlzIHBvaW50Lg0KPiANCj4gVGhpcyBpcyBwcm9iYWJseSBwcmV0dHkgb2J2aW91cy4u
LiBUaGlzIHNlcmllcyBzdGlsbCBvbmx5IHVzZXMgdGhlDQo+IEdldFF1b3RlIEdIQ0kgZm9yIHF1
b3RpbmcsIHNvIHRoZXJlIGlzIG5vIG90aGVyIGZ1dHVyZSBESUNFIGVuYWJsaW5nIGluDQo+IGl0
Lg0KDQpTbyB0aGlzIHNlcmllcyBoYXMgYSBzbWFsbCBiZW5lZml0IG91dHNpZGUgb2YgRElDRS4g
QnV0IHdlIGtub3cgRElDRSBiYXNlZA0KcXVvdGVzIChob3dldmVyIHRoZXkgZ2V0IHRvIHRoZSBU
RCkgYXJlIGdvaW5nIHRvIGJlIGJpZy4gU28gdGhpcyBjb2RlIHdpbGwNCmV2ZW50dWFsbHkgcHJv
YmFibHkgaGVscCBESUNFIGluIHNvbWUgZm9ybS4NCg0KU28gdG8gc2F5IHRoaXMgaGFzIG5vdGhp
bmcgdG8gZG8gd2l0aCBESUNFIGlzIG5vdCBxdWl0ZSB0cnVlLiBUaGUgcXVlcnlpbmcgb2YNCnRo
ZSBzaXplIHdpbGwgYWxtb3N0IGNlcnRhaW5seSBnZXQgcmUtdXNlZCBmb3IgdGhlIGV2ZW50dWFs
IERJQ0UgZGVzaWduLg0KDQpJIHRoaW5rIHdlIHNob3VsZCBwcm9jZWVkIHdpdGggaXQgbm93IHN0
aWxsLiBBbnkgdGltZSB3ZSBoYXZlIGFuIG9wcG9ydHVuaXR5IHRvDQpicmVhayB1cCBURFggc2Vy
aWVzIGludG8gc21hbGxlciBzZXRzIHRoYXQgZG8gc29tZXRoaW5nIHVzZWZ1bCwgaXQgaXMgZ29v
ZC4gQW5kDQppZiB0aGUgZW50aXJlIHRoaW5nIG9ubHkgaGVscHMgdGhlIHJhcmUgU0dYIHVzZXIg
aW4gaXQncyBjdXJyZW50IGZvcm0gYmVjYXVzZQ0KRElDRSBnb2VzIGluIGFuIHVuZm9yZXNlZWFi
bGUgZGlyZWN0aW9uLiBJdCdzIG5vdCBhIGRpc2FzdGVyLg0K
