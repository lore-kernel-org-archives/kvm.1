Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1753603C0
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787792051; cv=fail; b=I6Swd+waLPH5MV1CckRWXeWvBOZ/GUKM5XqCqnKodP/9hagl7+NcRuNPUMlkerMONJTo3XVCPPFGLbxHWivUpZaTWnf+rteL9hIYapYQn+aQlPhHRD5PGQB8CNmpNohKuk6dtzS+Pvpr8LBEZcFoxRNoFpvFL1NzAv/OmKcuvjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787792051; c=relaxed/simple;
	bh=iNx1qWYxgsf2DvD+8eKmVPVPrYrZ61jB2hzF+ZzOVYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sA9fs2BveGmTVcSDuNYZY0ktvxPpXXkwwFuJu/7FDHLEh5PvOzqrfLOhDdHSoyFSQ51UmECaYtUZYUrUNJBLYgrgu1oe7py79j3DrLf+vvybtM0HuIPxN0VxaF/NqomAL4Igz8QUncun0O1anIBfTBjw8bFeDtQtYqBIcpLBZQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eex0zv9N; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eex0zv9N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787792049; x=1819328049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iNx1qWYxgsf2DvD+8eKmVPVPrYrZ61jB2hzF+ZzOVYs=;
  b=Eex0zv9NntqsFSqLw64toTPiNK+OXCagvjLDDTjEpou5YBIbv05TcM+8
   wzuV21Beml2Xqw7fYS11xvOrAnKpORsJg7QwhsxTMHgL3YzRSzPKvHgK9
   VJC4Ub+ViRZG2f5BWZ9yA+o+VQzw9xa2PA05pcNWoF9W4rxi2ZSH1pjQl
   MkOcw5S1zcTHTAQMPQPGelM9saoeW5vXXvnhg3r54j2IsMDaoJt4GGGMj
   k+6E7I/CnTBwru3D16Nlop3zP2SQfNKRy63CsPbaT5Vft4wo3SQjsoGAS
   3y5xSLmIuP9s2+axZM0TMNBu8ScwqGEyuPf2x/ou1tvWjSeEl4mSxRY0Z
   Q==;
