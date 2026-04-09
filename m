Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF19E3AC0EC;
	Thu,  9 Apr 2026 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775726944; cv=fail; b=G3EIz11YDATWvPxiv6ec9ABLEmy8coVWjP7MdE8YCXbQVEfvLf2Ekt5//MuPNvp7DwkbLK1q3e403QSWLamoLgAxs8QyJCO2nQzMATT5Ve/pmEUKaUY/fRyZbAvjXwxwGfLtXQnihMh16H6sQxGDV4W4Vzae3MF7/j4qRtmM5GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775726944; c=relaxed/simple;
	bh=L7cePsyjY3r1zxczUI9Udzk98Ez0Xwfom0f4z6VJcis=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=togPlrUXqhQw2hL9B8jb25IL0mxreSdNdM7AzahQw5Kfhx0+6ZTX2F6osY1XxG7ALi2o/3QVJ7mqq0t/Lwq+0IKfZdzRcm1AxTfcyp3pJ+wmqCUZIbI4URTkq5LGpb2P/3lo4lDUwlDzeElYvH+QBJEEiytdiZvq8d8XNgiWR98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyRhMRKE; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyRhMRKE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775726943; x=1807262943;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L7cePsyjY3r1zxczUI9Udzk98Ez0Xwfom0f4z6VJcis=;
  b=cyRhMRKEg+h1Bz8IZcJU2xDZ3H1ufA2MotkHelOqj8m/dwRJKsUKJdas
   8CFbpW6eZcS8rKsqYqXBza16dO60CPnrm774K/1hyW5Ozp6qvniXdg6Qu
   EpuS8hwqe0/KtFhcl8yOCUbLRKsGdNeb1J++g4RNwThVgRzJi9OQheeRl
   tnRY0pkCunpPfC1i57/CyE+jYHr3pjB0ev+68bNKQGZqwMg/gozGxMC92
   tPYPDfbCzmSPeQnSWkDV95iO/3cUnHpJREXSDsBlh43O+ICu8BBh7sUor
   T05k9ES+DDdfbglKjfHpJGMlEXv0JK8RKOJQ2Nd0ll5c+ulY+EyK57p9Z
   g==;
