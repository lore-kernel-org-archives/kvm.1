Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74491339B1;
	Mon, 15 Jun 2026 02:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781491604; cv=fail; b=tOFoPfvjzOsG9owlp0YYPyVYjyj0RBdAPiQCdbOggd+i6BB5i7YEXqKxg3OyMiVJfCaBYEzDs4kgpeVTRS7a3zENC52iXD5oTyhJM32zhSmDJ8ebZghIH8BiM/2RddFulqnmhcEkFrV0RDLzxHasIsYa05thjnJ3tiFtU6y7xIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781491604; c=relaxed/simple;
	bh=YjihpPfT3G7s5eysuUwhMDRM+Bt1mnmuNBNudxLGv3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GzATmvzFIeRAYhEza0qLpLwNvZCTMGIt8R34HfKjWNVtEovwsgEJAc0wa0MwuY99LoJgPe9oZ/OHvPvdyNkO7Qqyuza1ASshzHFJPw7SaDjto2uNCRY0BR5DdFtpGnc7HKzt0ThAgQyfVRVUNufyPWHxfmk69y1XGKoNtLZCouE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6Xhgd2R; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6Xhgd2R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781491603; x=1813027603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YjihpPfT3G7s5eysuUwhMDRM+Bt1mnmuNBNudxLGv3k=;
  b=H6Xhgd2RAiYFjSz2g36rSh7bQUemG/3Fi9Wf1hCvRwJpV3hncrAQgLIO
   h7WrfyYqi0WmvrUnwKs0f2VddkOV8+PtELE5o12dsTSgxO3S7zX3e18/U
   byCajs0CKOQ3UFCeYN7std2dUE6jbkqLJTTxYKJ/3FFScE6zeYHIJnQPd
   wxewMN7k7SYNnsVdsk//+cCi6+3WYXacfRvtKWKZkAdMHBupNI+hRYsNW
   evPAm1tFshvTvqWqotmmC6829+MwE1XS+QMqtBOxCVXRtrBNxYmiPOPoQ
   PJs5A7agtFp+UCGjukEGHmbu/LdIVVeqjtwQaVN4XDCLdQmb2ULSmuGBC
   Q==;
