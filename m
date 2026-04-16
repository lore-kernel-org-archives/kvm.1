Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600BD349B02
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372629; cv=fail; b=PPFnqTONv6455b98WgzwoesHe4+k0o9iOCzVdeGVIahYNOmuPqnyuvRniiiJ3bufbshUT8JAAZmqrpVHSnWy4pk5lF/qxlOk+bHcK5LswrQD+Cr9vJ2jyUb97CMG5o6/pC4E96CHVNdLM/Rtl3vC5EcBNaLenQcGKC73Vo1TYOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372629; c=relaxed/simple;
	bh=GVEFDLsMIH7o4RA6ZokXgIXmP7wIcvWJr1kahKtdPCI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t40F7KviuNXNHh68kLHCPTtF3ILwZdUUE0XFq3QrVLdo9+qJIwkbEmkn5yuQ/4095KoI0GtjOiAa+LHeqaDlFzMEz7PDDlxy+ILYKrNgNzIGjmsgv1QGFprXTSrdKxNv2xdDo0PpB3fmRUjdy7HBTWlpSIZGQ7HgpxhDF7zCXBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VwfXMyZP; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VwfXMyZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776372628; x=1807908628;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=GVEFDLsMIH7o4RA6ZokXgIXmP7wIcvWJr1kahKtdPCI=;
  b=VwfXMyZPAUmSFa8fGMUNo6PtvNHR+PHKqIJuvlwMgk3z+3q3JZTaOH1v
   PKQU9OVkpLK41qjCnxNuGB8vP239i7xHNCKFWvwsWgBFLhgJvBH/SHh8c
   mKMYFtLVkdPewBcctpaUYkT2YrTvREvgbGQMVgpHPG8D+KiOzMAFvWvCi
   1TeWkI8+vmNYQMiBSiF6dhydSRiR7c+JYrD/LxeYsVqOzn/bfJdiE4uh9
   0UtUY4BouxtZjJ0WxUWujx/F7k4n9z9EsZqyllMButbXGQ6sIDnfl5PjH
   hYWWT3OLmGfPAGPXs/H/D76RzxYcwmYIzX4t8XPxfO39WU78/vqNtqAwD
   Q==;
