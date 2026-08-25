Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A5333D4EC;
	Tue, 25 Aug 2026 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681954; cv=fail; b=gyDwqBo3BfmVxiT7bIzslnazYPTCCB/iRNwRtuxVbfGaaQr/lms884K3zT8VV3FujGifb88rEiCKxKGf1bxJ9lEyN4Egy5kWwN/DJrUKkIBsJ8UGQLXYdpz5OizE+0VVjt5ZWvqK/sSATFYOVA+ZHzi7MwCk9+Gk6vemhVdbWms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681954; c=relaxed/simple;
	bh=tSy4A/hREbEsw/kwxmcZZOE9DGiLqRwcVDEeUtwywNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fP88QJBYctpQ5FjoplDpN/jopmscRrtJwgiLBAoVm6ISo7pHErw6Yxu/tJ2gi0nLI9CNVtF3L9tIswi7mEUZ7jf6l7RBvCZ4V+7yPTDGoIx+L9BglNoMloC2lulXZ2Meqeym/EIUy4BmFzDnOiomFM3XeLbpglXUwcRkPCgmRfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V19JInH4; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V19JInH4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787681952; x=1819217952;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tSy4A/hREbEsw/kwxmcZZOE9DGiLqRwcVDEeUtwywNA=;
  b=V19JInH4Y7taATaKqQbzJ6/2dzhODM4Jy2WHJ5d2p6G3KtT6DC+bLmUB
   mR1QRv5bdZ0DgwwdS/WKr/1bflb871FeW4pdUlMwO1gg5jfWAtJkni1fm
   PFUgXtN4eCoioUKGy5+o6Dp+sRYAzW5CqrVyKcdfKmS/T5BFpJrMi2CV3
   4TosdrTuQZ5tF58s0Y9/peM4oPzEe7VjbYggdz9YnhHhKcpSwShfKqgPk
   M2+LBmi73PJvdNG6FTzPkez6I82JfJ6288KIuVC8edK+gIrIE/9HQUKnF
   1NCjh4dJMBgL64aYkbCVUzmemqfIT1ZRD3dGdeM19R5sdqHzGSewwlqKD
   g==;
