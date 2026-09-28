Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E914D2EFC;
	Mon, 28 Sep 2026 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630050; cv=fail; b=D642JmR2pGbMsN84wF8xLA3tGuG2OiDpqercWCUJKdUhtnj0n0mRjnbnRT2TROgRGFW7eC/MGJJoS1IqMsoYQ8d0q4fYbQYt3s2QhuESaUTNV5UwsDQSazQM/89od2A8+6IbLIx4Qvrt9SobIQvX080KNFD19kPH7MGZHBn9qJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630050; c=relaxed/simple;
	bh=2gSchzoIPTxyZuuIGi5LZaKcZG1NPFqV4V82B/jj14Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NyCKTASBIpmlQr1nBzwLYy3V3v6naX/rvt8SCSVkn13wlL99SGnvm2czeLwdHt6FMGA/3BqcIQPgB0XgMr3abMThLj0AEV5ys0iWNu0fWgwyZcNw9Ek8vDlwUFuCSCiL17pfXJzMM6WBCqXGPy6UeZW/YdCCq3ruKjdLYB8oOes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsSU3ZkR; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsSU3ZkR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790630048; x=1822166048;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2gSchzoIPTxyZuuIGi5LZaKcZG1NPFqV4V82B/jj14Q=;
  b=dsSU3ZkRiZnWGvL37y0DjmHr9i4DMNFelDYsVJ38BKuRK57uC3MsplaG
   0uieVRAbRBpLWpqDjhWCtdQrjw//3oiQkOkWpCL9rvyihhRWI0JhZ/tMC
   MeLUDDLQQRZbF+XWw5cpK1OcBFa0cqYluVaYrbroOXBmcZ0O2nI/oM2W0
   4A6rIgoOgVFw/af9N9/5XgjWfs3dteAsG/ThrK7/vEaWd/y/qKwTuAxrT
   bFvuRXhq1PIuePFZ8GDTRRcemnAC9liSEzMa2Gprm4Dhaz1Do1DfIDGK3
   Ed5yDKZV3fF6TmuaF0YR7gawg34idamx2j6ZscOw/YQIYoqyV9vs1TDDM
   A==;
