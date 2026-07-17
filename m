Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5219ADA4;
	Fri, 17 Jul 2026 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293184; cv=fail; b=bXE5sgYn1nr5y82Xng6D0W2YoZ0IwH4db/aT8NMCv1jGJyMf2Yd+o3XHsDhDw7opINeMzW87vw/1pZfEMdlcm6H7SlozSPywCJ77UpD5RKbJo8CRNcTHR34M3u+GQcBSeKEqcfg011e0+SR0gE4ulwHIQOFqKTVaE3u6yo1h+Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293184; c=relaxed/simple;
	bh=//RWIuoBAn08K42n/53Dt3rOnaIB2MKUu+iyygMC2MQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TholbL+qWRbpi+qoHDtNTuAL8+S96IQHU3WcwQZ6tPt/ic77PaIlSWaFfCJ3oAp8sc7M7mrUvvXb60+naBUBMr5UpiwB5jHwdQTNXVYI14v+EnNvEvCg89ChIePXfBQ0QFekVkkOSSLmFpiks75vETbSSCW5oPvzvoSPWwuLgpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4RJ27JM; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4RJ27JM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784293183; x=1815829183;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=//RWIuoBAn08K42n/53Dt3rOnaIB2MKUu+iyygMC2MQ=;
  b=T4RJ27JMCSQwCFkaOWj+e5w7VHrhBUq9Yi52ilWDMTS6bepBSGfEfoTA
   y9jPbMo9IHZol2hJsFtValA68SG2ks7cOXfmempu3ewZwGIgR/PQHKB6j
   uRYs6QHNUM73Xxfd+Jk1fTCcmvA4qw3O4Ewu9Ktl7pBgzGbr8f4GRQAN6
   zEu1qsLUJ2p2Rd6L/gB7Zr3lP0FaBlJI2OW4FjrQUWrmfTnvzPQ6DxMri
   n4Lles5mXhQMtGoJJv53uer0Vt7043YGkvgTbquag3sqodpPhvCjBoU6D
   +2sPSq5GVBSnW3fVTdoYIWtiL37pghwlnXjI/eSblwOKMHGkTAfGLYXT2
   w==;
X-CSE-ConnectionGUID: m+KEN/okRPy5kpYyqBd9vg==
X-CSE-MsgGUID: d+6YajIDSqavyStEDLtZ8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="85054980"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="85054980"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 05:59:42 -0700
X-CSE-ConnectionGUID: dMKqtY7iRzWcO+RlhdcL4Q==
X-CSE-MsgGUID: 9E+AjdH1SzCXF3LOjHKHVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="260595745"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 05:59:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 05:59:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 05:59:41 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 05:59:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Egppx/eEkhLpG6b6QohCSn+zC8U6KuN2l5xRd+0LjoKIWNhY2nlNoeozJPL8yhFowKLUh5nltFjsrQEY4QM0kg8c3+qiV/VtPNRnpzCwfub3vDnXlMQGLbqwjCg00dIksFWDCZRse+1Mh+YT6OXKwYAJ3zqsdZC2Sg/gRit1ILsHWZu5GW8f0J6rdktGaZfMN50ofK0q1isZWzBzI2P7EtPhKfIauJzqnkRN7KErbke+/7rNqrQvkipFTorQP+6BMd740e9roZIdSwt0tD05Myf+IBQ0EDBVlwtv+Q/5iLmKE6WXO3MCvyH8nmPoQOwhkStngwiLwp/nAYNvJgiyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//RWIuoBAn08K42n/53Dt3rOnaIB2MKUu+iyygMC2MQ=;
 b=RY/atOn5Cvf52HCcMhRArf5Z0OnYxG+7gy1iPvxaMUHJV5R6Mzbm6U/kFCYCpp6VK2tgJc3+Sh8z9BjXUMkDEnr/75ObEr7yVx0vLWFmzU5kexYqwHEMNTKpWGRKmZQSZUM3Z1nPX4sFkifC/p1cZzGK11J2sYmsIElRyazXbswBQmBvAKj38ijmfNi+RbitB9IwgCMFRB2DUQV8BigvMKJr+KE0D4XjoSEgfbdg4it4VyvfU2D6CriqpR0LRvpGUMV7jHW/LSecEJg3ZBBBMonLCx53tIB0toAYc1DskijtAcW6JKZRLTi2+U3c/80ozZhX84j245mcm4TLETMJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Fri, 17 Jul
 2026 12:59:38 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9%7]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 12:59:38 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "dmaluka@chromium.org" <dmaluka@chromium.org>, "seanjc@google.com"
	<seanjc@google.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "aashish@aashishsharma.net"
	<aashish@aashishsharma.net>, "guang.zeng@intel.com" <guang.zeng@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"vineeth@bitbyteword.org" <vineeth@bitbyteword.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaszczyk@chromium.org" <jaszczyk@chromium.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Dong,
 Chuanxiao" <chuanxiao.dong@intel.com>