X-CSE-ConnectionGUID: 8sqHjcy+T0mehqIlMHjzew==
X-CSE-MsgGUID: lNT1ClIPSlWrfBq/sQc0rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88185813"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="88185813"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 11:19:12 -0700
X-CSE-ConnectionGUID: DI5n1c1pTomHbcAXVKaRIA==
X-CSE-MsgGUID: NaHvU9HLSqK4kZYhSiueLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="263060115"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 11:19:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 11:19:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 11:19:11 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 11:19:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqC/iMSfwUjBhqkGGV3yl3MNSYnD4xwTgek+SE58Fh+fcc59w4ifnI/lZhFNCjH3acDrqYspQPEuPkP8szl7qGhlNxe7baI4DwxnrByFmlDLo54o124MT0OFHVUmy2b97Ld30CKu6K4QHJRxu320A5l/a/Ou9FOORps/Tsj4oAdYUdGTlGnudAkVdf35QV0BAysiK+DlFJ46jdr4nzGEEf6zAzwNxyRzTxJpBkdsbZ1xY7ylr+8KN+nrOkjO35NTWUTV/67Rq6iVcrwPj6SqO3gtecX+OOz/SUjxmqWxSdZhuZyrAM+TnuQdUkBkH/IuHyxUVlxyPNlGfrxYq+/vVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSy4A/hREbEsw/kwxmcZZOE9DGiLqRwcVDEeUtwywNA=;
 b=tt9o7XbTNdRJP1RIv3LR1XHoyri+q4av7vC0hBO+29SUyVuRggI+3xOKlB6XL/vBCQBjMSwU2rO2ECDLAdyTF+K2gAV8E0SmlGuDXQvAtQwMHR8zqO36sB50Y8sEmOHYVlF7vgA8Izumlnqn1R26LWM+kZUB6phzOvnBpJe4LVPRzaeW+xkN87LInt2J3FB9xVT9jFxpnJ4W6TuKo97Qjnqy5r52tVvxIOJFG27FmeFVZUGP6bww/8S+zEtLwloOwdOgyV3bRowHNdlYaiVcx9qDB12qTTxL0mYPvYZm6h82dnWEec0XQ9lGzQ1jiOaSf0osT42pGs69nPRpJ94o5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by LV2PR11MB9538.namprd11.prod.outlook.com (2603:10b6:408:378::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 18:19:07 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 18:19:07 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Annapurve, Vishal" <vannapurve@google.com>,
	"sagis@google.com" <sagis@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"tglx@kernel.org" <tglx@kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/virt/tdx: Warn on !4K level in tdh_mem_page_aug()
Thread-Topic: [PATCH] x86/virt/tdx: Warn on !4K level in tdh_mem_page_aug()
Thread-Index: AQHdND1FpRR2p2rutEOa7iAk6ZY7/ravAlCAgAAJI4CAAAiAAA==
Date: Tue, 25 Aug 2026 18:19:07 +0000
Message-ID: <798c232956a8808e59bcce5b57e90c9d994719a1.camel@intel.com>
References: <20260825025533.25663-1-yan.y.zhao@intel.com>
	 <1f12e12f1d5e7baed6630fd15cea5420c40ada68.camel@intel.com>
	 <ao3VebUyMVlK_qGA@google.com>
In-Reply-To: <ao3VebUyMVlK_qGA@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|LV2PR11MB9538:EE_
x-ms-office365-filtering-correlation-id: 7224411a-6657-4815-ff4d-08df02d55a5c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|38070700021|10067099003|4143699003|5023799004|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: spqN716zyQoW482inp1vAw9aEk3nwagQVfDPHTfpqvfVA6LU84TC1MXQX1a/ND3PmGa1B/MZEd4D+I/SkffwsNhsHBK/wngiUB6qb05nTLH7VdPcx8m98fDORjI94QIrasYRmbAw8TQrqVXTav/VKWN4Ddjl6QokJdVdidUE6nJQEHIQNvs71qbpQotPZ8wBgREZPzj7q/qVczvgwWWbHgVrQT8dpM0D8Eqet//bdprysrldWLXXofL0tf38iTOLXIocRwLFPl/ymtpJPfQzyRH1l7qkhu7RH9Ht6d+kvpo2a/ojkHJp54mbPJyZtAhsOaSSiLg3ESIw3DksMzjzN5b1ceiID2ATAITjdAB0R9vW14avlUV+bPwpAukOPC90MZl3FIhKfH8sNG94Fm8X4sy7skTtb0+yqwXqGP4LzrxsEtZU5NsSf6Y57R239D4aR+psDd/hYxzidxQK2qg0yRdZZGa7Ip1rYuis5k0gsvt2zIRpS8wSuczLAQL0sfHonQ59t6UHbIoeF9QiUnLMUGbNscQTrRnF7MwKXpQOF7I1WEu9ea2Nnaqc01mVYKzWJCdaBTiypas0Vs6ZfpLGoTILuPdB3g2jHlgwREfpE6lct1bcANrrs+E0317NDm9SEcFoP/tRiIIE3CWsp3XjPvg8kDSQBDSxlazkft/fwPDsvmIPBezWSY7sM5EyvXXTEKt4PkGGZxBnqQygIc/8gOyTCItp1sXwCYW35OYd58I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0pDTE1HM2hSR3FDMXpwVzdmYVdKYXFkSktaRHB3Q0lwYThnVndwSjlubEtR?=
 =?utf-8?B?ZUNsYnA0eVlEK2djR21QUEM0U1gwTEkvS3kzR1I1WVF1a09KZTlzeTY5OGdR?=
 =?utf-8?B?K2pnaCtWVDduQVJ1cktMa0RMNmgwUmNpKzlDNE5VMG5DWDQ1YVN3dHFHZGRJ?=
 =?utf-8?B?KzJoK1IvQ3h2a2Jpc2hPanIrSmVlcFY5MXp3eFFxeHliR282S3d2Q1c5Q0wz?=
 =?utf-8?B?cUJKY2dTQzF1K2IxMlJyalEySEt1NVQxaHA1bG1FTEMvYjlUMStUMGtXRGpV?=
 =?utf-8?B?YW5oVGpFZXJEdFZvZm1YajQvaWc5cGppTE1MdXVrSXlSTGFrckFWNGh6ZTdL?=
 =?utf-8?B?Nlk1Nlg3OXNtbEVZV0JYbTZDZ2dON0hOaDhoRGNoRU9KaVROaXJ2Yy9WUW9m?=
 =?utf-8?B?UjV5emw0Wi9sMWFGUkVIU0Vla01pc3NPcmxJRjcvOVhaYXZGTldlclFiVlJP?=
 =?utf-8?B?SHl4Y29DcmNzODZ1YW82RWVvNDBrUzFxcTIrSWlwWWRYNDc1cnd5VHRWbmRv?=
 =?utf-8?B?NGNJL2dmTGx0cWc0b3VpbUNWSURYcEorQlVDZUc5bzFjZWtkVWhxR1BiOUhi?=
 =?utf-8?B?SVZ6QnEyeGI5OUVWRk9wTXF4eUZqQjZBMnZPUWpHbGZ0c0lzM1VDUmtmR09w?=
 =?utf-8?B?b09odGI4SVc1UlNxR3dac1N5YWJwMHVndHZycFA3cWZJNVNXYlpldjB6ZFRN?=
 =?utf-8?B?RnE2U1BFUTE3Mkk0Qi9CZjYxSTZrUGVKQXc0NVEwb3lUeUhDa3JDaFJmYVBP?=
 =?utf-8?B?bFZ5anRxZEgrdXBGdk1WSzBZdDFMMW9hV1ZBYUw3QVpHKzdSUmQ4R0JLQTNM?=
 =?utf-8?B?K1NPYmQ2em9jNnE0eUlrQWlxMVVPTUg3Z1NtODFQU0p1ckhIUHBNS2Y0alFF?=
 =?utf-8?B?QkFsRFgrQXE0bTd5QStza0xoU2JlUVdndG1qZTVSQ2o0R0p5cDBRYzE2SVcr?=
 =?utf-8?B?Wk9YZzk0azRkVkV1QkRheEd3TzljQWRBeXJ2eG04aWxpK2U2R1VoeXNWOWh4?=
 =?utf-8?B?c3lxQmp2MXhBOHpQekpYTGswdGd3U0RiREpzY2VIZ1VIUWRZTG9PTHZDWkxZ?=
 =?utf-8?B?Y0tma0R0ZXhWck1tTC9uM1hjZCtSYlNXNGU3OGlBSjJtL2M2WmRZc2ZDSWx1?=
 =?utf-8?B?bzIyei83KzhKeVN4SFJQM0FPcDR3dzM3R0JxRGdlc04rMnB3ZkpUYWI1S2E0?=
 =?utf-8?B?SGtMUVB6K1V6Ly9kcHVZbnZIcWMzYlVnVmJ1QVNrMy91ajFrTzVEb0dEYVBy?=
 =?utf-8?B?STI4VGRneW80TUF6US8vWVZOaHJDVDQ4cjJLYkh6cXA2clZpbk5QVnVib0kv?=
 =?utf-8?B?QWZ0MFUwWHpXNThWOGJ2RDErWWJrNnB4Um9TSlE1c1h4Nm9Fang4SlZ3M0x3?=
 =?utf-8?B?ajNjWnJvRTJMMnZQQk8vRkpGZktYRlNNMEFGSjQySkdDOWZINENENlg2cTl6?=
 =?utf-8?B?TUhTOXZGUTQvd2xqWis0WWJIVCtsd3cyS2dCbXBUVG5uQnVlTEtmV3MrblNl?=
 =?utf-8?B?d1FjYTFZNElyenoxN2Z3WVBjdVBPYXJLc09DUzRhRUFhMUJQcktHenRCcjd0?=
 =?utf-8?B?anh1QTFnUWlDSGM0YVB5U3cwQi8rTHd0d0pxZGx0dVh0bDJENGVwTkMrOEpl?=
 =?utf-8?B?aXRHalZDUTNpc1pnRURlbUtZc1pjL1Bpa0ZPUVFyaUlpU201Qjg3SVJJSlZx?=
 =?utf-8?B?UHRaRW9LOEJ5ZDZWNUhnWklPdHBuZlZ5UkdXTnBQK0pacy9WMnphMkhEZDJ3?=
 =?utf-8?B?L2VVZ1ZMWHg1TkJGUGJHY1FkOWlqVTU1U3lockYxakRIWHJEZmt6M05ha0pp?=
 =?utf-8?B?SzREN2xZcmMxS3RvUlVyN3Uxd0NmT0psaWw3Y2pBbDNpaEc3cW5FYzk1Rzgx?=
 =?utf-8?B?eE1QbXhBdWF1dXkyRHhjcGdKaElPdHFmTkhWeDVxL0sxYi84L0ZpUFdhajVE?=
 =?utf-8?B?dS9vY0N3ZDhiMStpTzRSWER6K3VLT21PY0xhTjJteEpDWlgvL25VQjRrcndy?=
 =?utf-8?B?Z2llYTZXcXZHL21LRXVIUEZoa0hGL1JzSU9QRU9ySnZESjgwUzdjaW96WXBN?=
 =?utf-8?B?ZlkvbmlpVVpZb0Q4bDBlNW1wci90L0szRjJ3cWNwQ1V4Z3hFREJBdnBURlBa?=
 =?utf-8?B?NkhTUUJGcllxMzFieUIzTGxJN09ORk5WbWttWU9PdmtpZzVuQXQzN2MvQmlD?=
 =?utf-8?B?V1JlUW83UjJDT3dMZlJYMGgvUFRrdkpLdlFtVDg5UVE4dVd6ekg0OFhYckhG?=
 =?utf-8?B?eGNrQUtEc2VydXdSSEhlaHhPNEx3S1BwNlJlc1h6eHNoYWdXUndZb3VpWDl5?=
 =?utf-8?B?V3g1c09JWi9xU0QzeUt4cU1PVnFVWi9MeGtMZkFjWGY3cmVRNmQ5Ly9pSlZ3?=
 =?utf-8?Q?vaKUrnmEbN897j0Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DD5D882651D0048BED02CEBCCE8A79E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tG7AoUbDphGNghYX3TTBGfMSFWS+aQX4ptlGgJdJETxOL5HnkFgcmX3tZtqBIaWpbiTtoz+hGxHx1OX3EXn/n8AD8b/Q9c/nYqJDHz1T/V0QUfVGObZ2Xu7BJAjARHYJ6O3wGCppZgaOOhc20R/dsSmy9SqmJOHJcwPRbLZZn8nVpyraN+k58+AtQglhdy0kS7KM+hm924KkV4VZF/qH43RN/1GZ4j0GYRc3aPxqifjKM9LtRarATHQDYmtSEUWx3uIkTMUdM2FeitFJFeQQyKBVouXjRLbnebT+FFOFDcTjXAgfZ1VfYoymvxFAqfgnNQTX0wE8+dmAyB2Jx+Avfw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7224411a-6657-4815-ff4d-08df02d55a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 18:19:07.6715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1slawfKR0C8oOaU1yNyZN+3JcE2lxaR1Iu0+TioRS9VcKOdCQ+hS6jN/290kpGXjYVGgUTms87yzw2GnH6ib/v8XcXafezWl//VgnWy6lY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB9538
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTI1IGF0IDEwOjQ4IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IFNpbmNlIHdlIGhhdmUgVERYIGh1Z2UgcGFnZXMgY29taW5nIHNvIHNvb24sIGl0
IHNlZW1zIG9rIHRvIGxlYXZlIGl0LiBCdXQgSQ0KPiA+IGp1c3Qgd2FudGVkIHRvIHNheSBoYXZp
bmcgdGhlIGxldmVsIGFyZyBoZXJlIG9yaWdpbmFsbHkgd2FzIHdyb25nLiBTbyB0aGlzDQo+ID4g
c2hvdWxkIG5vdCBiZSBwcmVjZWRlbnQgZm9yIHByZS1lbmFibGluZyBvZiB0aGluZ3MgeWVhcnMg
aW4gdGhlIGZ1dHVyZS4NCj4gDQo+IEVoLCBJIHdvdWxkIGFyZ3VlIHRoYXQgaW4gdGhpcyBwYXJ0
aWN1bGFyIGNhc2UsIGluY2x1ZGluZyBAbGV2ZWwgd2FzIG9rIGZyb20gYQ0KPiBwcm9jZXNzIHBl
cnNwZWN0aXZlLCB0aGUgbWFpbiBpc3N1ZSBpcyB0aGUgaW1wbGVtZW50YXRpb24gd2FzIGJ1Z2d5
LsKgIFdoaWNoIGlzDQo+IHZlcnkgYXJndWFibHkgX2JlY2F1c2VfIHRoZXJlIHdhcyBubyB1c2Vy
IHRvIHZhbGlkYXRlIHRoZSBjb2RlLCBidXQgZ2l2ZW4gYWxsDQo+IHRoZSBwcmUtZXhpc3Rpbmcg
S1ZNIE1NVSBjb2RlIGF0IHBsYXksIGF0IHNvbWUgcG9pbnQgd2UnZCBoYXZlIHRvIGluc2VydCBj
b2RlDQo+IHRvIHNheSAiaHVnZXBhZ2VzIGFyZW4ndCBzdXBwb3J0ZWQiLsKgIEUuZy4gaW4gdGhp
cyBzcGVjaWZpYyBjYXNlLCBhc3N1bWluZw0KPiBQR19MRVZFTF80SyBjb3VsZCBoYXZlIGJlZW4g
anVzdCBhcyBiYWQgYXMgaGF2aW5nIGEgcGFydGlhbGx5LWRlYWQgQGxldmVsLg0KDQpUaGVzZSBk
YXlzIChub3QgYmFjayB0aGVuKSwgdGR4X3NlcHRfc2V0X3ByaXZhdGVfc3B0ZSgpIGlzIGEgZ29v
ZCBzcG90IHRvIHB1dA0KYWxsIHRoZSAiaXMgdGhpcyBhIHN1cHBvcnRlZCBTLUVQVCBvcGVyYXRp
b24iIGNoZWNraW5nLiBIYXZpbmcgaXQgaW4gb25lIHBsYWNlDQppcyBnb29kLg0KDQpXaGlsZSBp
dCBpcyBub3JtYWwgZm9yIHRoZSBrZXJuZWwgdG8gbm90IGluY2x1ZGUgZGVhZCBjb2RlLCBpdCBp
cyBhbHNvIGEgVERYDQpwcm9jZXNzIHByb2JsZW0uIFdlIGhhdmUgYSBsb3Qgb2YgcGVvcGxlIHdv
cmtpbmcgdG9nZXRoZXIuIFNvbWUgb24gbmVhciB0aGluZ3MNCmFuZCBzb21lIG9uIGZhciB0aGlu
Z3MuIFdoZW4geW91IGRpc2N1c3MgeW91ciB0ZWFtbWF0ZXMgcGF0Y2gsIGl0IGNhbiBiZSBoYXJk
IHRvDQpub3QgdGhpbmsgYWJvdXQgaG93IGl0IGFmZmVjdHMgeW91ciBvd24gd29yay4gQnV0IHRo
ZW4geW91IGhhdmUgYSBkZXNpZ24NCmluZmx1ZW5jZWQgYnkgaGlkZGVuIGFuZCB1bnN0YWJsZSBm
dXR1cmUgcHJvamVjdHMuIFdlIHJ1biBpbnRvIHRoaXMga2luZCBvZg0KdGhpbmcgYWxsIHRoZSB0
aW1lLiBTbyB0aGUgc2xvcGUgaXMgZXNwZWNpYWxseSBzbGlwcGVyeS4gVG8gd29yayBhcm91bmQg
aXQsIHdlIGENCmZpcm1pc2ggcnVsZS4gVGhlIHJ1bGUocykgaXM6DQogLSBUaGUgZGVzaWduIG9m
IGEgZmVhdHVyZSBzaG91bGQgYmUgYWJvdXQgdGhlIGN1cnJlbnQgc3RhdGUgb2YgdXBzdHJlYW0s
IG5vdMKgDQogICBmdXR1cmUgd29yay4NCiAtIEV4Y2VwdCwgeW91IGNhbiB0aGluayBhYm91dCBs
b25nIHRlcm0gdUFCSS4NCg0KTm93LCB3ZSBnb3Qgc29tZSBkaWZmZXJlbnQgZGlyZWN0aW9uIGZy
b20geW91IHJlZ2FyZGluZyBEUEFNVCBhbmQgVERYIGh1Z2UNCnBhZ2VzLiBZb3Ugd2FudGVkIHRo
ZW0gY28tZGVzaWduZWQuIEFuZCBhY3R1YWxseSBEYXZlIHdhcyBnaXZpbmcgdXMgdGhlIG9wcG9z
aXRlDQpkaXJlY3Rpb24gdG8gZG8gdGhlbSBvbmUgYXQgYSB0aW1lLiBTbywgcGFydGx5IHdoeSBJ
J20gZWxhYm9yYXRpbmcgb24gaG93IHdlIGFyZQ0KZG9pbmcgdGhpcyBhcyBhIGRlZmF1bHQuDQo=