X-CSE-ConnectionGUID: 5UM4BscQS9upKGox9ds5TQ==
X-CSE-MsgGUID: y4Muoh/zQLaTkQWx1/wsiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="85860078"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="85860078"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 19:46:43 -0700
X-CSE-ConnectionGUID: ahbR3a7AT8GGYAD7pt6FDA==
X-CSE-MsgGUID: GLOKBXVXRGKk/V1BCDYwfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="252297805"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 19:46:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 19:46:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 19:46:42 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 19:46:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xwd47LpK+uULSuOP0iVm3itEoSoiHbW+MF2JUX/aC1KLaR7i9nlci7adLSBfA/9p0KUI6E9C8f2xuFRtcsRmdF2kPx3tvFJqZ2xyrOA/wsihbPBLgGcfNEWVW3/MdT9I++BdQH32mtYwPDp5S5DcvY55MvZcL3FHxPyGby/fIAXvgN1qJiPGJ1uXTBqoFcekZHMI0P2zHyDR1pz2SlI3N9ZySlMoRKruZb2Fg1VluvFDHjTZvRx/YH9AoBOZ89MicSx78QXpqt7c6c6A5r26uMv9hXLM37EVh4I5T5oSzEeOXlSUeXa7ZXQBHB2PPnbpbMGClwGVX597jbXrlp8cXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjihpPfT3G7s5eysuUwhMDRM+Bt1mnmuNBNudxLGv3k=;
 b=WC94ADaf4zLxQcQmuKr2QeFuZMDE3tf4RTXbaKXgxo2njbeNl/l4S5a7XSJlCe9YXt1B0dV3pjQY4do8XtG+PFhF9935apKCzaaQ3NpgvpkzOVimAoB7sPIBliySnPEAFlvxvUT4Hct55r9jDD6amCNue+R6Vh2Awt3fW9cTZTeIGbRfboq/kLbb2TnA96AWPsfTjcPm4YW3SfmgeWE12a9NcBc5k8KgDzRHAfMSlPfEPn7W4pz7Y++R37kksHdsvbRfqxFxIRZpACWRH7tGMHyoFM5fA9vxmKyBLjPvzR2qKfAL01va+APY87axJ/41ZVDnz7jOIcQAabKb69Oa7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SABPR11MB9937.namprd11.prod.outlook.com (2603:10b6:806:4f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 02:46:34 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 02:46:34 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yosry@kernel.org" <yosry@kernel.org>
Subject: Re: [PATCH v4 03/30] KVM: x86: Rename __{g,s}et_sregs2() =>
 kvm_x86_vcpu_ioctl_{g,s}et_sregs2()
Thread-Topic: [PATCH v4 03/30] KVM: x86: Rename __{g,s}et_sregs2() =>
 kvm_x86_vcpu_ioctl_{g,s}et_sregs2()
Thread-Index: AQHc+sgftCC9K/nWhkqtKDsxCBiKsLY+7MgA
Date: Mon, 15 Jun 2026 02:46:34 +0000
Message-ID: <feb622ecb3e79d2940e6c77f0bf9b7aa135ce529.camel@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
	 <20260613000329.732085-4-seanjc@google.com>
In-Reply-To: <20260613000329.732085-4-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SABPR11MB9937:EE_
x-ms-office365-filtering-correlation-id: 23c3aab6-6f2b-4a2f-0008-08deca885080
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|4143699003|6133799003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: TKXYJzK2FHqyZlZa6IjjmL9WalZnGishQxjSviel7RvzXIunZYIqp9a8BAQYO9p8JFVZTfvVg3XV/mYuSgbVHc/utsg+pvjX4YRQ6f42kQAJyJ+5yAAmowSsJVCjnEsuit5krrzxuoEBM/iAQ02aR/OtrOwEFNA+kyREVv0sbcwh0CB8waUChUJmvaXz8O7l6FMq9E5+VgwIdXYV0lBMarJJYJm5FTpfCB6xAM+bi0lyo0En5b5E2mkmfBsKF/bpuj/vrMLFaQiuHj0XCLqpa+Ud+421vTT6c2jfIDoyPy6VBTfDWwufWikOk1/Zg/TaTWFVdgxE1MsOhyrZwJzVthUObB2vpXps3U5Fxa7Ay+XXUJcdfYL7eJ2ZPTqZSWtLGsPksI2nW1emupzPpGalckPq1I0+gxk5pjFo0Ebpz9NNHHmpwhSQrLznY0XiuzKckzGEDIk3ZyzBTO1+2JpBNtIYnL0O47CJP80PlvZWI4oTCdltWU+ZRyY9B/nyXDz1BtQyrjsNmxm4pQ11wLB0P4jhHye8nmCaP5uuR8ewKoO6zVJbBsoC9A3r5dG9gHrfIOosj0n+R7Fasw9JOz7jLFL/IZY+3VD8knhCujrjOBMKLnv4EucdvKecElBBnES2b8+N4UmoLVSIMezzx+pitzljAcI4i2OTRc3ha24aBsoWNEKtPu0RamDIWv0kwYX674j5tEeD+tO7trXLOyxsquHvNS38/QJrN6W2cBbR56Chvl227U1ygXMVqDG6VsM7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1JndjhEVElydSt5L0k2clBiVjJ2Zlg1bTVsVE1iS01kZ2QzaEFzUkhMZ3lB?=
 =?utf-8?B?MXptUnN0cElBUjFGWHZiVHVNZy90bGFoOVp4NS8vTk1KSjdQK1ZndHR5MkZZ?=
 =?utf-8?B?R0ZXdTAwUkEwQ2NnOGtVcHNKM1Bwd0ZXaWYvc244RjVoK2lNYzR2eEE5TjVQ?=
 =?utf-8?B?YUxNVm5jN050ZkwwNmE2ZGlMaFRLcFNycjREckdIM1VrMnJ5OFZtYkJrakc1?=
 =?utf-8?B?L0crOHhLWCtzdTlCdjR0M0xTOXB0aE10Sld6LzRpTnJlcHNOVlF0U1Vzb09T?=
 =?utf-8?B?S2Q1dlhYRzBlQXh0bFlLUEdCYUVlbWM1VXJJaEdadVMvTXEweVdoaVNWZWoy?=
 =?utf-8?B?SnVJaW5zOXBybmFacGJyb3Y4bGRpYUZCcStyUDAzNnhkdFVKdVVhR2Q3Qjdm?=
 =?utf-8?B?TlBGMUI4MjFuRXVHR1puSkdXMmI0Um5jTUlTRUk5UStjRW5icS9FSVhYN0hk?=
 =?utf-8?B?SkVpa3Byd1k2b0IyNThabUE1cDc2OHVWNVlGKy9tUy9MQml1TnFtaWpoOFVm?=
 =?utf-8?B?d2xrOVJOeE1ZMG5OZ2ZXaUI0VEl3Vzd6dzBRNTFiY3JRTmt1ejI3RzZoZ0Zs?=
 =?utf-8?B?V25DNWJtR3p3WTMyK1hSdnRGUU16YURSRS9IMzQ0YmNnYXFBcHZUQU1sUWFm?=
 =?utf-8?B?b05PZXVna0xOdjRReDFaVEdoVFpibTBVWFJpa2FFSjlhb2hhbE9Kdk9QZFFn?=
 =?utf-8?B?WTJ1Wk5QWGlMKzVaWklIT3F4cVNFSjl4TUpXQVgxZ2V1Nmc4OW1UUlFveVd4?=
 =?utf-8?B?bEZSYzBxdjVkUGhWU2k1bktSZVFwV2NNOG1NUmY3OTEwaTluR3lqajVrQWRT?=
 =?utf-8?B?VkF0NzRUTUIyQldwUDlMc1lFWXREYldEa0lzU240UjdHajVkUHRSYkZDN2tK?=
 =?utf-8?B?UkVrL1cvSG16SUJhUFBOZDRFdG1qSTQzQXlsN1FKdHh3RVFMTUpSVXRhcVRa?=
 =?utf-8?B?Z3VpVHkxYit5am1waDZ5MmRXQ25mSDZkWFg3VHVKbWlVRUIwY0pROElkemJu?=
 =?utf-8?B?eUxTakF0NURQQ2ZuMG1TbXNIc1F4aHRQM1p6azY5Mm9oa08yRENZalJUNXZW?=
 =?utf-8?B?ZkFDeEU2ejM4S0IrZ21JaUluWlFMWEtYTnBNM1JZbnhBMnk1OW1LakxmU1NU?=
 =?utf-8?B?cklBV0lJa3BNOWpGUkFiVG0vZHJjTG8zdEhvQm5MOVJPZmhzMkZaTncvUHVo?=
 =?utf-8?B?YXNYSFJjWDFTbXJGMHdnNkxHSVZqM0VBUkR3cVY4M1BFMjZ4c2k5M1V1UkV3?=
 =?utf-8?B?bFU4Zk1teXAwQVZwV2ZvdjBsS3M5NVIrUktWdnBGMlozV0FGYTFEOG9MSGV2?=
 =?utf-8?B?cmp0RVAxOEZCSGd3d3MycDYzM3dGbFM0b0MvaEtzODlJQnVOVmR6eDZlMFRz?=
 =?utf-8?B?bXlRRHNpbmVVVEprZzlHUUd6WWRoV3NZQnVWcHhyR3h1eldDb3Y2UlhTeWdO?=
 =?utf-8?B?Z1dxa1BFbXdsNDdaaGdRVWxRUzFQTURyWjVYTVdPeHRJS2QvMmo4VXhCMWRm?=
 =?utf-8?B?S3N2YkZkcUVFR0FvekpDWHh1bE5ncXNLUU1nMDdmTXUwdVNseHV5b2k2Snpt?=
 =?utf-8?B?clNNeVBjeTFQTTNxOFdlYkRFZjZ0azVHeXlpaHQwdlVlWGZrVm10Z2Q5dC9U?=
 =?utf-8?B?Y3BNZzFHa3VXSS9IV1d6eTl4U2g1ZVBNWVo2VWlUQVVwaDhzWUs4U3pkdWha?=
 =?utf-8?B?YjFqT0hKUmZ0OVVmTldrSW90Nlk4bTdWUndVNzJRNVZkaURraUFZeFpGd05i?=
 =?utf-8?B?eDJzaVdnSVpvejRHaVJwVGRLUTY1cERyVld1dWlxN01wc29ZMWNGaGdHVmR3?=
 =?utf-8?B?dkVNQXVDMEl4dWxRRjRZNk1NbmhCSEpvcHc0R2pRUkVMNG13YkVSNHpXVkc5?=
 =?utf-8?B?WjVhMm51KzZ2SjJtM3dZSngvZUwzbGJ6YXBORjVWSWptOEUyQ1JERkNxQ01H?=
 =?utf-8?B?TjBpLzVqQUQ1RHR1S2lEWGdiQWN4VmljaTYyeUdkWWdFWjgvV3A1QzE4KzMv?=
 =?utf-8?B?V1o0RGI0Uk1JL0ZJSDBBZUJRZWgvdVF0NUVGWFNicEowcEtvYldrQ2tnNVBJ?=
 =?utf-8?B?QzdXUyt6MjB1WGtnSWU2WEJlbnlXenZxZEVFVXJmMjY2T3owWHFhdWJ2Rnpq?=
 =?utf-8?B?ak83WlY0MXZvSEVBeGZUK0hXVG5Cbm12c01BalpHb0loaVVmc3hhUHV0aFUz?=
 =?utf-8?B?OXEwUUt0OE9yRXJ6aWpRM1hjaUl1TmtLL3FtMEpZTVVaaG83MHp4U0RNaEdK?=
 =?utf-8?B?Q0tnb09yc2xsL2daMnAxSlFZUzI0QzBMZ2x6YkxsRTJjcWhUcDd1dDNkcG9o?=
 =?utf-8?B?Y2RMbzBGcXJ0WnpkMUk0eU84RzNWUTRkRjR5ZmpaWUNEUVZxUGxCQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCA1F95E7DA1484A9A592A6EFEA1D13B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ecCTP0tF4VpwnVak+Rl4P1gHlGjY2j0pe+MrdyoHO4H7JCMQs9/i9/CeFYPyGj0xUIh7d9rxemhdG9nAtJM3TVSR0BT9XaLgtYg4RHp64odbBVgW4DNiR7cIiBehWqqcrFNhZrErwMDFMVFI3RZPoG/Tv7Kh1x5aDr6vRE/MhFE90r8np2k5iWKzanjpTVh81Vr8aulrR24rc+s0HnipAemE80iH/EhZ1RpU1IU6g2RuwpAjhBEdEFygz/mSad1blKpJxQv9NDe84kJX0H++TN/4xv2ose4jGxWVXzrkSKqhg+vwLTnUek2WU5weBKutJ03ANynPcVNHk64J9xLOjw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c3aab6-6f2b-4a2f-0008-08deca885080
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 02:46:34.7815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ELF4kA0jt8cva3FYDfwbxr3IWCR+wLY0CTilOePxzKgEjun9ot1JpIQf28BBFOYLMHKmNIUWr/44L65+Fy55Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9937
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTEyIGF0IDE3OjAzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBSZW5hbWUgdGhlIEtWTV97RyxTfUVUX1NSRUdTMiBoZWxwZXJzIGluIGFudGljaXBh
dGlvbiBvZiBtb3ZpbmcgdGhlbSBvdXQgb2YNCj4geDg2LmMgKHdoaWxlIGxlYXZpbmcgdGhlIGlv
Y3RsIGRpc3BhdGNoIGJlaGluZCkuICBIYXZpbmcgZ2xvYmFsbHkgdmlzaWJsZQ0KPiBBUElzIG5h
bWVkIF9fe2csc31ldF9zcmVnczIoKSB3b3VsZCBiZSAiZmluZSIsIGJ1dCB1Z2x5LCBnaXZlbiB0
aGF0DQo+IF9fe2csc31ldF9zcmVncygpIHdpbGwgTk9UIGJlIGdsb2JhbGx5IHZpc2libGUuICBB
cyBhIGJvbnVzLCB0aGlzIG1ha2VzIGl0DQo+IGEgYml0IG1vcmUgb2J2aW91cyB0aGF0IHRoZSBo
ZWxwZXJzIGltcGxlbWVudCBuZXdlciB2ZXJzaW9ucyBvZg0KPiBrdm1fYXJjaF92Y3B1X2lvY3Rs
X3NldF9zcmVncygpLg0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+IA0K
PiBDYzogWW9zcnkgQWhtZWQgPHlvc3J5QGtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFNl
YW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KDQpSZXZpZXdlZC1ieTogS2Fp
IEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K