Subject: Re: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU
 creation
Thread-Topic: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU
 creation
Thread-Index: AQHdFT1oryK9eXkZBUyCu3X3875SjrZxrcGA
Date: Fri, 17 Jul 2026 12:59:38 +0000
Message-ID: <792366b7d918faca3f40bccab56bab965e7e34f5.camel@intel.com>
References: <20260716160801.3155582-1-dmaluka@chromium.org>
In-Reply-To: <20260716160801.3155582-1-dmaluka@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5702:EE_|PH8PR11MB7024:EE_
x-ms-office365-filtering-correlation-id: 123fd1c5-69d9-4d5d-de6c-08dee4034256
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|38070700021|56012099006|11063799006|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: I2cQWnJ9IDUl2DArg2CGE3t/qt7gAMvM3VI8135Wsuo10b6DxghDlBkviCXnTvIJwNnosmlmaYXoFjWCnaQr+S02h4p8Sr3xsg+TBP2mWm9NS4qw/FypHUwKgNB3VCfLj7qO+TmUtCFHMNrVeE73JckEQsfKWxWbjLVT2iTHBgipdY38zz0ZRCUVWhY8kRcAZj/WRl6LzAOFMYa63xaINYioM+GMGopopqWYYBgUQQtsmRF4+Marszw5rIjkYDdF2ONcZMVCk7iesivOo6UriDEyq8QNsR/uqxUd7ArAsfxhqtBpnAj63MiKo8EXoh9+mUVny1IPh+HuhcyPmcAIRSoH3Ndfv0SXKtLIv0o+WDvLBA/yjjULFXLMyBJdWOExRzZBLjvEV+i520t9MJvQhhnfPmhN+R0zEnvB2lYC3SBCOSK6bkEHPcWkzNZ4wXw/JehLH6lhJvOwk+TuRHtjN2ZAQmb7r7HDTVG6MPRhyuw1/VhEdgiYKZr14cKcOcNmTB8AkuXczMWsp6XwX12sQqM40J4Gu0HXKMGJSD0V0rHNHXY5xqK+pqGjyLDXCKb+87SmbbeRDE9J9VKr5pWxrBHGV4FQq2dt+PeM1JoIZiQOaPMN/h31OwUNfrHC7IykO3BkYH4pzohAjoq/0Ts/kweHoS6/OdAvsA7/SWuB+ZuF7E6PI2O4aglwilN/FIMzT9yUrZmON+PCa/BnxfOs5XSFM5eIEAwlukAMJmAlGFA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG5YY01TWEVFVGtUOFJ0N0NRR3owNWJxWXYxdU9tbVhnUU1mRUVwZXhMU3hO?=
 =?utf-8?B?RmZRbkV2WlhtZFB1R3NnbmFoWk9wVXYrdnVRY21qNFpqa0ZhY3FSVTF6SFNH?=
 =?utf-8?B?YjVBWnV1YWxoU2tGUkFUQnN6VHpPc2p0WDkzM1BwZ2tBbUk0VlV3aHZrNFBD?=
 =?utf-8?B?c1NpRGpzK0lRckFNK1FhMlFXSUFJYmRwak1vRldrc0hTVjRwOVM1NjRYdjh1?=
 =?utf-8?B?bVJnYVJsaTlISXc1dEs3bVE2QUhLVEVuZVlITHh6WXBsL1p0RmFOSGwyS3lW?=
 =?utf-8?B?eTBVbGVPWk9UcjJYa2tRS3hUcW4yckJ5b3Zvc1pKaTZOcWdVc3lnbFg2clRv?=
 =?utf-8?B?dk1CcTlmcDZxTG0vK3dCR1ZsWFBOWEh3REx4Vll1b0FjcGNSSHhMYlJaYnVa?=
 =?utf-8?B?SmdhSE10Y3JlVWFXb283VHYza2ZJc2xDbEdKcWQrOFQ3RFpvbXliaXFlZVRE?=
 =?utf-8?B?NXhncUVnTDU4c1U2NU5uWmMyMWNaNEd0NWxTMGEzeDUwUDM4NU93YzdQWTlM?=
 =?utf-8?B?NzhBcjlvTVcrSGMvallSVHZBRXlNTU5GNmNocDg2bnUwbGQySloyM21KeFUr?=
 =?utf-8?B?UHVHUUV6dy90b1NiMGhTRmV3MTVEdVB6ckhrL3dFL1NhY2ZSNHdnVVBpUjcx?=
 =?utf-8?B?UnVRK1RudHRWSXNENHpsU0I5TEdXUjhLT1dDd3RSaEpRUVdhM1Z5c2N0a0tl?=
 =?utf-8?B?ZEIxOE9ueWc4TzhLVllwd09mZlgxaURQdDVHNGNQREYvMC9DTGFYMHlJNTRO?=
 =?utf-8?B?MUhPUG5xa1l0RTU1VWIrTVlRZVpPNmwxamV6TXVNQ0ZQVlZheW1ST00xaHlK?=
 =?utf-8?B?RVh1NXNGclduNVpMTUMzR0ZWWVZGMjZvczV4SEtYMWFPYnBDZWRQeG9YbjdW?=
 =?utf-8?B?OHRRT1FFWlNRNTZYUitrMFYxbjBtV0JBM2V3TTVrdkVYdjZJbk5Yd0piU0x4?=
 =?utf-8?B?S1E2REs1ZUZvclBRWmduRzFZYkhlc2NzdWpRSGhEcENpZmRLRWVJdDQzNytz?=
 =?utf-8?B?OVh3MkU1b2E3dm5lTzMyMzlBVU9SM0ZkOEVsUjdYbTFEQTZpZXNrRWUyU1RV?=
 =?utf-8?B?UERxdWhhTUl2S2tSeExScHZBNGJGVFdYdUhwT3FaN2lSLzRZY2h3WHZYaUVo?=
 =?utf-8?B?REJMMlZXYStsQVZtdnUxVlJtWjVjQjBmU0tnQVIrcWVLM3hienpYNStnVjVa?=
 =?utf-8?B?bEJpOW41dDdwNWw3N2pkbTV5V0x6bDZsNTRCekxtbTg4ajZDQ0tTcExMT0ND?=
 =?utf-8?B?VlRLc0lPYUQyNkZ0dVAraUY1QUQxblhsYkU2WVhzWWN5TUU0c3NBR2wrWE9Y?=
 =?utf-8?B?TldRenE1bzZ3ZHdoRjlxU3hKOFppUThackNETUJiaTBEclFJaXBDcjBuMjVN?=
 =?utf-8?B?b2Vnc0VWNE1qOUdBZVVxbGExNjduSlRpeFIzcmNPNUZjMWtSOGl5VmdhWldN?=
 =?utf-8?B?OElpMGN3UC9XblgzeEFTS2w1bEZIM2Rkcll5Tkh6RXJlV0xBQVBubjEvOEhJ?=
 =?utf-8?B?Ky9PQ1gyRHZlWk16Y1Z6NmpjVFE3WE5tMk81MDV6RUZiaHN1eU84TG9ZVzB4?=
 =?utf-8?B?UHk3bklpMTBhY3BOdis2V3g4YUJoK1kxZjVudzVITjFLb3BkOWJ0dUFmS2tn?=
 =?utf-8?B?NDk4OGxqOEJRblNZMXh1MkIvaEx3VVBURWJiejFyYTVpY0lMSFB3cWxKY1lH?=
 =?utf-8?B?djR6djVzeEgvdTdSQXBZUTVibWp4S2hTb1R1bWpaVElyd1BwKzFlN3V3WGlz?=
 =?utf-8?B?Vnh2R3l1UUloZzNrMS8vRHFCbWNGMWtRbWtycThSNnNnTmNkc3pRNTFqMndo?=
 =?utf-8?B?N3pIVVpkelA1MlFzSjhaV0lnSXNqVmEvVldGTUozTVc2VHA2UlF3RCt3V3Aw?=
 =?utf-8?B?eGdBSGZGVWU1Nk1pVCtPTDlBaGtLSXF5T09HMSthRkVwOE9zRW5SWVhERStU?=
 =?utf-8?B?VGxTTzIyWXhQa2JicXp3NGpyNVBIbGNyVVRlT0pDTzdYZkQ4R1VJZnBNQy9K?=
 =?utf-8?B?Q25GenJoYmhFaFZBbmtXN242aE8zUlM4YVdvdXNoYnJqQml3R3cyQkw4LzVD?=
 =?utf-8?B?OTlrdWN5RnhlNytwVTlUOGtHLzVZTEh0YWhGNllyRE1CenBlQ2loWDIyNDIr?=
 =?utf-8?B?WnlXSDlRa0Y0RFNLbzFHUHphMjNGay9JcllqRjc1RUtqTUtaakFOK2QweVkz?=
 =?utf-8?B?TjU3emdoMmFCWUlQeG9VZUtzQjladUl3aXBMWE9GWDZidDh1K1ZsWisvUTFW?=
 =?utf-8?B?WDZqSk56QWd3NjY5TkQ3OTRKdkhaZ1JRV2hURmg3dVZuT3F1RXZoQ0dYdGJF?=
 =?utf-8?B?QXN5dFVyUGpRa212SUVwdXJHVUdGTGU4a3BCT2g0cTN3NTJYcERFZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03585F864934F14EB319F9E51826C3E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iyvLb6QHNKDbcj3MtkDu1cItv3n74UgKjCTR+yrjWxz4I7zHO+zelWFlZjyMSkhkGbHTbOL3yT3EEe3jBWyuaC4YSJ+Wf34iWoNs0dcNHmrQ1htYKQd45+DPDZgfxAuMyREL/S3dqtTNslcd3S805hgjuVQEF99SbtJMZ/aTv1aNcgDQqp7zri/sA0kt9HGZ/iITjOPWj/QHIb/ofVxhsrQFk9GoHHUnpXdvus0YOFeSUkaPvz1oukDf2NCBGwZfYOLXNUot9/3nFrG7QRV/yzSeQRuiU+KxhU3h6tu5fv9gm5bs8nAV21jSkK6ETOChm4ZWPElab7Twg2uDRQNjZg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123fd1c5-69d9-4d5d-de6c-08dee4034256
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 12:59:38.1706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JTpimzt+fYVC3v2ddM3k8RaDEqC8P1aq/RlYRYYFCpprfj2uFgtNp64YYuiYMAAKUvP2y+FGwMa3TUGITPJlPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7024
X-OriginatorOrg: intel.com