X-CSE-ConnectionGUID: EVUavRSGQHmHpTIJUVzVkQ==
X-CSE-MsgGUID: sUfw4f1TSKWuvQ7M9sx2uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="116868550"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="116868550"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:14:07 -0700
X-CSE-ConnectionGUID: yMnY5HxRQiaHiPXGmI9k9w==
X-CSE-MsgGUID: MTQubGawRR+kcdkhT11hpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="273293017"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:14:08 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 14:14:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 14:14:06 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 14:14:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgDp5qdx5c1uu3DgWsTbKS43OaLa1xdzDRiOn9C9q7/ZJFW34qe3vhNpGxsCMYWzQeafRwHnUMnXbvit38Cw94AwwtMyPh6XACOjJ04i1ZVhN3OUO+gTAYzizGV3JhkVDYzgKPYrW8MG9duKpm/vyl0xKgxtMRV29cWotm/rFThSqIZy22GtOb64ROZ2W5XIjjiWaoThI0S8TJIx3BSDiZpp5Qb/tuahWYL4mh3d9HvBmMnNW0kH7J1kz6KIo0Wf2fIjAdfjCEEL6T98S0bFBW9QtWezWAAd1j/mMbMuMTPKyPNsGHyg18AHwnpDYpFqXcQtmVBD9RFk/i3JVrIrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnB6gPpTgMbetSgskxMXwiXwHfxlvBHsXXX4E4e8pWo=;
 b=kg4ZXCc+v/FnXBYGx5Vp9I4bgf1O9A2r26iN2buUuEpAxuu2xUFelrIR5LK5N8AY0pbwLoXd2Me054VuOWyjYzNj/EtAFudNwacbkr4wp50Qoi0oYBbopq9A/yIQNxo7EUtQbDC4YHUILDuNlLgmeGSI9MsRzPDShfHDi4mpQ05rlGFe5Et3a6QYmKUNsZ+hkPM/aF1cIPwrFz5yKSEgocuFingAYLxfsR7R/tcsfOUPvyAtk3HA6U6HFd2t9l3dwxP7Cv8BKkiHIG6HGUjET766rx7fz6JRQKpoPSM7+Ey+y/ha0hVgndJt1dgEUUL4rGzvEk0JOF11HVzucuUVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by PH8PR11MB6564.namprd11.prod.outlook.com
 (2603:10b6:510:1c3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 21:14:02 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 21:14:01 +0000
Date: Mon, 28 Sep 2026 14:13:58 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>
Subject: Re: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
Message-ID: <arrYlnkCq4GDIG9M@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-6-peter.fang@intel.com>
 <bd235459708f5233444f31270d8785c0818c107f.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd235459708f5233444f31270d8785c0818c107f.camel@intel.com>
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|PH8PR11MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: df2fddac-d81d-4dba-d0a1-08df1da56b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0IybhObQQiDXYFCd//9ycgYIet14xT0Q+p8MJ4NmfJlAM817Ly8S922yrGyO6/F98cnLCAx89sWLvkHzjCc/gcvX0ADdjq9WcBdGacDSXun0ovd5tNg7vbBUMn3aFvmhbqaS25fOmpSgOw3IpWJ940z/IAtZz3q4D+sFR8al6G2GYDvjdI0TVRYUs+ml0rtgPMZMr0Lc0M9ckKMC5KARVJoAudSr/zI/hkIj53H7b7fQsb85ZxPqLg5UpRIzcLDnrZmJ99/KQBOnvBXdab6jPB/pEmiq/D6beX+h+YKv67DxLeywHazXkJkaFSZuAEVWk+q5xERT1WJUUaTHPd8Kdo1Yv/XANB/q36DAbL4eclkc5JXBIxFobLznBKm9B/O9E6jZkJ+pwguKJqwRnT5DcKI4s55JiqDDqFXaP9az3bQ0AT2eqJFwz9YPQ6ltP23+TqtmfOwWuV1nUos/qGQyyRW6vDmSI01c4pogBP8fG6jG+gAiYjbSwdQehD+Lh71tyCrtLA53rkBmksU2n+N6BnWqcNUpECPHESNyqpD+S1L7n1CbhMI8MDsy0dyzEWOzCv9lZm2wwF/klp56vvbfvTNnoo/6ZgbT+2asHQLLrLlxzAY5G+EtXJ7CBbl0PGle5mEYixdpJOx8264c2ZCFd4EFjCi4w3HKST6xZ8Hm+U4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzJ6eFR2Tld0cWpHK0xpNG9ob2RmNDFwTE9Od1pJR3czbGtCcUgzamxwRFZY?=
 =?utf-8?B?UTJOeU9hd1dtUU1zNjhCVUlWYTRWazZNL3NHb2RkMXp6YzBkQ0YvcG1Na3Ew?=
 =?utf-8?B?MS9IMlQ1VTNhVDJJZnZoMjdLbzN5RExoT2FwSmZEcDJ4ajkwQjQ3aU9xSjcv?=
 =?utf-8?B?eVRQZGhLMVBwRi9EcUJNWWxxRUxkSEdSN05aZml2RUd2dUFRL1JVbThPbnpH?=
 =?utf-8?B?QnFyQ1BGYkFRRHlVVkxsak8xNTRFU0lGWU1TQmZEYWg1dUkzOTREVC9TOEFr?=
 =?utf-8?B?YUFzZlhPVGl4ZWZHci9TbFdGa3UyUWR0NlhZR1o4Tis0dGVjZTg0bWVQM2ho?=
 =?utf-8?B?SlpBTzlINkdTSFllS3R4dTMwMUw5MVIzUEJCdGdLTi9Id3FvVWRsRU9xaG5P?=
 =?utf-8?B?RVh3UWx1d1FoRzNXMlI0OW9Hd2FLRVlJYkdKZzQzSDhLd0ZsWVBSNGxpbEpL?=
 =?utf-8?B?azlzTDA4cHNnZjA0Q2hYNlA1MS82b3AwaEhsRy9iTkt5U08vY1dXTGhsRTBu?=
 =?utf-8?B?R2RkcXNWdThybXh2VkpnMElteXk1UEI1UzhiMEVJL1hhUWlDUEsrUG0zVEg1?=
 =?utf-8?B?ejhmbmJCeEFXaXB0MnorNzBMQlRabDE3WjUwMFo3cUZQYXVpOEpoQmNYRmhm?=
 =?utf-8?B?NTJTUXpxSnJNUmQzM2hFR2J4WDZsSGE1d252QnFndEFpRFFHbyt5V0dXVHVO?=
 =?utf-8?B?UTVMRXJXaVQrSjA0bysxQXpzTGo3Zm1vVnF1aHo5cFJGbjZTZkZ2MHZsSHJj?=
 =?utf-8?B?YVMvNTVHSHdKRXJrNFV2ZXdBcGRRMnpFaHBJbk5OT2I2ZkdSQ2F2SWU4Y3Iz?=
 =?utf-8?B?YWE3ZWpla2tsUWFOby9GRzFFOUVJTWlHRURxUUMwYlN6Y0UrSDlnOTYvdWdN?=
 =?utf-8?B?MmFRTkVrMHNjRkE3KzlibGVWSExoN0wvMk00cWNqenJBN0dIWFVZR2t2MzBq?=
 =?utf-8?B?aFFHdTkvdnJZN1BnSWtUNThLakt2RThpUmZjYW56ekdYaGRVcFFGNHJkMDRD?=
 =?utf-8?B?ZzdmWHJac0gvNTdTa0krd3RnN3p5azl0b08vRTZ3T1dCUlFTeEFvZjBab3J1?=
 =?utf-8?B?V2RtbCtnTU40R3A3UVlndnBHcHNzd2xCam1LMUVncTQvditmNG40NU5CU3Fl?=
 =?utf-8?B?TkhpcEJVbitpK2xpWVNuYmVvNDRwWHBRblRaczd5QjJnWEM2VE9USmdzZW5T?=
 =?utf-8?B?aGc3dzdCdXdNQVdXNXVJaXY3OGVKS2ZvaUF5VDJUTzUycWo5b1FCbFIxU0RU?=
 =?utf-8?B?bm5kUUNRQTQ2UkNxZkhHaGIvK2dWQlk2amFwc0NUUVZTTStPRkNtUW85dGYv?=
 =?utf-8?B?bHZPZ2RVNlNUWStLSDZNajE4cEFtdTBiaWNGSzNLbjBnTFc5bEtvOUZCc2lT?=
 =?utf-8?B?aEZDS3kvcFZPVXcwR1cwNVJzK1hGWUNMRUZGc25ONnZnMzBVaE52NnNXdlJQ?=
 =?utf-8?B?QWRmWlR3WmtJREpDWVk3ay9GMk5JWTliMDRmMlY5NWtFaFAzWFBUWWVBMzJu?=
 =?utf-8?B?RFpyMm5ZMHFsWjhabjY2eHJEZzRiS0d6U3plcEFxOXVsNENlUmg0MzlnS2xQ?=
 =?utf-8?B?ZXhVOGVxd0RkZFRNcm9zWWVON205UnBDWEFuQjhwajUxczBkOGlCNXBQN0ND?=
 =?utf-8?B?Vi8xeVU0RU9oRThOTWhpbSszbzU3dGt1MHFQV3J5dDNjMWcxWlp3SS9TNkZS?=
 =?utf-8?B?SGxkenNzNnZXN245MkRRNUoyUEdkY21CbVdkblRmaUEyU1lYZTJDUmFXUGFk?=
 =?utf-8?B?bTNpS25XTjVQbU9GUXhUeUNHRjBsUldyZDdkM3dtSWNKbGdZNkdDdEFoaW1U?=
 =?utf-8?B?SzljVDNBR0czTGo5THJOOEJoZDNSQldsM0p4dFJGUTVuWnpHeUw1YkRSbnBk?=
 =?utf-8?B?ekppUi93VDl3T3I1cTlLWW41V2JMMFluVGoydHlka2Y0TEVUZEZLUUpoMUtB?=
 =?utf-8?B?ZnlGbDdKeUJmZDluaWFIUWgyMVU5NFpJUTBUMlF2S1Z2MGIyNEtueVN3eXhm?=
 =?utf-8?B?SnFnRFVmQ0JIMUZ4UkttYUJ0bERGOWNHZEZHcFJhNk93UTJlaDE1YVJmWnM2?=
 =?utf-8?B?MWRkbFJZbUNVaGtHODYrMDkrZFZETVgwRnYvRyswdlVMOFFka1VXczlLZmVO?=
 =?utf-8?B?OXVPZkJWSjNFcjlKTG1qckhnVWg5YjAvbDBKK3Y5WFBFOTVWOTB6anRwZzR0?=
 =?utf-8?B?MHBkaGFsUUV6aVFDMEJzVGJ6dGlZK3k4aGxDelh0NnFvTG1hekx1RmlEWVdh?=
 =?utf-8?B?b3VveiszK1FlZ2xGMFY0WW1DN2htNzlYT1lmcWgwMlpKS2poSDBRM1NrY05H?=
 =?utf-8?B?VW9sNEdBNjVOTFJIV0d4MUorYm5pYkNpS243M3ZDYUdCUGtMMEhGUT09?=
X-Exchange-RoutingPolicyChecked: nttBDO3dcpT+Awb9rnoBwUxvWcD4eNTBC9gS5CJbEqPnKc7rPnSKYO0RkIyKcq4GWrMNQC9fSjvdXKqZNDJfpqt5fCYLOKmM1Szlh6b3u80M0ti4HByvE/LQcnqpxvUWL1QqA3d0Herq2wbw6yY7ixcWR2XcoeDkieDRckHGk64HjrfyMuOt36+61sqWLgR4sTgNM0jgJ0q47O+m9D4abVuyd7TREpmY2QLlLnhsABOr3W0Mot+r6/2thhT18Y45R1WRaKrTfmIfLynoOxpel+GbJaIeF9yEBHLINneaE7V6YsTAtjrcgGowWYbgp3xpGjVISUIm3KtsQoKks1/EnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: df2fddac-d81d-4dba-d0a1-08df1da56b23
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 21:14:01.5189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLU520BG66BvjtNZzYzeIDhq0G7tl66dT/de/8nx2fMU9bnHOF1hxKgmrMsoY+tznjL/glaW3K3xvCntVf1wTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6564
X-OriginatorOrg: intel.com

On Mon, Sep 28, 2026 at 11:50:32AM -0700, Edgecombe, Rick P wrote:
> On Mon, 2026-09-28 at 03:08 -0700, Peter Fang wrote:
> > [1] Intel TDX Module ABI Definitions, August 2026, TD-scope metadata
> >     field "TD_QUOTE_MAX_SIZE"
> 
> The latest seems to be June 2026:
> https://www.intel.com/content/www/us/en/developer/tools/trust-domain-extensions/documentation.html

I think that's "Intel TDX Module ABI Specification". "Intel TDX Module
ABI Definitions" was updated in August. Yeah these names can be
confusing sometimes.

> 
> So where is this? Does it say anything about being page aligned already?

In the pdf the wording is "Maximum size of the buffer that must be
allocated to contain the TDX Quote received from TDX Module". It doesn't
say anything about page alignment. I can confirm with the TDX module
folks.

But even if the reported size is always page aligned, the driver would
still need to slap the GHCI header in front of it, and that would make
the total buffer size again not page aligned. So would it be useful in
the end?
