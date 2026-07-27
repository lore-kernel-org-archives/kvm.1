Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36471435528;
	Mon, 27 Jul 2026 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177230; cv=fail; b=mIoJ7J49ebVSRrHVUPpbZeA15EMhuXd01Vlt9CvthijWwHctFIghjjlNoDMAvBICZoO7hf/c5TUvtm9AMVsf7an5m0mL4fuZ9kXG5p2yYotZNGMB3KUnnZcdJUPrWs7SfsBUNx2Ii/HKz+egr1ch1BnNYKFkxyBFl6pF5cDlS68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177230; c=relaxed/simple;
	bh=e4IlhJRi4Ii2tlYG/swM9SKrQLXrG3mmcugOyQcJV/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qhdh0m9lnJkBJCJnFnL5BcJEAzMn9wxcCiDhimdNYpvlCH/yr3ReVQ1Xhz7O5vm4mqTAB/stTImWFbmjHCoOPPNuO8qPrz0v5fC4PbrseXXYbuugjz1yjfNMQVRJD1TVvA+uChEjvO2Y8yuKTp8XIIGEnWFojoSocaESrVOUIWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgksUTIz; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgksUTIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785177227; x=1816713227;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e4IlhJRi4Ii2tlYG/swM9SKrQLXrG3mmcugOyQcJV/U=;
  b=RgksUTIzDfsUCI2pnSWPDRDWqIh7c3S0Fol1YacvdTbiKujRqKcIlHUu
   C03hlRGNAb6AMecBOqpoRoDz3M8jZmTh41PavtItqoG9ScZYV6ubqk+MU
   j1dWWx0WyMK7Kl5LScCA2P2BDW9ZXZqgf9WUVbN3O+DVaOWybKTLerpgD
   npqAgy673V+1DTGKnJSXKI+kxb7vnYbuj/uI3+QOJo+as+CSTsYESeIzI
   qb5VfOz2Dl7lb+ZzdTOky5qQK8I+9Ew91Xg3GknTFtLSzyl8e35uzPw78
   gP78FX5tglHCvsAGDg6SZVWkHcgfrRDhMK+qm0S/CJnk5NsrBNDs6sbBn
   A==;
X-CSE-ConnectionGUID: B0YgTv7cT4+hGa4Zls7A/w==
X-CSE-MsgGUID: 2Z9t8jtmQQCEjLVJquQykw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="88291559"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="88291559"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 11:33:46 -0700
X-CSE-ConnectionGUID: nhkxw/xSSve1/OleshC4yQ==
X-CSE-MsgGUID: 75HGcuQzTL+qrpoBjX2pkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="255546560"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 11:33:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 11:33:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 11:33:45 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 11:33:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu9tqHIrnBbqcLOiZPTm8qOULyTW9It5p+vi5Gas4sETE82fHM5uJ1c2I3ySrnSrBBVhzRR/qczitv7jkkrjpqlQNayduUSd9ofXLdXCX0JccLOZqpws684MePtt88DDsYxd/z6N71FKcKEK8VBRG656XW3z/diOzJpC1LWeJWPBRGOnLmwK8mY1r9ZbS01USmZrI0WlXVjgXjmaj6s/rcjkQ/vjkXYYy5CKxg2iQE4FvF9sjXiDZNjgp+KjiLHnAm4LwEEoB+Fq/a2cs9QK4inQEjCSYxUpn+Yoo5ihCC/ni7bJX+qh8yxhYiKo1Fb+yvZ7XZD5TEHob0Kk3PWwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4IlhJRi4Ii2tlYG/swM9SKrQLXrG3mmcugOyQcJV/U=;
 b=MG4sTLlOwVJCKC/DIfLDnnMAfe4kAU/l359MDWjywwiF/mW4bxLDv0joZCg003zM+nnyea+Z870bek4NslM427AN+PnyPiY/F3E82kr7uJaFh4ZwXmrbcg3kMuxpOUKT9LKnVmkiX5Odmugiz83XlEU7Tk3M9M8RD9bCSQh8WfrLx3DNMS4rRltTNmmPgUeGy15cXbxLY3VX9qMqXRJbU6AhpHa2Fj9RrSZ0ZEIkf6nrKj7T/To6EXweSQhSSTpdiDEV6nay87BvMqjzeqOojJX5JW5K0gWA+pxQFiporsHG3iPKB7UIcxX8E8sL3DiAQRvoshtNH9/9bVDqkE3ecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by BN9PR11MB5260.namprd11.prod.outlook.com (2603:10b6:408:135::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 18:33:42 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 18:33:42 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Maloor, Kishen" <kishen.maloor@intel.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>, "Fang, Peter"
	<peter.fang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCH v2 12/17] x86/virt/tdx: Reinitialize the Quoting extension
 after TDX module update