PiANCj4gQW4gZWFzeSBmaXggd291bGQgYmUgdG8gY2xlYXIgdGhlIHBpZF90YWJsZSBlbnRyeSBp
biB2bXhfdmNwdV9mcmVlKCkuDQo+IEhvd2V2ZXIgdGhhdCB3b3VsZCBiZSBzdGlsbCBwcm9ibGVt
YXRpYywgZm9yIHRoZSBmb2xsb3dpbmcgcmVhc29uOg0KPiB1c2Vyc3BhY2UgbWF5IHRyeSB0byBj
cmVhdGUgYSB2Q1BVIHdpdGggdGhlIHNhbWUgdmNwdV9pZCBhcyBhbiBleGlzdGluZw0KPiBvbmU7
IHZteF92Y3B1X2NyZWF0ZSgpIHdpbGwgc3VjY2VlZCwgYW5kIG9ubHkgYWZ0ZXIgdGhhdA0KPiBr
dm1fdm1faW9jdGxfY3JlYXRlX3ZjcHUoKSB3aWxsIGNoZWNrIGZvciB0aGUgZHVwbGljYXRlIHZj
cHVfaWQgYW5kDQo+IGZhaWwgd2l0aCAtRUVYSVNUIGFuZCB0aGVuIGZyZWUgdGhlIHZDUFUgaW4g
dGhlIGZhaWx1cmUgcGF0aC4gU28gaW4gdGhpcw0KPiBmYWlsdXJlIHBhdGgsIHZteF92Y3B1X2Zy
ZWUoKSB3b3VsZCBjbGVhciB0aGUgcGlkX3RhYmxlIGVudHJ5IGZvciB0aGF0DQo+IGFscmVhZHkg
ZXhpc3RpbmcgZ29vZCB2Q1BVLCBpLmUuIGVmZmVjdGl2ZWx5IGRpc2FibGUgSVBJdiBmb3IgdGhh
dCB2Q1BVLg0KDQpJTUhPIHRoaXMgc2VlbXMgYSBiaXQgZnJhZ2lsZT8gIElmIHNvbWV0aGluZyBz
aW1pbGFyIHRvIHBpZF90YWJsZSBjb21pbmcgdXAgaW4NCnRoZSBmdXR1cmUsIHdlIGNvdWxkIGVu
ZCB1cCB3aXRoIGEgc2ltaWxhciBwcm9ibGVtLg0KDQpUaGUgImR1cGxpY2F0ZWQgdmNwdV9pZCBj
aGVjayIgc2VlbXMgdGhlIG9uZXMgdGhhdCBzaG91bGQgaGFwcGVuIGFzIGVhcmx5IGFzDQpwb3Nz
aWJsZS4gIElzIGl0IGJldHRlciB0byBtb3ZlIHRoZSAiZHVwbGljYXRlZCB2Y3B1X2lkIGNoZWNr
IiBlYXJsaWVyIGJlZm9yZQ0Kdm14X3ZjcHVfY3JlYXRlKCksIGUuZy4sIGV2ZW4gYmVmb3JlIHRo
ZSBrdm1fYXJjaF92Y3B1X3ByZWNyZWF0ZSgpPyAgSW4gdGhpcw0KY2FzZSB3ZSBjYW4gZG8gdGhl
IHBpZF90YWJsZSBjbGVhbnVwIGluIHZteF92Y3B1X2ZyZWUoKSBJIHRoaW5rLg0KDQpUaGUgZG93
bnNpZGUgaXMgdGhpcyBpcyBjb21tb24gS1ZNIGNvZGUgY2hhbmdlIGZvciBhbGwgYXJjaHMsIGJ1
dCBpdCBkb2Vzbid0DQpzZWVtIHRoaXMgd2lsbCBicmluZyBwcm9ibGVtIHRvIG90aGVyIGFyY2hz
Lg0K