X-CSE-ConnectionGUID: mJVN+YQ1TqqUH9NPIi4aaA==
X-CSE-MsgGUID: sq39/DaoTCuqhxOepTvJeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75899062"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="75899062"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 02:29:02 -0700
X-CSE-ConnectionGUID: qA/F5PRHQOKBZefwDMu/og==
X-CSE-MsgGUID: PeLs7fHcQgK7+/afR9hVkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="224415780"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 02:29:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 02:29:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 02:29:01 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.51)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 02:29:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ly7KOmGehs3ArKBime/gJMrylvpXrbl9FpGPqz3myLihF1bhKYAiASGscAgYcQC9vBOWLss35HQkIvNzNXnIczvLK8Wb6ZRptpm4iAdvGnCj+ejNl4ZTF6ieVii0pdggFSF7S9GfShAguTW2Zu3XkrPmRYPtMhUnTzBC6ExHIqz0yXm5ZcStFOExxERj3ZXK7JUrrsFHR1nuGybqgLZE9Xd92m2yp6+qKc6332ywMqsn9x6rKTR0msUdswc0G59CV2xg/XRIb/rl7eT5727yT8CWlRcAvJuNfORPdWDl3anDSCVHHqxfty9Ptret3ThRiXVFuyCQhcY20SKfLM8+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7cePsyjY3r1zxczUI9Udzk98Ez0Xwfom0f4z6VJcis=;
 b=aNp79Yq0+0Uzpzzmy1GT8xWdGi8eUhDqhokLefDStW/SGIfIv1QIVHsVLP3Ta62ajTlaUTGCSeN6qGxWf31S35FDR42nRYQIKMKyZvxWNEN1Yoxjvqu+lDYwLxo4el5lnDl4g2D+9ep6dETNOZneRu8evjhsJTDWXUlgY2Nn2CrCTmX1aDIAwaWHnrGFA1zIzKrEd5dYQdm2H+42XHpYMcRkuXi9hWyk3EcQXoQ8+c4TD5v3eSKS2NvoveDbFTYUbbVMJJwh8T67fZ9hwz2AhkWkczXqdqyN+8xUc/4Q/YS/Mqaqjkn9JidFtq/bdtzlFpR2bcKIddlcPXB3SkZTcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB6742.namprd11.prod.outlook.com (2603:10b6:a03:47b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 09:28:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 09:28:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Winiarski, Michal" <michal.winiarski@intel.com>, Alex Williamson
	<alex@shazbot.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer
 Kolothum <skolothumtho@nvidia.com>, Niklas Schnelle <schnelle@linux.ibm.com>
Subject: RE: [PATCH 2/2] vfio/xe: Add a missing vfio_pci_core_release_dev()
Thread-Topic: [PATCH 2/2] vfio/xe: Add a missing vfio_pci_core_release_dev()
Thread-Index: AQHcx3FPyyZmjNsfFE+5w3K3wgNfWrXWd4Zw
Date: Thu, 9 Apr 2026 09:28:54 +0000
Message-ID: <BN9PR11MB5276C351790DFDEEA56FE0868C582@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260408160340.866784-1-michal.winiarski@intel.com>
 <20260408160340.866784-2-michal.winiarski@intel.com>
In-Reply-To: <20260408160340.866784-2-michal.winiarski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB6742:EE_
x-ms-office365-filtering-correlation-id: b9526da2-a95a-4eab-a175-08de961a6b1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: hN61zMEWMpeslYm3JB0z8BoyELgoMoyATJV7LjCkLxinVpp23VccwRyUqTpsEiGKWBat+t81IwipRhJ0eocI9SO/m0wpq/Cl69ZW1aE5xQ/A3rs3/T6rA4kTZ0RIQoFmKWRUV6escU6068RG8XJ7Cuu2vpXus+JHaZVGmeGnYYWFBdJE1nTcHyIt3n10RiU1J9zjvRiyJOKjbV/D4MylGBuFJI+81EDsIL//zl5GcFgcKqNHVO5Jy6atmED4qB6X5GLFTzO3EsR8Y1eZO0Pzh+GU2338u9QHGMfw0kWM5ZsoOkrRY64Lk+zXy9qGQfigIWNCsdienxzHgQfnHr/5o4sBQLeQ2UqAwVufkpW4moyvQaeI9kwAQSSeTeNJ1nAQsAvB3/vAKmhFq6uVy4kvNIPp84V/VY9dHjoma7XfrOZZ8ItjnMG3VLxpoJX2+OUSbu54lumsvuqtruOU4tEzc2+KbnJCY73xvgRce+5aFiyO2CTgNjL0ElL4/Qq5xwaCxPximbH+TtFfpE/4o3sSNJ2+8bGJuVz2WSVqb08X6L/f8K94xdN/h64/pzO/30GBKAQVzsLCJeWjglY2Y90hlwO2H45Hbrujt57nRLKs2lN0Xj1lE83mMom5BXx0PZ8OMKuRQ9grDRQYpPIhD3Gy/kYEmLPKkxhbgM9uBm55tp/L+Pg2+FUuMbn4EcyRv2wH2MKrzu5ZecX98HYagxhMbO6bOFzTCBHL5z6Et2AHKbRIG/ah+vSL9+5xoyYQZ17j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajZnNmd5WHBRbTRwbnIvY0hQOUJacVV5aklZU2YvNUJYME9DV3hnN3NaUHAx?=
 =?utf-8?B?WVVuTWg2ekx0N3FHSzlBWHF2RFZrcDcxRS9LbHFGQnRXUkVLU2EwUXFzRjZF?=
 =?utf-8?B?THZ0a3N4cEtRZk1iQ3NINERDSGR4UGFuaVY4ZHBKSHdYS0M3MU1lNmwwMjQv?=
 =?utf-8?B?aWZyMFhTUzNUVEFCS3ROV0ZQM3h4Q1hzL041S3Y0K1NpY3ltNk8rbS9UR1lt?=
 =?utf-8?B?alJkYTNzNjhnZ2s1aDUwWi80RmNuTjh4SUtGL2llNHp2L0NkOVROajhSNFhZ?=
 =?utf-8?B?M0hHMWxJNGloTEN5cHJFV29FQUQwNGtMNGRPM0RsZWhCeGx4eHdTVUhWbjgy?=
 =?utf-8?B?S1BuNndpQ3VhczJlbmdXM3ZDVFBXY2ZjZWRkbUtWQmlrRlgxOXNnTmJKam5F?=
 =?utf-8?B?My9FcFh0OHpuQ2dWTHhiYXc3N0NHVUpEZXFzelAyU1JqNnk2NjB3ak10Zmlp?=
 =?utf-8?B?YlhNRDVaYzd5K285aVI0ZEF4YUU0dFhBWjZOc0FSMkhWckZySFNCQWwyT3py?=
 =?utf-8?B?QkwrTHBHSDJyYkVwcm9rMlhOMlRzcXNhd2F1elhWZEZ1UHZFTXBwazBwWjBP?=
 =?utf-8?B?UUNGbkE0Snd5Umg3em0yVWVEUUt5UnFRYy9zdm9YWWxRYlJrRHpVYUk3UGlX?=
 =?utf-8?B?RDMvNlpyN3pRWVdkTkRRMmorSWRGYVVlK2dzeHN4emJsU0s4TXVzeEltSHpL?=
 =?utf-8?B?MmRqL0R4bnNwc05yeTJlM2FQSDRWeXVEcDJ6d1JUOENjQTE0d01vQXdEV0Uy?=
 =?utf-8?B?YUxJRkVrOEw5NXVHSjRkV1NkdThJM2lNMnIrVkN4Y1JUK1ViMUZQRG5Na3gw?=
 =?utf-8?B?aEx1cnMxY21NazM1ZjA1Q25ySW05ZmhmdC9jdVpzaVU4dW9ndWJhbldnL20v?=
 =?utf-8?B?TVR3MGpFaGRQczloZ1dWc0Z5bWplb1hCVUVEYTdXbGgyTW0zT2E3VDErMEJr?=
 =?utf-8?B?cVhRaGFJQTRFaml3Y24ranptbVNuZExxZ2h4VEtlY1EyRTc4REhuUy9PRmw2?=
 =?utf-8?B?b25ZaldBUDZNWStRa05qQWVXVytmZUtYeHZGdStGOHBnVWRmcXU0VkRvMGdz?=
 =?utf-8?B?SDNEOHhNQ2FDSi9rVncyRkI0Sml6Qm1zSG9odFdXd3FyUUlXUWp5N1FDeUJX?=
 =?utf-8?B?cURzc0szdG1CbWh5UWVObjFFS2oydmxjWWhycm5Cbm9jVjVHYTRTN3U4VmxJ?=
 =?utf-8?B?WGpXRzFWZ3RqbDJSV2YzWStCSjFwN3p3OFlKREUwcjJ1Z2FhSlhYZjdsaUpG?=
 =?utf-8?B?dExzN2VKS1VBaTE0WUpnSTFRN2taNlg0UzF1a1BuSFMwK1pQMW9veU1pYlRh?=
 =?utf-8?B?Q1d0NEhuWFA4SEFlb1BhZVluSGhlcnZEUHFoVHNCL1dQZGFYci9EdWNEdjJS?=
 =?utf-8?B?dDdmSzcvOXpaU08zVllEMWVPOGtNend6bHlqQnlDWWl5ZmZjNG1rS0JVdkls?=
 =?utf-8?B?QUZjKytvejFveHJ5MkpFQk16UUV0M2NiS2RGRFJaRjdsRzVXWHFRQVovSGdG?=
 =?utf-8?B?cHVsVXcyUWF4RUhMWnliaFplclpnYndVT2tRdkYzWEFoTVlUMHZnMFpBZEFX?=
 =?utf-8?B?Qm1sS0Job25idnA4M2tFcm5xOEQxMTJKYkNlY0x0MUhjSjBHM2QycEUwbGdJ?=
 =?utf-8?B?WURlWDErSWVUS1FvZWhlMTJNU0FyTmsrR1YrMzA5R1ZYUnAzam5GNGhCWFdZ?=
 =?utf-8?B?Zk1mVitJRG44R2NBUWRqY1g3cTdoaFo0MXlQa0ExbTZndDhHS0hKM3B2aTBF?=
 =?utf-8?B?ODJ6L0o1Z2VlQVdWOFZuVWdMWEp3cldJUndGenBhNkRGSzZrYnRtaXFMYkVQ?=
 =?utf-8?B?MHg4NWlDei9xcnYrM3d6V09IeE1PTHhwaDI4VWg5SEh6WVJENDV5b2YzNStm?=
 =?utf-8?B?YWluRmtrUTFOaE8zUjloeXZwOXdtY0x6UGhPcG1pRWF4UFdLV2Z6Uk5mT2dX?=
 =?utf-8?B?UFNNd0RyUnN0ZVQ0SmZXVCtDZ0NtYnNlbzk2V0x0OVRndzQ0cWFGbTg5eEFE?=
 =?utf-8?B?VHBaUXRjL1YrSkZ2MXpKUzRVRTV5VVFjZXdWLzdlbytNQU9WWVVYNlpDRnBr?=
 =?utf-8?B?bmZpU25jN01SR0wxSi9Zd0VqK3hlY0Q4bU12V1VuSWN3REUwWXFpcWpJcE5W?=
 =?utf-8?B?aFpLN1o5ZFcrVXl2ald3emFLK1BUVHI4elcwUzZwZ3ZJNENLSlg2TGlPWXhF?=
 =?utf-8?B?Z1Z5WGVpQkJGczVXQ3hacUI1akdpUk8zbFF5dGhoaGI0K25MZ0pDc1NqNWJX?=
 =?utf-8?B?VXVzZ3NXL050Mys5NnYwbjFQTkRrbmpySE9FdjJwQlU1ekc5QURiM2xJQ0VU?=
 =?utf-8?B?bVhJK3ppZ3RpY0psek5oZEMrVENaYjNUMnRkZUdaSC9EQUd0bDIydz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uPq9V0DQwu4KPRQ6kkqlYZt3kT1UqAOgT2LAx6zTTo2w3+lCYrCGjU461QcfGvqHi0j2Z/7HtROyx2lYz08XF5H6VRfuxH71zaG560Zu/dWysNLXzYKNurANPACAe+JTsXtgiw/9cZ23p21c9mVxtuHAWL5uLUz8dpVjE7ABGKZ3VsaIE2VllAqsNytlwsIaxq4m7XEhxCkZV6XMTTBx4YpCS6KEv3gGqHtR52PIXz4xynLPGutNgkHnHCQfrOWy9weMABnrqSZjA45jlvLT9CJFhBeeMBr3Qz/RD9qErhd3wKYhaZNlhHNME4Evs1HSjrb0Gk3wg+KkHVecCKlmwA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9526da2-a95a-4eab-a175-08de961a6b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 09:28:54.2849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJUt8HKB5VTYHqAJwAcmNbD7PCtW6t452hzReyceR0q+cFdMsLeEEo6mFm6+HbmHn0zXdUgyLK8OWZ4+cwD1Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6742
X-OriginatorOrg: intel.com

PiBGcm9tOiBXaW5pYXJza2ksIE1pY2hhbCA8bWljaGFsLndpbmlhcnNraUBpbnRlbC5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCA5LCAyMDI2IDEyOjA0IEFNDQo+IA0KPiBUaGUgZHJpdmVy
IGlzIGltcGxlbWVudGluZyBpdHMgb3duIC5yZWxlYXNlKCksIHdoaWNoIG1lYW5zIHRoYXQgaXQg
bmVlZHMNCj4gdG8gY2FsbCB2ZmlvX3BjaV9jb3JlX3JlbGVhc2VfZGV2KCkuDQo+IEFkZCB0aGUg
bWlzc2luZyBjYWxsLg0KPiANCj4gUmVwb3J0ZWQtYnk6IE5pa2xhcyBTY2huZWxsZSA8c2NobmVs
bGVAbGludXguaWJtLmNvbT4NCj4gQ2xvc2VzOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9r
dm0vNDA4ZTI2MmM1MDdlOGZkNjI4YTcxZTM5OTA0ZmVkZDk5ZmEwZWU4ZS4NCj4gY2FtZWxAbGlu
dXguaWJtLmNvbS8NCj4gU2lnbmVkLW9mZi1ieTogTWljaGHFgiBXaW5pYXJza2kgPG1pY2hhbC53
aW5pYXJza2lAaW50ZWwuY29tPg0KDQpOZWVkIGEgRml4ZWQgdGFnIGFuZCBjYyBzdGFibGUuDQoN
ClJldmlld2VkLWJ5OiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCg==