X-CSE-ConnectionGUID: 6ANpuLCDQPyJvm8WfMWtQQ==
X-CSE-MsgGUID: BdPbrgDFTsSkbkhxn6qaAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="99450483"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="99450483"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 17:54:08 -0700
X-CSE-ConnectionGUID: WOhAQ8xyRyaL+AnSJKr5+Q==
X-CSE-MsgGUID: dO5ybAEPS9ynuaOqhWEmGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="265938672"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 17:54:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 17:54:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 17:54:07 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 17:54:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oW8NQP36ZkgW8YiFcDYT4RCLZLZe5OJkSa7HIMaRgwZZcXDj83t4bZssq1ZGq+bfMIyBhxnLcXS5wKMu7uHsilJqEvIMhcVthVP8Fn07IKO/Q4GzmKz2O94S30OFPVeJ8EKuje5WG9Q+fHK8INGsUj8+r9Sim/rAhZoZfjHsW9sZhspLnt94AgJwWNilBE4OBgr8l3kpwbMFvTOP9kVHc+P7XT3sh/6YRW9s5YizyGS97JUmxgyYRyFLK2XIscMBdDF0K0MSlhYeageCJXaGm3gNWFYHWQY8DsQ5w8bKcQWHRkkdVvpH+wo5yXPKc44cLV2fxhtLHokXTf1ZC2Wcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNx1qWYxgsf2DvD+8eKmVPVPrYrZ61jB2hzF+ZzOVYs=;
 b=lFTLnOSYk9UsQW3fmt1SXBwia3nGwiaLedUpP8H4Z0sC+pkW7Zn4S+njqfbRvu0+XOePHAs2hE2qCMurAti0/1/nDIHL4sIHc2ZeDi76EdFRUDG3UXHvPfvfwhhrRlTocoR8mWhTb60kf+vd0YGnAHJml2kqzgnAXg50sp54qGjPfB/H7/BHEMohUwkL0vyollj62DXgQkwoSkdboSvNCIOv2YLizUSdSGG8tWK2V4KM4gJD6zl185gvWvTE8IH00rC6GY+54uJcT6kF5tzaK4bTk+KYqrYjwby5MGSBjTIFyIo4hxfkRTUcfu/Uc7pWrdpnnY/6lfC4Ods7pMmERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA3PR11MB216728.namprd11.prod.outlook.com (2603:10b6:806:589::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 27 Aug
 2026 00:54:06 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0339.012; Thu, 27 Aug 2026
 00:54:05 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"kas@kernel.org" <kas@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: Process for doing early internal type review on the list
Thread-Topic: Process for doing early internal type review on the list
Thread-Index: AQHdNbbrl3HWGo88DU+28qB6FuIfIraxEbCA
Date: Thu, 27 Aug 2026 00:54:05 +0000
Message-ID: <575b25a59231cfb7bc5fbaf4bbe45bfedad1e3a9.camel@intel.com>
References: <827b213a9482b417abb1d172438f0fdbfecd4c7c.camel@intel.com>
In-Reply-To: <827b213a9482b417abb1d172438f0fdbfecd4c7c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA3PR11MB216728:EE_
x-ms-office365-filtering-correlation-id: 079d4285-538f-421e-12e6-08df03d5b1fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|10067099003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: H3zJy/cJR5ZjheWlBV8hlZugCK/8AAhyv/Qy+mW4Tc7J6zg98VU4TXsCWi/q8mKAI/cGgNuuyxado2P9OWlmOlCA1IV50WwkImNQBil8k7JmnNAeJMO/N/xYOjQD3g2S3kJ+EgWdM9eSBEZ+67hGRe/FIi0Rx65iHsRCQv1+5Lxv/ydBJlZKulPl9hIlLbR3zDXYnCd1/BlpelVMCWeQE32bartPRt+kDFWkQLsAayqk7LaObrGbIkElZblUhXmlYZk/WzG5rsV4KaNiCEHp36LIUFbzlbUmlq2SKIZQuSi038E5T+if4SQMYeT5M06/M5ySHxhUPwHr8zH6rG1HbuTKj5rTMvAHIWpbnRV9x5spkaSY/lHCwwak+TgJAEudzTOIKXPvIYKQX1o6zlBFhQ9swGfPCB3pOV9yiFcPWLlW6THKFldOkpVcddr4G2KcgW58V0e3tMbUjutcgL9f1deskXUdkwO+E9DWW8DTzPFE9fsz7MiR7Cv/UWSZCN+VqeCNnebWyGwrwk2A6KYDFi42S+UpK8rDoYexfxuGYF71V25H8NSM9JQM/L64WchpMdBQ4WXbTidAVv8E/dhghUjkuEbhBZQf0W/wWobJhYRsgXuQs0WDD5dcZWeD1/K1ysSVngGio2qX/Q8uRPyr2Z34Koiki2brQAotwtIz1g2q0SDWYoSfjWy74T4qFJRSJZXOVqJY/6YEqlgoPj/qVmbminm6OslUGD625FsT+yE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cStlakxIUDFmemlHYktOTkxOUUZreEQxczB4OVg5QWdLczFtVkxocWQ2a3ZM?=
 =?utf-8?B?d2VqUytNaFYreTAvOFBMVlJtSnByNXNUclRVRU43Y0lsanczd3AwcStlSlR4?=
 =?utf-8?B?NEd6M05IS2s1d3p2THkzNUdwaTBlSzRPYnYwd2hHTUhmUHhtbVlzeHA3NW4r?=
 =?utf-8?B?cTdOWndMUXNDQk9FbDJoUDNta1daYmt6aUpINjVtL01Wakxubi92cXliUXps?=
 =?utf-8?B?b1lpYXM2dDhmc1RzRUEzTTAvallLZFpHeWtKQlZnTm5lc2VuWUlhZ3EzZU9V?=
 =?utf-8?B?U3NYWFpuQ2ZNUTVRTk10NjUrL1VzUi9OWlU5NHFaQUZ2aml3RWl3ZHVYWGJs?=
 =?utf-8?B?TzBST1dHSDhYR1VwSVVBUUZBQ3dNUlVuM2ppS1FkYVRWZGcrT2dqSWx6THNK?=
 =?utf-8?B?V3VtSTd0SHpXa0dOVGx4VGdmMmpCNGVhRXljMW9DRm9rM1p0VzU4TVRRQ05l?=
 =?utf-8?B?UW1zdTdQRVd6VXZvUFlGa3pLMmJRUDJadFlqVTh6OVRCbm05aVRBQmNqMkNP?=
 =?utf-8?B?YURkNnpYNVFZWWJsQkRjSjVpK2dpUDJoSjNrZm5CbnY5eis1VTZJekVkc3Vo?=
 =?utf-8?B?Y2tobmlZNEh5bWxTRUlkYTQ1Z0dJODJYYXhzRm1NeVRXdWwxS1pHQS9QQ1pM?=
 =?utf-8?B?TFRacnZ3QWFzWGpZRy9JV0UvVS9XaGhYYUhsS3pWc0Rzd1A3Sms0V2NvQVQr?=
 =?utf-8?B?R2QvUEsxYjNxcFZYRmQraG56c1RWQW9oZXBPVnBnRjNkc3h3TlpOK1RXOWVu?=
 =?utf-8?B?QXY3VDNjcFgrNW1FeGZHUXFFOERWVng0TzN4eC90U3hvZmtmcHVFRmw3dm1a?=
 =?utf-8?B?SHdUR096dDAraWFmaUNhdlV4NzBmcFRadFJLNmk4cncxWUtab2NaSkVKd3Va?=
 =?utf-8?B?T2VpZHJZQ0V6aVFMcjVlSHB4L3dWWDIyNUp6YmM2RlFTcFBkemg1UVhmT1lE?=
 =?utf-8?B?Ym4vbjllbHhkdHE2WFdZanFudTFXUVhWazVoWU9DY1RhZTMxOHlidmdiWTRK?=
 =?utf-8?B?S3gzck9hczhCM1hmdmg4c3E2dGhzVXFvcnN3YXE1UExCNG5KRnhVdGhaZjRq?=
 =?utf-8?B?WTRpWFlYTFltTVM3NTVCc2JYNjdGQ3ZjVjV5RE9nTHlJUnNaY3JDTGVqS2U2?=
 =?utf-8?B?ZnNoWUVaY2xKUlJWRmExbEFQNmxJZXcwZ20vWkJWWmo4c3RtUmU5WmNKeFBW?=
 =?utf-8?B?eG9qZHNqV2R5MFR6bjgvN2JyaVJGdlcyQnBLRDJOcUtqWFFWVXgrSGtvMDE4?=
 =?utf-8?B?ZnB6VkNNMmVCK3Zoa1JMbTRScGVvV1lCSWdVc3pJd2NnSVFOTmZ3TjNsNDVE?=
 =?utf-8?B?WTBaTk9mUitEWUE3MlFWdytvcmp0K2REK2pOR2JjdGZHSzVrOXd3dmxHN3cv?=
 =?utf-8?B?cFBTeEppbUhlRkJPRnBwd0drdkRDdUZqa1VremhzMnN3dVdOU1NwM3dXZ2da?=
 =?utf-8?B?SmFzZ1BEb3M1b3JrUHF4VGtXdDhSS09wT1BQVzVSMTlzRm1nWFY0TXBHTitx?=
 =?utf-8?B?azlBeElDOGhMNnBPNTNldCtyTUkzeEZuTzcxby9URzZuS3ZFSjZlRXh1Wlh5?=
 =?utf-8?B?eW9lREVVWFJzeEh2VTBpakRYMGlsTnRuclc2Y1JoRWZmanRtSlhWYVNTWWhT?=
 =?utf-8?B?ZHJpU21HS1VQSkxFMU1GUTlDMTRjcEN6ekJhdTQwci9yMUMxWHVzaHA2VURn?=
 =?utf-8?B?V2Y0ejFXc2JuMXJDdFNyRG9lcHY2K01BZ2VUOVZDdzZYNkFHOTV3RVdTdTlU?=
 =?utf-8?B?ZEhaR2RXaW5BY0MwY2Z1SFp5WEVPckNWcGtxWWhaanp6UjRGTG8rUWo0Q0pY?=
 =?utf-8?B?czFqOXdvUUlBZURtQ3I5aVdaN25NanFQYy9LY0tNWlBoQTRZUmVsVFBOeTN1?=
 =?utf-8?B?dE9jNnU4eExNa3RDMkliNERkdjB0WG1yaC9Sd0I1dkJ1V0hLWVZSUFlMcU44?=
 =?utf-8?B?VGpVdklrcjdLbXRtZDZuVmphZzhobGFjTnYxRjRldkIya25PY1NPakx5S2hs?=
 =?utf-8?B?cnpqUm0rTEgvNmlIWXhqWjhQeHpZQkdFQUE1UTRrVXNmZjQ3ek04N0Z5Rlp4?=
 =?utf-8?B?dUh1QWlQK2dSNmtLbnU1WUhmMDU4enB2QkRVN3FYaWIzT09OMkdnYkVQSjJ6?=
 =?utf-8?B?TFhIWFUwbS9qTU5MN2FTTDVmYTBwMkxrQ0wzZm95WHdCUHNCS3RZYllLZ0Z4?=
 =?utf-8?B?Z0tZNi93L2FYMFdVcmZTRkliMnFaTnN5d3JtN2pRWWZYb25ESm1SbUVNa0py?=
 =?utf-8?B?NG9QUjNJaEd0anowOWEzOUtYYjVwYW04ajlsSExrRXZVNjUrdis1Ky8ySFQw?=
 =?utf-8?B?K1NodVNCVWkzWDNQbVVFMVgzdm9Fb2RTbDRzMFhhYUM2VkhtWW5rMm5udkl2?=
 =?utf-8?Q?jpaEg1gbpy6s/4UE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0219FD745A679D479C063D453D6CBBCA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lmdjeS2WL+d2Qffy72LeY5+TPRZpTxBGx+EJoRcAiVK+ZJpguhzvwfLb6ZLoDbEzFN6dY5Bprtwn91QDwPczvtkaproxfjTFP+SvUpOQF/84xZXmQNGgNDkemHx6byBcH3OP1/SZ20x+G6MAbyZWrCTGyPApYumpsuqvl98BtGysV0AdKIydTevS15PHp1dSXcpagve1MPkBjKt6coYAR1bRLtnvXe6H9tFi30+DK40AZni2yENNUr+31dw/DzcqpobgaCV+lpE3d9mrEyAmu/nwdEkftwW9qbr+XzukbIPxc+w+oJAnmqdv9peBBvt6sPVQ6iZenchD5Bmu2TazsQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079d4285-538f-421e-12e6-08df03d5b1fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 00:54:05.8747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ON8jX4nyKaha88+jed4JJt/1dmXCtDXasMZqi7PdaMFYB8aOxdJDXvm4vvUw9I5M0jeiZf2dVslet7BpZQdMqyh1jLf/v2oc7hG3b9CqG10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB216728
X-OriginatorOrg: intel.com

QXJnLCBmaXggS2lyeWwncyBlbWFpbCBhZGRyZXNzLg0KDQpPbiBXZWQsIDIwMjYtMDgtMjYgYXQg
MTY6NTkgLTA3MDAsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiBTZWFuIGhhcyBsb25nIGJlZW4g
cHVzaGluZyBURFggZGV2ZWxvcGVycyB0byByZXZpZXcgbGVzcyBpbnRlcm5hbGx5IGFuZCBjYXB0
dXJlDQo+IGV2ZXJ5dGhpbmcgb24gdGhlIGxpc3QuIEZvciBzZXZlcmFsIHJlYXNvbnM6DQo+ICAt
IEF2b2lkIHRocmFzaCBieSBoYXNoaW5nIG91dCB0aGluZ3MgaW50ZXJuYWxseSB0aGF0IGFyZSBq
dXN0IG92ZXJ0dXJuZWQgbGF0ZXIuDQo+ICAtIENhcHR1cmUgYWxsIHRoZSBkZXNpZ24gZGVjaXNp
b25zIGluIGxvcmUgaGlzdG9yeS4NCj4gIC0gSGVscCBkZXZlbG9wZXJzIGdyb3cgYnkgZ2V0dGlu
ZyBjb21mb3J0YWJsZSB3b3JraW5nIGFuZCBtYWtpbmcgbWlzdGFrZXMgaW7CoCAgDQo+ICAgIHB1
YmxpYy4NCj4gIC0gQSBzdHJvbmcgcGVyc29uYWwgY29udmljdGlvbiB0aGF0IHRocm91Z2ggc29t
ZSBjb25mbHVlbmNlIG9mIGludGFuZ2libGVzLA0KPiAgICB3b3JraW5nIGluIHB1YmxpYyBwcm9k
dWNlcyBiZXR0ZXIgb3V0Y29tZXMgZm9yIHRoZSBrZXJuZWw/DQo+IA0KPiBBdCB0aGlzIHBvaW50
IHdlIHByZXR0eSBtdWNoIGRvIGFsbCBURFggS1ZNIHBhdGNoIHJldmlldyBleHRlcm5hbGx5LiBC
dXQgdGhlcmUNCj4gd2VyZSBhIGNvdXBsZSBzdHJhZ2dsaW5nIGNhc2VzIHdlIHJhbiBpbnRvIHJl
Y2VudGx5IHdoZXJlIG5vdCB3b3JraW5nIGluIHB1YmxpYw0KPiBwcm9kdWNlZCBzbmFnczoNCj4g
MS4gRmFyIG91dCB0aGluZ3MgdGhhdCBhcmUgaW4gUE9DIHN0YWdlcyAoZS5nLiBESUNFLCBhbmQg
bmV4dCBtaWdyYXRpb24pDQo+IDIuIFRoaW5ncyB0aGF0IGFyZSBoZWxkIGludGVybmFsbHkgdG8g
bm90IG92ZXJ3aGVsbSB0aGUgbGlzdCB3aXRoIHRvbyBtdWNoIFREWA0KPiBzdHVmZiBhdCBvbmNl
LCB3aGlsZSBhbHNvIGNvbnRpbnVpbmcgdG8gbWFrZSBzb21lIHByb2dyZXNzIG9uIHRoZW0uIChU
RFggaHVnZQ0KPiBwYWdlcykNCj4gDQo+IEluIGFuIG9mZi1saXN0IGRpc2N1c3Npb24sIHRoZSBp
ZGVhIGNhbWUgdXAgdG8gaGF2ZSBzb21ldGhpbmcgbGlrZSBSRkMsIGJ1dCB0bw0KPiBkZW5vdGUg
dGhhdCB0aGUgcG9zdGluZyB3YXMgZm9yIGVhcmx5ICJnZXQgaXQgcmVhZHkiIHR5cGUgcmV2aWV3
LiBUaGF0IGl0IHdhcw0KPiBiZWluZyBzaGFyZWQgb25seSB0byBjYXB0dXJlIGRpc2N1c3Npb24s
IGJ1dCBub3QgZ2FybmVyIGF0dGVudGlvbi4gSXQgY291bGQgYmUNCj4gdXNlZCBmb3IgdGhlc2Ug
c3RyYWdnbGluZyBjYXRlZ29yaWVzIHRvIGRvIHRoZSByZXZpZXcgaW4gcHVibGljLCBidXQganVz
dCBvZmYgdG8NCj4gdGhlIHNpZGUuIEl0IHdvdWxkIGJlIGFuIG9wdGlvbmFsIHRoaW5nIGluc3Rl
YWQgb2YgaW50ZXJuYWwgcmV2aWV3LiBOb3QNCj4gcmVxdWlyZWQsIGp1c3QgZW5jb3VyYWdlZCB3
aGVuIHBvc3NpYmxlLiBUaGF0IGtpbmQgb2YgaWRlYS4NCj4gDQo+IA0KPiBTZWFuIHN1Z2dlc3Rl
ZCBhICJGVVRVUkUiIHRhZyBsaWtlICJbUEFUQ0ggRlVUVVJFXSIuIEhlIGRpZG4ndCBsaWtlICJQ
UkVQIg0KPiBiZWNhdXNlIGl0IGNvdWxkIGJlIGNvbmZ1c2VkIGZvciBhIHBhdGNoIHRoYXQgd2Fz
IHByZXBhcmF0b3J5IGZvciBhbm90aGVyIHBhdGNoLg0KPiBJIGRvbid0IGxvdmUgRlVUVVJFIGJl
Y2F1c2UgaXMgdGltZSBmb2N1c2VkLCByYXRoZXIgdGhhbiBhYm91dCB0aGUgcHVycG9zZSBvZg0K
PiBzZW5kaW5nIHRoZSBwYXRjaGVzLiBIb3cgYWJvdXQgIlBSRVZJRVciPw0KPiANCj4gRGF2ZSwg
SSdtIHdvbmRlcmluZyBpZiB5b3Ugd291bGQgd2FudCB0byBoYXZlIGEgc2ltaWxhciBwcm9jZXNz
IGZvciB0aXAgdGFyZ2V0ZWQNCj4gVERYIHNlcmllcz8NCj4gDQo+IFRoYW5rcywNCj4gDQo+IFJp
Y2sNCg0K