X-CSE-ConnectionGUID: kQj2iFn8S62JPHAOnOZ+YA==
X-CSE-MsgGUID: H1rt8btRTJOH2dLpk8dNeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77459731"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77459731"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 13:50:28 -0700
X-CSE-ConnectionGUID: 9j7vaZmaSjasm91kF/C4CA==
X-CSE-MsgGUID: M8yKa6KmSleBMSpizL6sXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="230770093"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 13:50:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 13:50:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 13:50:27 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 13:50:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyhu3lz5gatwFFZdqHMWIARIdR3r6762cZGcNod2z1C28CXSBWQUeo4bDjvXIthiXrv/CcyPMeLmDIwGuYaJLdo7s56jlSu42QWZfP/tNiBHSNVlYmVhVA5wlj5xmYybZx2xjNy2FwHI0InuLARG//wvtKEdKyDyyR1Pt3svmWy+dVvexqGy/zio1aAUL2taLwheaDwd94CTrAXOHy6x4ugt/Vscl0JK3WwkAUyPMRrx62qc70Mm1UtoXndpTvvdBi4yQs7QhbSGrbI7QoRZ0zrDY31s5PkIiE89hmmqi4FhkTJDFh+xZabupa/T1YzRWRU+Curt96WF2xG6Fy9GoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVEFDLsMIH7o4RA6ZokXgIXmP7wIcvWJr1kahKtdPCI=;
 b=Kibi9tixkAMIYKDCJKthcrnkGbyrn9xlcRlz0tFlaGRntFdqjQz6FBAYFJ+Lc1JE/IMwGSd/QGwtKtyLecxCRk6koU7tKVz4OBKZa8RdZhgSAAsjJFfh4pSCWxfxaIQxGJs8InuqJYRHhs4nNXlg6lqrVg/t7qt9f7wpOxQRQ37jmGllwtLEL7wP3nJeZU+fDfyCYwsgmu0vkt/WT6cxphRj7P3DtdHBUq6WYyVQsmuECTYcd4OWTLu4euHq5wmaZyl2B1x0qpsWzqc2fTjn4mL3Ciu+3nr1o9PY+X2WU7ySgPIbyls9Y5dBWEM6ZApVQXCK778a0X1NX7mYTNbOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by IA1PR11MB7343.namprd11.prod.outlook.com (2603:10b6:208:424::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 20:50:22 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 20:50:22 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "tglx@kernel.org"
	<tglx@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: CPU Lockups in KVM with deferred hrtimer rearming
Thread-Topic: CPU Lockups in KVM with deferred hrtimer rearming
Thread-Index: AQHczeKk+wS46Li00UqCaHMewgV8CA==
Date: Thu, 16 Apr 2026 20:50:22 +0000
Message-ID: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|IA1PR11MB7343:EE_
x-ms-office365-filtering-correlation-id: e92f97ef-bdf6-4281-a05c-08de9bf9c760
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: pJ6g5TscD3jGCqFWZYex0Jnevprf/ntssEaCgaUe5pkKN40RkRAh6WnLe89CJsiAn6Bl/tluXvjBhVWqJRjYnQ8GMVd6sLmHB5M5zRMyYscQ99rwH6HTbEVlcARwESTYjYkFrivegLKmnFt1Yq15/MQQ+cBJaZ6ftMgu3e5NTCy+W2IGtx06tI5kZ5+7WiHOz2ovnwRiKw8oWdt0+TkFR1cu5LX2uDhMKGwepdklTcZSj47rHdbWuuI2Ap2eXRy9be9iUge6oBXw4y6NSPEbQbRgscqCrq7cvKaHvX4nj2TE75T2g0YfYBI9pIbNszu+gchquY9b0dsjzNlEnen96ZOP3momO4173n6dxrdWidaTk0WBcnsgYw+E1V6n5Ewf9j9C2YXy5888Svj6OKa6zuEe3XE9uwX/E5PtOTp7N8+YDTLUuNhCOimsOXSsHjG6DZVXB29XxBrMaA2hJ8AbQ+PaBirHpHnEV0Ta7UIf8R6Cj8ewRGdzRGImJyN7bpo6+mKVi/CQOF4ZzmNIStZ+Ie62ErWzQ99uqTrZyKfTqvTCLq1NgLPqGZDFWKuaVHxsZAqJeTXkakfSqtIcweaoJtMYXJIoTaWPn3/77iK4FoV3sbQ2lq+kwZtbw6MwiZX8KB/IlrsXAijftFzzoSFe04vbt2AuWZza69fh8Na/nYdJzyduxp5RlWsF8iLPi2FLTkS081xiJZpNIPhXw5/4DwmJ9e/RMqlkt7pWrtoXOtHqY0VCphjVu9cnvHhlBWA7uA2YxMqkEbVpYPy1Znj4mTsj/j5qALtQEFbFZYHhPTY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkNYUG96Q0U3UWMwbGhZSngycUxMa2RZeFpZYk5GcUpyODRnUnZ4TllSZTNM?=
 =?utf-8?B?ODRIRkNHeVduWkRYVzA4TmxGNDdNRVp3cDRBblcwckV1NEExYVJ5UkUrVkNX?=
 =?utf-8?B?VkdVT3RLdURmT3Q0MVlLdytKMkdYbWxBUmt3ZWFsQUV4NkxxRVN2U25jQ2hO?=
 =?utf-8?B?K0ttNE9qc2JxdW93S0M3K21uVmNqdG9CeEZBWDJYL09TN0E2TVpvR2t5VC9C?=
 =?utf-8?B?VWI4WmdyellvYlVUKzRYOUxhM2sySndhV2ZaWkNTSkpRMlo1UStnM25NUnB0?=
 =?utf-8?B?R2h3eDY2SHNRSjJxalJ6c1dDVk0zclV1ZCsyRjZvamxrVWt1NHROVm1qQnJz?=
 =?utf-8?B?UVpOeW5rNXE5Sms1RXRCME5HQUk5MDhiSEtYMDlvZVBMNWlCSm4zaFltTEgr?=
 =?utf-8?B?Y2dvTFk4Z1FtVmdPMFRackR2VVpndzBsdDVvRFh4Y05UOE1WWE8vQVVlOFVu?=
 =?utf-8?B?cngvTkVuaGM0Mm1UQVpDOGlEeVZqbUFtdjNlMC9FK01rcy84dERXRncxamx1?=
 =?utf-8?B?eW01SllYbWQ2OWRqRW04SmVJM3I2RUJ1dEZJNXJLRjBTdFduU2FFRGcwNWZ3?=
 =?utf-8?B?VklHeEZjRDJabEJiZFVGMU9JdVlOTUorRlVnb0R0WVJ6NWg4UVAyeTd5VUlR?=
 =?utf-8?B?R0l2QUMrek56aWx2REtFSWl0aTE1T2taK29JcTBYdlVOaXVDVExpcG9DRnFs?=
 =?utf-8?B?b241RzRWWm5BZzYwNFlmUlZzQi84cGp4dytsTHRuQlV2cnU4aDZiOVpiTk9k?=
 =?utf-8?B?UVdCTG5LaS8yVXdDbnlxQkFiVzlORVNBQnIzRDBNOUFDb1BMYWk4MFlZbjdR?=
 =?utf-8?B?eTZFQWN3eEQzY3pYVWErWmRuNWlpY0RRQkljeWpvMEFZeFl3MEpSd0JjSmNY?=
 =?utf-8?B?dzNPeGM1MDYyM01WWDlERGhDNnVPTEczR2FPN1BKYmtndzY5dGRhZmhYM29j?=
 =?utf-8?B?MFdrQTRUL043SnNMbVN0dmR0SUkzY1VUZjBhYXpnQlFCSzF3ekNVY0U1dFhP?=
 =?utf-8?B?WGVFanc3YzFLcEd2R203dVZGQ29uZW80N1VhTElUeDluczd5dWlYWmVlYXJa?=
 =?utf-8?B?YWRNNmVrZlB0V2R4aHNOSG1tSitsbmxidTU5Uk1Ta0hTb1RBRldOdHNTVlQw?=
 =?utf-8?B?Ykd6Yjh6UWlIMFdoanRkOThFTVBVZ3Jmc2VyTXFPajVwQ2tJWkpodktRK2p6?=
 =?utf-8?B?RjljeEl3T3VDRHlCaXVRdTRZUThta3owU3dsSTBRQ01xVGtEbFE4dVU4MUww?=
 =?utf-8?B?WkJaOEtyZkM2S282RGNCa2RUODhweDV0ZXdhSzJ0Q2phbXNBd1RuU3Q0dDh6?=
 =?utf-8?B?VXFWcHJEV2NlVkhJYlNTUzhYWXdOdWJtT09qeGx6aWNWVEhOMkZJLysxTW1a?=
 =?utf-8?B?ZkUrRFE1alprek1QKzBDcmhFV2hXUjdzKzZtNFhXalVXQ1pEdjhyVjJtbkRX?=
 =?utf-8?B?NHlIeis4d0x1SGlZSGFLQytvMEJEOGdOb0RxUFFDa1k3elUxbjFWb0JHKzUr?=
 =?utf-8?B?d0hzbUpRQllqYW1nckJYTXdtTlp0UXN0eDNwRmhjendoVUdzeWF1WU9lY0Zr?=
 =?utf-8?B?eEMraWlINDFoWUxrdFBDcWljQldTRlBWTEZEMlB5R3R2VE9kaEhkNU5HUHg4?=
 =?utf-8?B?ZE4zL1ltTDRRcHRyYWNGK3ROY0ljRnBmcWJGM1pVdjltNWdWNGplenpweEZL?=
 =?utf-8?B?bnN2SXpCSnMzUUN1RTJkc0RCblY3ZTRDZ1ZPZkVOV3J1eVl6OWNZZkRhUWpy?=
 =?utf-8?B?b1VZcTRtdVkwTEhULytCUDlPbUMrYjBFZ0VKbXNEMC92MWl0SHZWc0gwb1VN?=
 =?utf-8?B?TGdHVTFIb0p4N1hvZzVXODF5dkZOazRIaXpiM1BhUTlaNUtTVEFydmlrQVBH?=
 =?utf-8?B?ODBuTk1UM04vMWRnbTBudDlOTHk3d0hQMDdPRUxVa1ByT1BBallyYUp6SDBu?=
 =?utf-8?B?ZHFDUjE0NWg1eTlXQXB0b1F0N3VCVTRwTFZ3TTRXUU5VUGRkR2IvOS91NGwx?=
 =?utf-8?B?WFJ4WjlQUXBtMHU0RVVlTjllbyt6SDFJaXVKZ3BrV2JicTRKUzdHV0hleGJl?=
 =?utf-8?B?Y01QLzJyOVMyWk0zY3FIVldJSk5xWWJmNUdGYy9KZEFSSmd0NTR5S1RWTkls?=
 =?utf-8?B?bXNDV09yT01lYyszNWlCUmVwbE1Na3psL3dZUExQZWg2bTNyYzljWElaN0NC?=
 =?utf-8?B?UG1aSThLblNpYzI2bjM2TG9oMlA4QzYraEg1THZlS09JSlFIUnc0UmpCdlp0?=
 =?utf-8?B?N0tPYlk3aVFLVS83STRvY0JReUIxbkwyM2RLeVBYZ0NubGdNcWhtNXpPQ0VO?=
 =?utf-8?B?ZU1QNmxUekF1dTgyZU5kYmRKVWFWSHkyTEREOER3alhOdVFmcXZsOFRLbWRP?=
 =?utf-8?Q?NubENWuykdtPxI88=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BFDADE7D13968419F4866DDAF378F12@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dknDTq9VBRDNz3H8A3qeYNbg/v8CidIWC6rvkrXFXZWQSAW1U5ATmhMuFsCsHDIsAimDQhg04hbdT324uGVLzZeg8IVhD0Ei1e+pXfpCGdpDI0L1SiYBJ59dDCbq8sP0+84LkuIAXnHLnK2Slontz/eDFuJCYaslHQ/aIJObI7CWINcjDy3OSzaYe3DCoyGfQAawJhB4eve1qhYQ+qNcb1Bo4JSiyKVQ0MAa5emfBwX9N/vUsvvcvdQNnGrAn+m4G3U8tBmqM0SwLVv7C9pp8Ttu4TFpKNZmK4AbUcSkdmpR+c6VVEo6A/AMo35Uqh+sqhVAt4ElhF57Agc6cICHbA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92f97ef-bdf6-4281-a05c-08de9bf9c760
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 20:50:22.6881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /oD/1AJ1CWlFnBJa+Zgr18TdZUxvK/ypfHuAI2NbmQytJAJPhfOeu7kY7pub3mRNUNOJUinyGHiF85DDXc3MYe7n1chBoWOPOlhOfwDkOs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7343
X-OriginatorOrg: intel.com

SGkgUGV0ZXIsDQoNCldlIG5vdGljZWQgYSBLVk0gVW5pdCB0ZXN0ICd4MmFwaWMnIC0gKEFQSUMg
TFZUIHRpbWVyIG9uZSBzaG90KQ0KZmFpbGluZywgYW5kIGFsc28gc29tZSBURFggc3BlY2lmaWMg
dGVzdHMgcnVubmluZyBpbnRvIG11bHRpcGxlIENQVXMgaW4NCmhhcmQgbG9ja3VwcyBvbiBhIDE5
Mi1DUFUgRW1lcmFsZCBSYXBpZHMgc3lzdGVtLCBhbmQgd2UgdHJhY2VkIGl0IHRvDQp0aGUgaHRy
aW1lcnMgZGVmZXJyZWQgcmVhcm1pbmcgbWVyZ2UuDQoNCk1ha2luZyBDT05GSUdfSFJUSU1FUl9S
RUFSTV9ERUZFUlJFRCBkZWZhdWx0IHRvIG4gaW4gS2NvbmZpZyBtYWRlIGJvdGgNCnBhc3MuDQoN
ClRoaXMgaXMgdGhlIGhhcmQgbG9ja3VwIHNwbGF0Og0KDQogICB3YXRjaGRvZzogQ1BVOTg6IFdh
dGNoZG9nIGRldGVjdGVkIGhhcmQgTE9DS1VQIG9uIGNwdSA5OA0KICAgTW9kdWxlcyBsaW5rZWQg
aW46IG9wZW52c3dpdGNoIG5zaCB0bHMgaXB0X1JFSkVDVCBpcHRhYmxlX21hbmdsZSBpcHRhYmxl
X25hdCBpcHRhYmxlX2ZpbHRlciBpcF90YWJsZXMgYnJpZGdlIHN0cCBsbGMga3ZtX2ludGVsIGt2
bSBpcnFieXBhc3Mgc3VucnBjDQogICBpcnEgZXZlbnQgc3RhbXA6IDM0OTk4DQogICBoYXJkaXJx
cyBsYXN0ICBlbmFibGVkIGF0ICgzNDk5Nyk6IFs8ZmZmZmZmZmZjMDkwY2U2ZD5dIHRkeF92Y3B1
X3J1bisweDVkLzB4MzUwIFtrdm1faW50ZWxdDQogICBoYXJkaXJxcyBsYXN0IGRpc2FibGVkIGF0
ICgzNDk5OCk6IFs8ZmZmZmZmZmZiOWFkZDZkZj5dIGV4Y19ubWkrMHhhZi8weDFhMA0KICAgc29m
dGlycXMgbGFzdCAgZW5hYmxlZCBhdCAoMzQ0MDQpOiBbPGZmZmZmZmZmYjgzZmRkOTM+XSBfX2ly
cV9leGl0X3JjdSsweGUzLzB4MTYwDQogICBzb2Z0aXJxcyBsYXN0IGRpc2FibGVkIGF0ICgzNDM5
NSk6IFs8ZmZmZmZmZmZiODNmZGQ5Mz5dIF9faXJxX2V4aXRfcmN1KzB4ZTMvMHgxNjANCiAgIENQ
VTogOTggVUlEOiAwIFBJRDogNTQ3ODUgQ29tbTogcWVtdS1zeXN0ZW0teDg2IE5vdCB0YWludGVk
IDcuMC4wLWcxMDMyNGVkNmE1NTYgIzEgUFJFRU1QVChmdWxsKSANCiAgIEhhcmR3YXJlIG5hbWU6
IEhQRSBQcm9MaWFudCBETDM4MCBHZW4xMS9Qcm9MaWFudCBETDM4MCBHZW4xMSwgQklPUyAyLjQ4
IDAzLzExLzIwMjUNCiAgIFJJUDogMDAxMDp2bXhfZG9fbm1pX2lycW9mZisweDEzLzB4MjAgW2t2
bV9pbnRlbF0NCiAgIENvZGU6IGZmIGZmIDBmIDFmIDQ0IDAwIDAwIDkwIDkwIDkwIDkwIDkwIDkw
IDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDkwIDU1IDQ4IDg5IGU1IDQ4IDgzIGU0IGYwIDZh
IDE4IDU1IDljIDZhIDEwIGU4IDNkIGRiIDZlIGY3IDxjOT4gYzMgY2MgY2MgY2MgY2MgMGYgMWYg
ODAgMDAgMDAgMDAgMDAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTANCiAgIFJTUDogMDAxODpm
ZjhkM2EwNjliZGYzYWYwIEVGTEFHUzogMDAwMDAwODYNCiAgIFJBWDogZmYzY2M5Njk2M2Q2ODAw
MCBSQlg6IGZmM2NjOTY5NjNkNjgwMDAgUkNYOiA0MDAwMDAwMjAwMDAwMDAwDQogICBSRFg6IDAw
MDAwMDAwODAwMDAyMDAgUlNJOiBmZjNjYzk2OTYzZDY5OWQwIFJESTogZmYzY2M5Njk2M2Q2ODAw
MA0KICAgUkJQOiBmZjhkM2EwNjliZGYzYWYwIFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IDAw
MDAwMDAwMDAwMDAwMDANCiAgIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAw
MDAwMDAgUjEyOiAwMDAwMDAwMDAwMDAwMDAwDQogICBSMTM6IGZmM2NjOTY4ZDAzZDAwMDAgUjE0
OiBmZjNjYzk2OGQwM2QwMDAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMA0KICAgRlM6ICAwMDAwN2Yy
NmFiN2ZlNmMwKDAwMDApIEdTOmZmM2NjOTg3ODJkNzYwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAw
MDAwMDAwMA0KICAgQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1
MDAzMw0KICAgQ1IyOiAwMDAwMDAwMDAwMDAwMDAwIENSMzogMDAwMDAwMDE1NDRhZjAwNCBDUjQ6
IDAwMDAwMDAwMDBmNzNlZjANCiAgIFBLUlU6IDAwMDAwMDAwDQogICBDYWxsIFRyYWNlOg0KICAg
IDxUQVNLPg0KICAgIHZteF9oYW5kbGVfbm1pKzB4ZGYvMHgxNDAgW2t2bV9pbnRlbF0NCiAgICB0
ZHhfdmNwdV9lbnRlcl9leGl0KzB4ZDUvMHgzMDAgW2t2bV9pbnRlbF0NCiAgICB0ZHhfdmNwdV9y
dW4rMHg1ZC8weDM1MCBba3ZtX2ludGVsXQ0KICAgIHZjcHVfcnVuKzB4ZDRhLzB4MTgwMCBba3Zt
XQ0KICAgID8gX19sb2NhbF9iaF9lbmFibGVfaXArMHg3Yi8weGYwDQogICAgPyBrdm1fYXJjaF92
Y3B1X2lvY3RsX3J1bisweDM4Yi8weDVmMCBba3ZtXQ0KICAgID8ga3ZtX2FyY2hfdmNwdV9pb2N0
bF9ydW4rMHhiOS8weDVmMCBba3ZtXQ0KICAgIGt2bV9hcmNoX3ZjcHVfaW9jdGxfcnVuKzB4Mzhi
LzB4NWYwIFtrdm1dDQogICAga3ZtX3ZjcHVfaW9jdGwrMHgyZWYvMHhiMDAgW2t2bV0NCiAgICA/
IF9fZmdldF9maWxlcysweDJiLzB4MTkwDQogICAgPyBmaW5kX2hlbGRfbG9jaysweDJiLzB4ODAN
CiAgICBfX3g2NF9zeXNfaW9jdGwrMHg5Ny8weGUwDQogICAgZG9fc3lzY2FsbF82NCsweGY0LzB4
MTU0MA0KICAgID8gX194NjRfc3lzX2lvY3RsKzB4YjEvMHhlMA0KICAgID8gdHJhY2VfaGFyZGly
cXNfb25fcHJlcGFyZSsweGQyLzB4ZjANCiAgICA/IGRvX3N5c2NhbGxfNjQrMHgyMjUvMHgxNTQw
DQogICAgPyB0cmFjZV9oYXJkaXJxc19vbisweDE4LzB4MTAwDQogICAgPyBfX2xvY2FsX2JoX2Vu
YWJsZV9pcCsweDdiLzB4ZjANCiAgICA/IGFyY2hfZG9fc2lnbmFsX29yX3Jlc3RhcnQrMHgxNTUv
MHgyNTANCiAgICA/IHRyYWNlX2hhcmRpcnFzX29mZisweDRlLzB4ZjANCiAgICA/IGV4aXRfdG9f
dXNlcl9tb2RlX2xvb3ArMHgxNTAvMHg0ZTANCiAgICA/IHRyYWNlX2hhcmRpcnFzX29uX3ByZXBh
cmUrMHhkMi8weGYwDQogICAgPyBkb19zeXNjYWxsXzY0KzB4MjI1LzB4MTU0MA0KICAgID8gZG9f
dXNlcl9hZGRyX2ZhdWx0KzB4MzZjLzB4NmIwDQogICAgPyBsb2NrZGVwX2hhcmRpcnFzX29uX3By
ZXBhcmUrMHhkYi8weDE5MA0KICAgID8gdHJhY2VfaGFyZGlycXNfb24rMHgxOC8weDEwMA0KICAg
ID8gZG9fc3lzY2FsbF82NCsweGFiLzB4MTU0MA0KICAgID8gZXhjX3BhZ2VfZmF1bHQrMHgxMmMv
MHgyYjANCiAgICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ni8weDdlDQogICBS
SVA6IDAwMzM6MHg3ZjQ1ZjdhZTAwZWQNCiAgIENvZGU6IDA0IDI1IDI4IDAwIDAwIDAwIDQ4IDg5
IDQ1IGM4IDMxIGMwIDQ4IDhkIDQ1IDEwIGM3IDQ1IGIwIDEwIDAwIDAwIDAwIDQ4IDg5IDQ1IGI4
IDQ4IDhkIDQ1IGQwIDQ4IDg5IDQ1IGMwIGI4IDEwIDAwIDAwIDAwIDBmIDA1IDw4OT4gYzIgM2Qg
MDAgZjAgZmYgZmYgNzcgMWEgNDggOGIgNDUgYzggNjQgNDggMmIgMDQgMjUgMjggMDAgMDAgMDAN
CiAgIFJTUDogMDAyYjowMDAwN2YyNmFiN2YzZTcwIEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6
IDAwMDAwMDAwMDAwMDAwMTANCiAgIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA3ZjI2
YWI3ZmU2YzAgUkNYOiAwMDAwN2Y0NWY3YWUwMGVkDQogICBSRFg6IDAwMDAwMDAwMDAwMDAwMDAg
UlNJOiAwMDAwMDAwMDAwMDBhZTgwIFJESTogMDAwMDAwMDAwMDAwMDA5OQ0KICAgUkJQOiAwMDAw
N2YyNmFiN2YzZWMwIFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IDAwMDAwMDAwMDAwMDAwMDAN
CiAgIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiAwMDAw
N2YyNmFiN2ZlNmMwDQogICBSMTM6IDAwMDA3ZmZkYzdhZGVjZDAgUjE0OiAwMDAwN2YyNmFiN2Zl
Y2RjIFIxNTogMDAwMDdmZmRjN2FkZWRkNw0KICAgIDwvVEFTSz4NCg0KSSB0cmllZCBvdXQgQUkg
YXNzaXN0ZWQgYW5kIHBhdGNoIChiZWxvdykgd2hpY2ggZG9lcyBoYXBwZW4gdG8gc29sdmUNCml0
LCBidXQgSSdtIG5vdCBmYW1pbGlhciBpbiB0aGlzIGFyZWEsIGFuZCBub3Qgc3VyZSBpZiB0aGlz
IGlzIHRoZQ0KcmlnaHQgZml4Lg0KDQotLS0NCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
ZW50cnktdmlydC5oIGIvaW5jbHVkZS9saW51eC9lbnRyeS12aXJ0LmgNCmluZGV4IGJmYTc2Nzcw
MmQ5YS4uYzQ4NTZjMjUyNDEyIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9lbnRyeS12aXJ0
LmgNCisrKyBiL2luY2x1ZGUvbGludXgvZW50cnktdmlydC5oDQpAQCAtNCw2ICs0LDcgQEANCiAN
CiAjaW5jbHVkZSA8bGludXgvc3RhdGljX2NhbGxfdHlwZXMuaD4NCiAjaW5jbHVkZSA8bGludXgv
cmVzdW1lX3VzZXJfbW9kZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9ocnRpbWVyX3JlYXJtLmg+DQog
I2luY2x1ZGUgPGxpbnV4L3N5c2NhbGxzLmg+DQogI2luY2x1ZGUgPGxpbnV4L3NlY2NvbXAuaD4N
CiAjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4NCkBAIC01OCw2ICs1OSw3IEBAIGludCB4ZmVyX3Rv
X2d1ZXN0X21vZGVfaGFuZGxlX3dvcmsodm9pZCk7DQogc3RhdGljIGlubGluZSB2b2lkIHhmZXJf
dG9fZ3Vlc3RfbW9kZV9wcmVwYXJlKHZvaWQpDQogew0KICAgICAgICBsb2NrZGVwX2Fzc2VydF9p
cnFzX2Rpc2FibGVkKCk7DQorICAgICAgIGhydGltZXJfcmVhcm1fZGVmZXJyZWQoKTsNCiAgICAg
ICAgdGlja19ub2h6X3VzZXJfZW50ZXJfcHJlcGFyZSgpOw0KIH0NCiANCmRpZmYgLS1naXQgYS9r
ZXJuZWwvdGltZS9ocnRpbWVyLmMgYi9rZXJuZWwvdGltZS9ocnRpbWVyLmMNCmluZGV4IDViZDZl
ZmU1OThmMC4uZjNiZDA4NGQ5YTcyIDEwMDY0NA0KLS0tIGEva2VybmVsL3RpbWUvaHJ0aW1lci5j
DQorKysgYi9rZXJuZWwvdGltZS9ocnRpbWVyLmMNCkBAIC0yMDU4LDYgKzIwNTgsNyBAQCB2b2lk
IF9faHJ0aW1lcl9yZWFybV9kZWZlcnJlZCh2b2lkKQ0KICAgICAgICB9DQogICAgICAgIGhydGlt
ZXJfcmVhcm0oY3B1X2Jhc2UsIGV4cGlyZXNfbmV4dCwgdHJ1ZSk7DQogfQ0KK0VYUE9SVF9TWU1C
T0xfR1BMKF9faHJ0aW1lcl9yZWFybV9kZWZlcnJlZCk7DQogDQogc3RhdGljIF9fYWx3YXlzX2lu
bGluZSB2b2lkDQogaHJ0aW1lcl9pbnRlcnJ1cHRfcmVhcm0oc3RydWN0IGhydGltZXJfY3B1X2Jh
c2UgKmNwdV9iYXNlLCBrdGltZV90IGV4cGlyZXNfbmV4dCkNCg==