Thread-Topic: [PATCH v2 12/17] x86/virt/tdx: Reinitialize the Quoting
 extension after TDX module update
Thread-Index: AQHc/v4QmVbl6qxKJUmvhbhyuXxzeLaB79KA
Date: Mon, 27 Jul 2026 18:33:42 +0000
Message-ID: <f565cf8120c92f71968ac97f7535ada1a00d8410.camel@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
	 <20260618081355.3253581-13-yilun.xu@linux.intel.com>
In-Reply-To: <20260618081355.3253581-13-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|BN9PR11MB5260:EE_
x-ms-office365-filtering-correlation-id: fcab45bc-ba6f-4054-0dc6-08deec0d95bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|56012099006|5023799004|6133799003|11063799006|10067099003|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: SVrtcXspmAPz0YtWz2YDqg3WiwmnjMIpmYnqN76HgdZPPrUS/7S8fy1cwkR4T/7bPIf6PZ3srLEeft5j3OyivON9IAjH+M417yHfoFlwIbeqNJdC5zyjyylDgqlE2kjQX+PpjmC9IjGiNP04/22KlwgRW2g1xt/hLu+SE36b8wP+6aT1bjeboCpICJwByw2qqodRUgTerinOkoQQCik9H36z82KFr5xmg91hDCKiLdYwIQ7nguDxT/q0Y33b8ZgEYlNCzCXUO69hT67yl1b+QexXHI/eEY5+qz6QkmqyHOD/zntvsG4gaYoPHlJedb+/gJ1//cAiqApo8fIrshrsxAVvjGmPE06GP5ZbrmNi+v88xlIsVFrsAguu3VSzAzEAKS0DN+S/RwJynFPRV5H2KIZSxHdLtBkeHm53CbOZu52Sf3XSkjztXX306gRSjaHe05oYNJ5zT/739NL+Ip5j8evxAy4fLaUwuEstSYMvuwx+px74sFpX1vvVyNbSBpnAfItkgXzc1NHZjZS9Q2SQE1+z5ritCwpGD8xpqqPojamCSO9SaOCoqg4skp5zcVhqYJS1Kg3oEuErbp09jJu9AVtMM3xOHVRb6Gc3Zzjfl8+8RG3qZRwMbP5yiBw02qn81tsHKy5hi5vLsaM/Up6bNwAzt6FqvnvMc7+stSiYI+UzsItEJhefKH3yEHIgWIIiieN7XZQncoIMyi0xYoFXYVGGkk5Rx5xqOwgYw+OvFUo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(5023799004)(6133799003)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVRGTmNUVExMdXVENnFqRFpTMjhPUlV6aHRJbTR4VllJenlpUjRnWi9sbDZt?=
 =?utf-8?B?ZmxweTZGTHhYbGpjanlzYW1FRlMveXRGaldkdnREUFp5NWdNK1BCVjFQYjR6?=
 =?utf-8?B?bnE2UXJTenVSV3BMRmwwR1VuQmg5OGNvKzN1bmtKSjBwSVQ0bW5FSXVNQlN6?=
 =?utf-8?B?TjNSNE5qV3FkZDZubjUwZnpjMDBiOWYzb1JVZ3ozSExpUGtUeU40bjB5T2FS?=
 =?utf-8?B?cm83MkdlS2Q3U2hOQ0hCbGdPWG40Nnp1UEpPNFlqSUZQN3A0UElEd3U2dUpO?=
 =?utf-8?B?T2ZyY0d6UjdwQzQrZWN4cVpqMjQ0WnA4NjdCSk5Ca0pWNkoxdmxvMDJoQUlx?=
 =?utf-8?B?NmFDUzdyS3lLc2ZFbjE2KzkrdldyK00rZUhsUXFpRThxVU41b0F1QXRBWEZy?=
 =?utf-8?B?bWtWb1RHSGNmeWVHSkg3b0F2SEFuZnBFN1IxMGJpdUZSZWtMbGROS2xFRkxM?=
 =?utf-8?B?a2hQSTJUUVlRMjZSVDNZSGhqb3RvblI1eXdob3ptWWpVQnNzbXFXVlVVTjdN?=
 =?utf-8?B?WnRpSHcveEw1V09PalBJckhHNjNwL213MnFQT0ZMc2ZUeWNPZzhReG8yN3lG?=
 =?utf-8?B?UlVVNkpYNmVBT0xaZitZUDhlaFFSMUY5UXBiVjQzdWRWUnJJa0tKandKZTRo?=
 =?utf-8?B?YlR2cytxYVg2SVUrWCtENGV2dXRndXo1TXlvcXp0RUNvZVpqcDFqK0RYMzMv?=
 =?utf-8?B?Ly9qcFFCQ3FSaTNrSno3UFE3WkJpL0dTdGRNOHNOUkVPTXlQcktjUGNEOWc4?=
 =?utf-8?B?SHh0RTY5YXF4VFJ1M0R1Rm50eU53cWJXQ0xibEFoM0oybEZBQXhGZXVGVThZ?=
 =?utf-8?B?emc5ZURCMHpUakY3K1VYWU8rOW9SRkRHRkc5L0tWazJJY3V0KzBqTlVzT0U5?=
 =?utf-8?B?RmV1Q0pnWktuQXVJaEdrVFExSXRZdFFydGNubCtNVUZ3TGFRcS9TU3VHNi9v?=
 =?utf-8?B?cnFRTEo3aDM5OFcyTEVwRFA5NDA4UGtxNnJEVmJkSmF1SldzZ0UxdmdSRE5u?=
 =?utf-8?B?S21TOC9ackFWZElrUldVR3Q2Sm82dUZUK20zMVgwN0hkZGpYZCtOTW9oTEY2?=
 =?utf-8?B?aVlHYXcwci9YR0V4aVBIaW5XaWdta2tsL0xqNDUyNDBMV1RHU1FvaGVHemla?=
 =?utf-8?B?VTlzb0JxTVkzc0pLYnd4eS8yT3ZVeGtDQzc5RGNRb09WMHRlRFhDZUhFaWh0?=
 =?utf-8?B?L2JOYTVlZlpiL2NMWVo3VXgxOFp4KzNJVGZVZTFKWGhyYmVJeWpaYmpnODZn?=
 =?utf-8?B?Y0haU1RKckNvRzE2aEhidnpIdjB1UC93ckY4QXhvOUcxZHpFQU51SGR2a1Fj?=
 =?utf-8?B?RzhmbmZxb2hRNmJ3UEl1MytLcUF6emV1OExTNlhsVThRVE51RGRxc0ZOL2M2?=
 =?utf-8?B?b0JvYUljSlZCM1QwL2tON1FiTHBrS3MxQmRHNlJGV0lVVUQzcmgwQy9XWURI?=
 =?utf-8?B?MmdxMUdMa1pHVmVkWC9haEpLdU9CTEdYeGhrMi9LaG1reS9uZm5RdDk2VnZx?=
 =?utf-8?B?TlllUks4VVFZRjFmMlRHcmRXQXpUamFiSHVLT3h3clZGSlNXQjBCZFNUKzIw?=
 =?utf-8?B?M1lqN3ZQcFordExtL3RYQTdaalhUUzVJU2xiZGlpT0p0WjVSRDFLS1IyYTZx?=
 =?utf-8?B?VkVXSkxpaXZUaWtwbXd2Yk5YUW1jbWIyVWw0akFlK2xZaEhNVEVLK1hhaHoz?=
 =?utf-8?B?WWN3ZlFLWU9NRWZBckx4UTRiYkcvQWNjQ0RxRm94M3JzYnYvakEzcWxzRWRB?=
 =?utf-8?B?RVp6NzMzMWdYYVVvRC9jeFRueWlkSFZhU0tiZFpONlk5dmxOYkM4OHVOemxE?=
 =?utf-8?B?WXp3aVlqcDBOVDNaRGtrM2VwUytOZHNDK0VCN1loTE4vUDhUMFFkb25oSm1z?=
 =?utf-8?B?TDBSbHk3ckk3RjJwTXVuSGVoYUhqSE52WGtlRU04Wnk0eXFEQXhQOVRyQnow?=
 =?utf-8?B?dkt3YzkxZFpLSXVFNExYQW5LSk8xRUo0VHZlMmdtbE1DaytjRU4ycVFDbVN0?=
 =?utf-8?B?dFRlRFJKYXp6ZWlON0U4NGpwYytjWlBZaE4wRWkvLzFFOUZ4MjNIbzBQWkF6?=
 =?utf-8?B?ZVl3cWkzTE1OdnZDQTFCWWl3U2NZaWFLUzRPRStFY1FoVEdnQXdXKzdSclY3?=
 =?utf-8?B?a2c1bEY3NkxFYnNXVWhDWkNaVitxUis1bVA1UkZ4UllDeHk0bWZzOE1yeHU2?=
 =?utf-8?B?cmNVUSsyYmU2WFVOSEhPT0dyVjRRR1Y3dXk4YTk4bzJieVRrZDY5TEZnWXRD?=
 =?utf-8?B?RHZhMHZPVVRoN3NPai8vazQzcW1zUG9Xd3pLdklKeEtGaGo5M3hvZWF4ZDNG?=
 =?utf-8?B?RjBld1lrRW91a1RVeEswY1dFKzFpNjJOSlh2M0gwVFMwNGNqbUp0b0R5Y2lS?=
 =?utf-8?Q?YJ2TI0PtFjjbDhPQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AC22BD3734BDE49A5F579DDC8B23A02@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iGDyR6nxrOX0hPtjHkwYRf+ATcG7F23uSesEq2ImTxqVLRZ2TsV4tYRnrg8T2duPIuQ9U+wL8uNmpJG16iZxj4BLDPFog0fOjurDEgh82xZSJcTaX/K1UmebOlfjWQCFaQxRx83+qlom40UOD9GBEDD5yPxu2+hZCoziNEhmWHZCFYVIcvHR58fdtioLaxD5OurRPdKcInbo6PTLCqDG/B84eNXnBZIgBsOWeGqbUmb11WlSDWaQFkQcc0N3B/dWur4TpaTXio/5lwfdSO4Emdw2pLw6t5EB/OiVXLTzNp/XNU4oHNb+KeGPPPOfLlfcXoeIdhCnlGIZjAYGDHoUUA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcab45bc-ba6f-4054-0dc6-08deec0d95bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 18:33:42.4095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mn6dMR6S1VDWH1mQAkeaM6v0DnnqdnCgsRx1WgKVRMzofxI7ZZmwICZfvVtjXnhK1arrhGfWuoLBMGgh0ahYhnwRH9nIJ34NQ6+quQJ2gFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5260
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTE4IGF0IDE2OjEzICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gRnJv
bTogUGV0ZXIgRmFuZyA8cGV0ZXIuZmFuZ0BpbnRlbC5jb20+DQo+IA0KPiBJbnZva2UgVERILlFV
T1RFLklOSVQgYWdhaW4gYWZ0ZXIgYSBydW50aW1lIG1vZHVsZSB1cGRhdGUgdG8gdHJpZ2dlciB0
aGUNCj4gbmVjZXNzYXJ5IHJla2V5IHByb2NlZHVyZSBpbiB0aGUgVERYIG1vZHVsZS4NCj4gDQo+
IEtlZXAgdGhlIGV4aXN0aW5nIFF1b3RlIGJ1ZmZlciBzaW5jZSBtZW1vcnkgYWxsb2NhdGlvbiBp
cyBub3QgcGVybWl0dGVkDQo+IGR1cmluZyB0aGUgdXBkYXRlLiBDb21wYXRpYmxlIFREWCBtb2R1
bGUgdXBkYXRlcyBtdXN0IG5vdCBpbmNyZWFzZSB0aGUNCj4gUXVvdGUgYnVmZmVyIHNpemUsIG9y
IGFuIHVuZGVyc2l6ZWQgYnVmZmVyIG1pZ2h0IGNhdXNlIFF1b3RlIGdlbmVyYXRpb24NCj4gdG8g
ZmFpbC4gU2VlIFsxXSBmb3IgbW9kdWxlIHVwZGF0ZSBkZXRhaWxzLg0KPiANCj4gWzFdIERvY3Vt
ZW50YXRpb24vYXJjaC94ODYvdGR4LnJzdCwgU2VjdGlvbiAiVERYIG1vZHVsZSBSdW50aW1lIFVw
ZGF0ZSINCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBldGVyIEZhbmcgPHBldGVyLmZhbmdAaW50ZWwu
Y29tPg0KPiAtLS0NCj4gwqBhcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgfCAzMSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdmlydC92
bXgvdGR4L3RkeC5jIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+IGluZGV4IGFjMGRh
NDk2NjY5Ny4uODFlN2I2YjFkYWNiIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni92aXJ0L3ZteC90
ZHgvdGR4LmMNCj4gKysrIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+IEBAIC0xMzUz
LDggKzEzNTMsMTEgQEAgc3RhdGljIF9faW5pdCBpbnQgdGR4X3F1b3RlX2NyZWF0ZV9idWYodW5z
aWduZWQgaW50DQo+IG5wYWdlcywNCj4gwqAJcmV0dXJuIC1FTk9NRU07DQo+IMKgfQ0KPiDCoA0K
PiAtLyogSW5pdGlhbGl6ZSBxdW90aW5nIGV4dGVuc2lvbiAqLw0KPiAtc3RhdGljIF9faW5pdCBp
bnQgdGR4X3F1b3RlX2luaXQodm9pZCkNCj4gKy8qDQo+ICsgKiBJbml0aWFsaXplIHF1b3Rpbmcg
ZXh0ZW5zaW9uLg0KPiArICogSXQgYWxzbyByZWtleXMgdGhlIFREWCBtb2R1bGUgYWZ0ZXIgYSBy
dW50aW1lIG1vZHVsZSB1cGRhdGUuDQo+ICsgKi8NCj4gK3N0YXRpYyBpbnQgdGR4X3F1b3RlX2lu
aXQodm9pZCkNCj4gwqB7DQo+IMKgCXN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgYXJncyA9IHt9Ow0K
PiDCoAl1NjQgcjsNCj4gQEAgLTE1MzksNiArMTU0MiwyMiBAQCBzdGF0aWMgX19pbml0IGludCBp
bml0X3RkeF9tb2R1bGVfZXh0ZW5zaW9ucyh2b2lkKQ0KPiDCoAlyZXR1cm4gMDsNCj4gwqB9DQo+
IMKgDQo+ICtzdGF0aWMgdm9pZCB1cGRhdGVfdGR4X3F1b3RpbmdfZXh0ZW5zaW9uKHZvaWQpDQo+
ICt7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCWlmICh0ZHhfYWRkb25fZmVhdHVyZTAgJiBURFhf
RkVBVFVSRVMwX1FVT1RFKSB7DQo+ICsJCS8qDQo+ICsJCSAqIFRoZSBUREguUVVPVEUuSU5JVCBj
YWxsIHJlbmV3cyB0aGUgcXVvdGluZyBrZXlzLg0KPiArCQkgKg0KPiArCQkgKiBBIG1vZHVsZSB1
cGRhdGUgbXVzdCBub3QgaW5jcmVhc2UgdGhlIHF1b3RlIGJ1ZmZlciBzaXplLA0KPiBvcg0KPiAr
CQkgKiBxdW90ZSBnZW5lcmF0aW9uIG1heSBmYWlsIGFuZCBicmVhayBhdHRlc3RhdGlvbi4NCj4g
KwkJICovDQoNCkl0IG1ha2VzIHNlbnNlIHRvIGV4cGxhaW4gd2h5IHRvIGNhbGwgdGhpcyBhZ2Fp
biwgYnV0IEknbSBub3Qgc3VyZSBob3cgdGhpcw0KY29tbWVudCBoZWxwcy4NCg0KPiArCQlyZXQg
PSB0ZHhfcXVvdGVfaW5pdCgpOw0KPiArCQlXQVJOX09OKHJldCk7DQo+ICsJfQ0KDQpTaW5jZSB0
aGUgY2FsbGVyIG9mIHRoaXMgZnVuY3Rpb24gaGFzIGFuIHJldHVybiBjb2RlLiBQbGVhc2UganVz
dGlmeSB3aHkgbm90IHRvDQpyZXR1cm4gYW4gZXJyb3IuIA0KDQo+ICt9DQo+ICsNCj4gwqAvKg0K
PiDCoCAqIE1vc3RseSB0aGUgc2FtZSBmbG93IGFzIGluaXRfdGR4X21vZHVsZV9leHRlbnNpb25z
KCksIGJ1dCByZWplY3RzIGFkZGluZw0KPiDCoCAqIG1vcmUgbWVtb3J5Lg0KPiBAQCAtMTU2MSw3
ICsxNTgwLDEzIEBAIHN0YXRpYyBpbnQgdXBkYXRlX3RkeF9tb2R1bGVfZXh0ZW5zaW9ucyh2b2lk
KQ0KPiDCoAlpZiAoc3lzaW5mb19leHQubWVtb3J5X3Bvb2xfcmVxdWlyZWRfcGFnZXMpDQo+IMKg
CQlyZXR1cm4gLUVGQVVMVDsNCj4gwqANCj4gLQlyZXR1cm4gdGR4X2V4dF9pbml0KCk7DQo+ICsJ
cmV0ID0gdGR4X2V4dF9pbml0KCk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4g
Kw0KPiArCXVwZGF0ZV90ZHhfcXVvdGluZ19leHRlbnNpb24oKTsNCj4gKw0KPiArCXJldHVybiAw
Ow0KPiDCoH0NCj4gwqANCj4gwqBzdGF0aWMgX19pbml0IGludCBpbml0X3RkeF9tb2R1bGUodm9p
ZCkNCg0K
