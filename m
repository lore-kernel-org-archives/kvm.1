Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC8C1C84D0;
	Thu, 27 Aug 2026 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787798140; cv=fail; b=TBPpuRGpKFTr8XBRFIEfTqNjHLFedqY0H5H/GKD56zWmJ9Q5nO3sWsUhYNhg9M7JZzvzFsCJdC7uOkrAh27+cl2kVChL9e8CqC0cYcqVGM1Y0fZIcrF5XYFYHAl+3wQNPxUbf4bchyg2Gpyzbf00wACEVt5rPvtW17pYI1OG7wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787798140; c=relaxed/simple;
	bh=Z5PaKwE652Z5nG/C58Eh6HzN97GKO9ZOMaaKP0Ixgyw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fX0fwXOhAFtDT/mtv67jOwn8kq4NctXJy/jxiPwtTZGOTlYDV5ENxpehH7DZNa4JiVuR6oagORUJtyvqV1Kd3FiCZs6LY8jMmTiZpdxEuFG3yi9RGEVLIGRX99vw0ZMRVu7OrVEu2PymM2hMuaNElwK8jXIngFel1bQ3Ga8c8yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y78f6PIR; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y78f6PIR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787798138; x=1819334138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z5PaKwE652Z5nG/C58Eh6HzN97GKO9ZOMaaKP0Ixgyw=;
  b=Y78f6PIRcHUTRT+Z32Ggop7E3peolk8Whl3yq52pd1HzaSzoqRkvUzrg
   v9F1QuMoNbdjFBvp+HsC0PRM9C2aUp+e0OeGsFgeQR0oy5i1pkoURehFT
   2YqFgUy0TCquPgrNec1l7pYBd5CAEktPtAB44rbUdDsiVG18/37MrB3Nj
   GR+/EQx4c5AFiDHDlQdW/qgd9YZAkF7hDmVPsNdfOtYAOHRxT61H2Camt
   o3QTByjpsegYtETV/7+1ihKrku+7GIjynJxwNd1jusiXSdsvnk3GM0B8v
   3+lYza9v6eA/MOVH8bbv9mQ/h7lmBcH+SA1H8Tpg86+2vWvtbtdD5Ko4N
   Q==;
X-CSE-ConnectionGUID: WqckdW66S/iUEN8XH1UmMA==
X-CSE-MsgGUID: oZrmPi4rRcWyW5+etWSdNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="113825979"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="113825979"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 19:35:37 -0700
X-CSE-ConnectionGUID: PFChfx5NSg6E59f+QQ/gFA==
X-CSE-MsgGUID: dN7mGPIVTke5RfGJYMmIeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="268316892"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 19:35:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 19:35:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 19:35:36 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 19:35:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtdhZoQUBX9jaoZ1gODrJOkUK4DvgLA+SOO+cCQZo3pMkB13RaRhf5LlN8ite6FMXrNl4teqQgawYS6lnEPIbgBd/oWVZpeifxBk5PLibet+S+xlmoWg8VBiwCelpL/+7eJqfl+yEkthTuhd+TDdrb0ddYhQFap5i1WIDBF7sqybz+PUFdgxaOyNIe+yRSvlUbP2rAcc0f//lZIPokYRG1PMDfedlThCEM9gVL+7TBQKyEPIM9yOg66iV1eZ414CIo6nRz3PWbK7Nt0/+swmME0YqHvY3tAcaMOIPXIa1/UxtBVNB1uAPHJUMIMb4LF8HiIAOmj3g2GMko/c5V+rrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5PaKwE652Z5nG/C58Eh6HzN97GKO9ZOMaaKP0Ixgyw=;
 b=wEKDiVuKBxAXEqywYgc2EAwY6yQ5HtpIhNflfHu1r2TtC74F1Sp1hE/q1raTgHUvsDlsQyNEZs0HUAJjM/396E7tHm+SGButauYqE+blmWfSbUfukwZYhF9JZ0x/idKOO5r4Kk3mI7RmkIuOI+du/m49foPDtdXrNYlvqzELKSCziSi0FveTw/UYP0Px2Mzof8jrWbGhPAUuiN50rRtVjEfriV7TxuqPSVGZ/yUbnCHHLNq0SSH+0KGndPJNcEolu3Qh/K+TfXmuqNymOD/1zQod/hLxU+YjUmvCrKsnqMMXcOTp8JUutbWY7qr7nYBqwVFF+9/iSM8A7ddQQ9Z8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5302.namprd11.prod.outlook.com (2603:10b6:208:312::7)
 by PH7PR11MB6553.namprd11.prod.outlook.com (2603:10b6:510:1a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 02:35:34 +0000
Received: from BL1PR11MB5302.namprd11.prod.outlook.com
 ([fe80::f19c:833c:9f41:f3de]) by BL1PR11MB5302.namprd11.prod.outlook.com
 ([fe80::f19c:833c:9f41:f3de%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 02:35:34 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v2 4/8] KVM: VMX: Rename posted interrupt prefixes from
 "vmx" to "vt"
Thread-Topic: [PATCH v2 4/8] KVM: VMX: Rename posted interrupt prefixes from
 "vmx" to "vt"
Thread-Index: AQHdNX45TDVmy6T7VkC9g17y9Xk0CLaxLniA
Date: Thu, 27 Aug 2026 02:35:34 +0000
Message-ID: <a5250f087fdd950c555789453114d7622fb4c82f.camel@intel.com>
References: <20260826171246.777729-1-seanjc@google.com>
	 <20260826171246.777729-5-seanjc@google.com>
In-Reply-To: <20260826171246.777729-5-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5302:EE_|PH7PR11MB6553:EE_
x-ms-office365-filtering-correlation-id: 1fe3a80b-ae13-4f6b-203c-08df03e3dee4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|56012099006|10067099003|3023799007|18002099003|22082099003|4143699003|11063799006;
x-microsoft-antispam-message-info: gBsSDBc+ibUBcmKUi+fGsGnPqDjssCGYwVECfeJongo/yVBBgo33lfWFwrgRRBSPxDVElO/0F7p7yK3g61oQgETO3U1tV5PoEjPEsZWzYxRvVjzwsDfKURyED4jH/TrhHN9mTV/N4vqPsW361t+ymsRE4/oHjguA2Dp8rpAqExp9tSjzA7mHFkQD6Ub43ZsqZEZtHcZ5SOqdVOj85zRYX2aThdvU+M+2CXW4c6wxPWDuMHsEWxq2pdyaBqBmFsj951p01tNicW+1FZsql03HhTujhhNu3IC3rgeAMDdOWshW69x4vdIc7upww7cH14/1PRin5MO7oY5GByWhZCiphIhcnRKKrjNBjhFbvWYhhM3okTXWlOhl+Ovu7FTDJr6tAsjeRa9WR01S44GXQOvea8nfAex4g6VHR//pWAgZyfVBx2poAMxbPDGhfXYBEZxgv8vlrEpc04CLnCXhyek28LkaJP65RQmbpfGKDeurFizBrSsRO5d6sM9zKEZ3422hunIIYdtOTbaUli4PA5tWDUYU8v1hBTqmWhGVJ58gsdBRXXqDzaPGZzz7cp2HxCZt3aEZ5kiAq+a6rBAYyHCcjBIkej0GtAJyB6m4d9uorqjpXZQtXb9l0ecLVGcQDSRZv7nqaqzX6kxNhCsS3txIiJD6E9qCeeYEHn+f9JE8VES5dsmo5CX09gOlcZGBKST0wKeWtDOWfEgo3F3qjmaN7tE8ruQa00yvPUfuy5Xps4M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5302.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTVkUjdEazErVWZONXFWRUlTdWJLUjlIOTlXdUQxcWp3WndXZ1hqTGF1eEZQ?=
 =?utf-8?B?NUlNYkFSVmhwM05xYjQxVjhySElhOTZWVjZkMTI4K0tuQ0Z3TUg5dU9xYmZQ?=
 =?utf-8?B?bVlsZ0FtVXJwNHM1b2xRQjVvOFBZdnFWSVIyZjNXWGd1emxNUTI5TEZFMWpG?=
 =?utf-8?B?UG5YLzRadit3RFlrZFpXMStpWW5UQXI0RVB6U3d6TDJGaG9SOHBWb1dWemJQ?=
 =?utf-8?B?OG5iemc4ak16NmNCT3l1RjQ5WDlTMW1VSGVNdklSSHZnVjEyRnY3N2xGRlUv?=
 =?utf-8?B?QmRTSGdvTVptQ2YzWmZvaWo4a2Nva2dqTFY3Wm5OeDNhSkxzYjB5eGRaUWR0?=
 =?utf-8?B?VTBmQlc0RDhodld5QVJoZElENnY3MVNQZUFRU0I3bjVUbElRNnh5cEQ1SDhT?=
 =?utf-8?B?SW15bG5VcG4xeHh2b3lBNSszYklHZWdaRm5kRWJUTDhiQ1FrQlZZWXVwc2NV?=
 =?utf-8?B?RStFc21aem52OXQvZWlNb3Q4QU1qQlJoQzJFV0dxUVhsVUc0Q3EzdTR2WnBo?=
 =?utf-8?B?bHl5SkRBa0ZJSXM4VlVkbUcwMHZINHhXWC96ZXdIRWxmYVdSVEVmODBiUURP?=
 =?utf-8?B?QUJ1ZlRTMGRtdkI1Qm0vRGx1amlmbGVrcG00a3piaHI2R0crSnFHMlIybVRZ?=
 =?utf-8?B?V3BoV0J0aS8yYnBkcWVFRnNJeVkvOTI2TjQxeUNBMXRkYU1ScTcyK3RlYVV4?=
 =?utf-8?B?cDYvejhRaVcrUWNVaWwvdkRlNnlEUzBPQTVZRGwydkhTaHhTRTVwS0JPeWtw?=
 =?utf-8?B?UUpXbHlhYTVoUFc0NHVBUjlWM2JyVXJ3TWxNZ1MrU3lHN2R3V3pSQmF1dTF6?=
 =?utf-8?B?dTd1ZmZUOFNUS3pLc21VRy8zb3d1Sm1hbjZXUFhNZUNRWkh4bDdCOEtiL0Ux?=
 =?utf-8?B?d0RCZFZzWHF1Q3NhNG5BN1FMclJUVGE5LzQzcEgzUWN6aDhjMUxWODl2Ui82?=
 =?utf-8?B?enk3WnBhV1hZdHdUTEZjdytnSElraUFVdHovc085bU95SGdZRkJOOStKa3lB?=
 =?utf-8?B?akloZ1ZVYlhxRDQ5MnNoQ1VqT2VLVU1teTBHZk9NYytFUE5VK09jcTlKa2NQ?=
 =?utf-8?B?RUUxdU1jUmFLZGRJTyt4NWRxUVp6OG55RDZzTEpuVGkrUHBKUzVLT0w1U0Mz?=
 =?utf-8?B?anNyNXptV014UzltdXRoVzVWakNFQTlPTjk5ZGdjaU1JUlhlbXIxOWVZaU5y?=
 =?utf-8?B?dFYyMUh5Yjlub1UzRmpLM1RwY2UwL0NSVGpZbmRZUUd4RTI2WGZDWkhlWVQv?=
 =?utf-8?B?NDdiS3dqMzBPVHpLdVQ4YUZNZ1Jodysyc1ZFSG5tQlZyNzJIWDJPUHpxaW1I?=
 =?utf-8?B?eWtOQkZoZjVwTWlsNVh5TE4wQlNiT1hHTXRMQVQrUk9KeUpUektYMGJVL25v?=
 =?utf-8?B?MkpCSktyT2dDMkpGOHJqN0xKRGc0czR0OURNbExrYSt6U3VUMlZOdTFWSiti?=
 =?utf-8?B?MFpnSHNiNVgyRkxLdDlrNU5WVGhBL2VlUXNuVGhIZGMvck03QXpSRmpaZDhK?=
 =?utf-8?B?MzlFSGJwVGI4VkdQbDdRcXZCVmk5ZWdKcCtnWFpQSGh3UjRkSGlET1pzUDNw?=
 =?utf-8?B?dlU2ZHNVZjRCbS85NGIzUERhTEJUYnVBdnJZV3pjK253S3pxSVBIMWpIYnlF?=
 =?utf-8?B?a1ZIeEdFczVhakZkbHJCSmFBL1FmbWVKNW5pSDZMcXI2eU1penBXa0dST21h?=
 =?utf-8?B?QXhJNWo3bXptd2VKek1neFNEbzB0cWRiTWlhcWsyejNCVHhSOGNLbU1RSVlT?=
 =?utf-8?B?V0NGVFFUM3NqbW9ZRCtkTFZLc2Z1UHl4UHpKcUNJZlpWeGQ5MUQwQnN4Qnd5?=
 =?utf-8?B?UThtTFJLamxXMndGQ2QzekF5RUpyemNZRjBPTFNMZkErNlVkZzdFZHJMQUYv?=
 =?utf-8?B?UmRuaU1BdzZxVUZ2NksxOHI4RWNSZjViWmRiRVlmTUovbG9ndlpMMStzQnZy?=
 =?utf-8?B?TVE5ZXVFYjNNRjdNKytrM1VQVTAycDFJQXVxTzhwZXY0TCtzSmkxbnd2NHNJ?=
 =?utf-8?B?SWdVQnhITTFkUFdublhOY2kwalkvYXM4eVJVSWdVd2pldnJVL0sxcGhBUTk4?=
 =?utf-8?B?bW0xMnRSSEJ4d1EydzV4amZ3V21SakZsa3hZd0NNZFlneTk1aXZaQlBHRjFF?=
 =?utf-8?B?Wk5LbTVTNTh5NnJjQ0pUN0ZIbTZ1aFJidTBKUUdHOE5oUUQxOTNmak1WT01C?=
 =?utf-8?B?ZFB0REdPREdKOW5aKzU4cmQwTlZaeTNEWElJNHBieUV6TmpCY29FMlU1aExt?=
 =?utf-8?B?dGhvNzhTYTVXd0ZhTm5MTHJRb096YnR5RVNRWUxhbTFTbWp5MVRoT1JrZEVE?=
 =?utf-8?B?OTVkZy9IZXVLY2h2OFFETzBYR1NxanlyUGRCQnh6b3kvdU1PUWdkUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DC4601E4E345B45800118D998C2BEDB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s3vboPvHmC9/pKrP7xZ31Rpzz7DulTxEJoRQTvLhW8/ngwXQUj6EAzYd1qf7/j9ueB7yrbTv60Ja0wvjt0ityVszS9TxMzkq5kDncTMTZ3Uu7aq5e/hEEyO0KFfiAuKLOv9MnCWiJqi5x50022nQigwvz7d56vCx4a1XX7MN3MYLG7+eFhGFG/jUMB0QFhjyCxeDd1ducmwDUuRDYY5/UBLw256JAILSr2AvgKlY28l/yStdO3hltfZ9/eeTerxKrbU2LpQMmfL3aSUWyYJrqe60hAMQJp3UDW9RRk1EHihTBc8n/ChNX+N6jLcQt2w5uuXnMN0izGKiPtjMHixQEg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5302.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe3a80b-ae13-4f6b-203c-08df03e3dee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 02:35:34.0790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HdFFtLjvgGhQoIHMYhsgyaV373XGb9Wc6bqnrgsmZiNGYtcIOQm6ljD4kblm9OAdgXDasj6lU2Tled7v2h6gVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6553
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTI2IGF0IDEwOjEyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiAtaW50IHZteF9waV91cGRhdGVfaXJ0ZShzdHJ1Y3Qga3ZtX2tlcm5lbF9pcnFmZCAq
aXJxZmQsIHN0cnVjdCBrdm0gKmt2bSwNCj4gK2ludCB2dF9waV91cGRhdGVfaXJ0ZShzdHJ1Y3Qg
a3ZtX2tlcm5lbF9pcnFmZCAqaXJxZmQsIHN0cnVjdCBrdm0gKmt2bSwNCj4gwqAJCcKgwqDCoMKg
wqDCoCB1bnNpZ25lZCBpbnQgaG9zdF9pcnEsIHVpbnQzMl90IGd1ZXN0X2lycSwNCj4gwqAJCcKg
wqDCoMKgwqDCoCBzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHUzMiB2ZWN0b3IpDQo+IMKgew0KDQpO
aXQ6IHNlZW1zIHRoZSBzZWNvbmQgYW5kIHRoZSB0aGlyZCBsaW5lIG9mIGZ1bmN0aW9uIHBhcmFt
ZXRlcnMgbmVlZCB0byBiZSByZS0NCmFsaWduZWQgYWZ0ZXIgdGhlIHJlbmFtaW5nIChvbmUgY2hh
cmFjdGVyIHNob3J0ZXIpLg0K
