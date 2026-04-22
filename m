Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717973446C5
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776896089; cv=fail; b=pq7TSqx4a6W1bNQgrDH1q8hkjoJDtss1EbkrAVWAcztYmVAka/1CheeRq8RXbzvyetz2eN5aHAU6y5zVZGZymq4SrPKWRjlt+aLq4G9bhhNsbZOfjVKMInivR4qyk+0VIDEXymDJBFMHXs0Vk35hBALRnLJJYHQe6GksCFjUQd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776896089; c=relaxed/simple;
	bh=KrAoBENUnFsqKEFVQoeEMdwQ0aYr431tJkcnc73heLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kMPt3qAAO5/qUdRaz6cFlKmtS10DSM1ml+bgiHRmDsOYOUThoDXY1X/ceRA5u+bwUbPlvsYr0OIwcx8LUXSSZOP8Z84PKs1gQoMnfGMRmfcC6MRg/tnONAtxM4mUmYXGghgwcbj7VWQSF8jh744naw5h98A/tU1AvDm/peWsTpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kp6+WZcC; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kp6+WZcC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776896088; x=1808432088;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KrAoBENUnFsqKEFVQoeEMdwQ0aYr431tJkcnc73heLc=;
  b=Kp6+WZcCJgNJcBHackgNxNTZi4QwZ1221XJB4ptQeUIuW8IK1qujL9UN
   S453jHvoy76nJvryizxW/QU7xFpo0SMzdLYEEx+cHmjiYzlUuxkGZu/aE
   ncaBeTBnxgkg6gtmsH6RhqufEEd/eaBlMqv9v/3EP+3zOp2kyA2B3PaKj
   6tSRZ6YgwvWaGZPgr+R5Syx7kr+cW6JQLvXOjPiP70HPZ66N7gEEtB/mH
   U3adPJqwygLVieuqWOptGo4vo3C7vUM7uw67CeAa5SmKrwNjEEbnCvwr8
   917ESWKqrEEk26BIkm+0tGiBRnEGs6JQXp3IQwgqOkO+ffPtQzHnljwYU
   g==;
X-CSE-ConnectionGUID: OsgUgJBPT4Gml2l7CkNjeA==
X-CSE-MsgGUID: lHfBHgMmRqurBDLVoqAvmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88558103"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="88558103"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 15:14:48 -0700
X-CSE-ConnectionGUID: TQlCubLqQvKYno15Umiaew==
X-CSE-MsgGUID: NCEK0LEgQiq7JroKRX/eSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="232790514"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 15:14:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 15:14:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 15:14:46 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 15:14:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAqq42c85ahRstlJjtEauyAMfvf1bA2JjfGYUSfKMijWtUU5Lqu9qeiPIbUQldXChsmou+2oIQy9B0lwGwWIQSL0oPJW9A9gYAt/fX6BIKQ2LUz/9UsJzzqmnw35/h3kkCNcg07nEs8qt5b0I9dRpS8SbMJy6Y4bV+go2qBwC7dHsKyk4L8s7bP/mO6wkhMZwQ2VUxp4SEhQ7gbW6+koKpsZcOn5Y763y0ycNjYhb/u5oMvK77N7dAPbwJu5pM72W4tT3AMSEkvqyvj4tx2Re9LQgVRHlJ83LWqgdWm1jdmVwRmbw2eyvuhkMCs9ReCkx758pqLD3IfoRy1gVOBNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrAoBENUnFsqKEFVQoeEMdwQ0aYr431tJkcnc73heLc=;
 b=VWuSsMcoMBlvCEbF01QzBq3s02lmqoM/e243y7oi+MyQYaXGGwosNcfFHnm5MhTqd3JTi3wj2oPFXY2OMyMa+DHaZt8cgHrL48TjCm10qmiNrm04KKHjExSg7dPENS1up4lpeK3RJ4KhagUjsW2ljKnqFj3ZNAJTpmAeWcs7FgHC/osEMxrpnNQvZDmsWbTLk9Pl37CxpoPRC/yDgv2XwOHxU5WJ10RpF+sC14/nVqQM7oyiFSTmCJdktTivVIxEzPtv0KlzTSgKxuYBv7u2Tw/Gs+ER1/xG2UbIyUU8bUpvyaxtrw73EUEH73FR1jzw50VS2JYyX9MwavB5W/wJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DM3PR11MB8670.namprd11.prod.outlook.com (2603:10b6:0:3d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.20; Wed, 22 Apr 2026 22:14:39 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 22:14:39 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "nikunj@amd.com"
	<nikunj@amd.com>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
Thread-Topic: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
Thread-Index: AQHcxliL7ApYp79orUu4JhjyJLC0JLXnk/4AgAIguwCAAJHqgIAACw0AgAAURYCAAMLrgIAAlT0A
Date: Wed, 22 Apr 2026 22:14:39 +0000
Message-ID: <243d5c15a6ac4fbaf3c86fecbfb792df46f1b76a.camel@intel.com>
References: <20260407063245.2755579-1-nikunj@amd.com>
	 <20260407063245.2755579-8-nikunj@amd.com>
	 <34cfe5e8-756a-435a-a73d-54bf69801161@amd.com>
	 <aeeS7LDPJ6NCy3Uw@google.com>
	 <3e4641288d7791919abf1a5b02b80431285484e5.camel@intel.com>
	 <aegWmKk8uK5r10dM@google.com>
	 <977e805339a29ab789650aa18cd320dd1e9e0c25.camel@intel.com>
	 <aejLG_w8H16EifMj@google.com>
In-Reply-To: <aejLG_w8H16EifMj@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DM3PR11MB8670:EE_
x-ms-office365-filtering-correlation-id: 5334b32f-fe10-4b16-c263-08dea0bc8bd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: CXyJGoBdH8lMSGv8YTG8E+GVooDvZxEzBfyzIjeqGaigtjS1ExKM295kUqlU0X6zf9H9QnIXj25KaCSF9KoSxCiwkyhwujEVpADYsLxAWdbE2EbZQcvVvoZ/mhKH+rVO2XKHCbi8eK5vsPwK3510LHvD9StWTVvg/Dj+zZ5PWSKbV9EjBg4bfE/DnlEYwUxkjkef7q1lnEvnS17u/amXrF8iZknQnJXpVepUEHQGkRrVSxCQUC8D04GamxomMU2GCIApE2oCrEKiNYDxJPJrKjt55QaEbqsx2eXmjXBTBdemGuVK12Ft3Abx5V9A+/dQWRj0I3LHRYNHPqZKRgdrsZ2pnCfZlUtAmLDnUU/QyaNDcWEaQ5p49cabUAIG1ypiRs6iJUsWq5nRMv5nrHhQKIMocgdF+9KXmv+PMFm0txpW1llAN5/9bNs237HP8wnDZqvGtgrQo+psGu7yNlyLfkwOvqUtYISMJruiHWpA7V6mSxjLo+SdOsY9PkaPDMNmHdAdqUa8qey5lbYSebHH0+AojLhfPneKCctnS/dq6cnNMGjG2DkNPFxADwM9U4EqtFSu6CqOJuE+9mUqm4S06z6cmuQ3NMMqSeChqJLjta6OIxFzRrzpvHoI5SPDYqahMXUiPBSOTx3UJ27aZs34TqoBBoU8Mp01TC/vuryORq/cTCodXBXoWMQGi/lSWavwLChJAPllQ4YfH4fkq4MerbxPCQ/wKjfYr1sLu4J/mGJL+W8mPQIbV+J7x0STQVwWLAdpF7A+ZC5TSmTUhgM1xlYCJ8lQ6T2grWT2EGvMKJg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0pQY3J6RTRDWVZ6Sm54K1d6VWlGRHJHMkQ4RGVnM3p5d1NBU1d6QnhLb05k?=
 =?utf-8?B?T0RyWUN5NUQ0TnhnT05KN2V5dFdtSEF1WTFIM3d5ZTdDQzg0b0FwYnZQRUt4?=
 =?utf-8?B?RHVJYUVFT040QWd6ZVVodDZhNmt4QkRZZGFUcGtzc3YrNS8yN3hPdVN6dDFQ?=
 =?utf-8?B?K3NUM0FMMmpFTGhpRHN6ZncvdjVZQzNPSmFnZDJsTEs4L3AvdUNtNVVnVmtn?=
 =?utf-8?B?Nlg1ODUxSWI0aEY0M1pDS0pJeURzMGJSSWJZSWJINGQxNEkvdkJsRHFXR210?=
 =?utf-8?B?SmI4cTlKNkFXbFJkcEQ2b2h6S0ZIbTJQcnhkTWtIeklVSUorWXFiYXRQT1J1?=
 =?utf-8?B?Z2FUL2VOLy8rM2Nsc0NCaWZPK1JSMURCbjBWdnY1RTdnc0ZDVEhuT1o5MXEz?=
 =?utf-8?B?R2d0MGpLR2JaZmVxcXFYaGp5ZmJqZ21nOFBQM29oNWpSdVQyaTFUb2JBUUNH?=
 =?utf-8?B?S2tOeE1lOUNtRkozN0hmRjZEdzRQL0FNdXFYWGdnVzI3RGVKT1RDUXdwY2Jx?=
 =?utf-8?B?L1BYZlNUSjRHVFovczVBdkZYS29LQ3NjTTN4dFp2ODRieEFnazEyWDRFVFV3?=
 =?utf-8?B?bEV1UFhkQUIzelZCYi9qaGIweFhwNjBUNXpFNkt5K3d5alh5SThUVzFvdXpR?=
 =?utf-8?B?TnBzVTRWVWs3OVBlWFp6b1p5SWZ5d2JlNnR6WmZvWkljbXYybWJDNGZrbTFl?=
 =?utf-8?B?QkcxZjZmS29qMEd6cW41YktmdTVmckZqdmI3WXo2cWFTcVZRQ2V0K2tDMEFx?=
 =?utf-8?B?dzArRzlRdTc4b0thZmVKaW5RSUkyUUNLc0cyeFhxc1I3elNvaFhmT29mVEdX?=
 =?utf-8?B?SEFyRkcrNVY1RWtlTnJYcDFHaWMxWHJwSUVqcjNaaXZ4dXFFbVlYMEtpTThQ?=
 =?utf-8?B?REdLQUlLa2QvOXJkY1lKMG9qVm45c1hxQ25TMVFTRU9vS3pJYXVVR2ZtWUpq?=
 =?utf-8?B?dUk1d3RZODhkSkxIZHlzQ1h0WVBuREFaQS9RcTQrSk1GMWMwTzdHRUNvamw1?=
 =?utf-8?B?MXYvTzdiMG9rMnZjTDlYc0MyU21ZT2dkNGZPekVkN0NoaFE3UzlISmFJWXJt?=
 =?utf-8?B?aEYrd3NHZXZzeU5WeE5lakd5bW0vZEYvckFjTUFvTjcvTndpUFNrQzc4bjJO?=
 =?utf-8?B?R2xWMEcvWi9yUkRENy85M01lMzh1bndib3pnVUJjYWdLVXlhRDQ1YTVoaHBj?=
 =?utf-8?B?aEM2ZCtTeU81LzNYZEFUK1lBV0pGM2ZNL3FNaGVrOTVJTi9qYzUxVTVmWkU3?=
 =?utf-8?B?d29VNnJuU1lCRWFRRWNoK2J4RWZ0bzhBd2V1eFpCNGJrMWRrWTc3K3I1d05E?=
 =?utf-8?B?RUhZQ1NIY0dtVFp0RGVyVElpS0M0LzVCTVJjV2JrUEw2OUhZSGV5QVJwUnhB?=
 =?utf-8?B?U2hENWU4UkF2TUp2VitNT3ZyS3NlczJzWTNUYk5qS0dGbk9vZjJKWjRKbkd3?=
 =?utf-8?B?UnFnK0wxNldFVGVlRndaK2FOSlUwUzN0R2J4ZEdleW9TajArZUpBQkNlSmxV?=
 =?utf-8?B?RDZ6M3k3M2t1K1FhT3UyQ29hcHVCdGZmVjdOY3ZpSVNyWldaSGlNT2cvUWVq?=
 =?utf-8?B?T2JTNS96WXJkWjJLa0VFNWZ4aTJzaXJKSXFkdTI0ZGVPNE1oNnJPSkpzRllR?=
 =?utf-8?B?V0FLUStUc2tUTTJ0MDIwT0p0Rm5zVjZONkE3aUtQaEJ2SUpGVW95ai9ROTdy?=
 =?utf-8?B?dGc1VHlRODdFdDRqMitib0dKVGg1eXB1TXNxZGdJLy9uRDRkK1ZoazlUWXlP?=
 =?utf-8?B?cEg3LzBCdFdaSXFrM3hhb214WTFtOHRHWjdpYUhGREpCZ0pYYjRkVXRlZ0w4?=
 =?utf-8?B?VFdKSWN0UVJ1QnMySTlPcW1rZ0JJa1lnU2o3cy9NY1FwcmNtWW1UazdqRmJC?=
 =?utf-8?B?QTlqb2ZtVXhwaGVSNGFTSUxmcmRmUnFPeTY2ZXkzSDVnV0Y4anROUThzbHNJ?=
 =?utf-8?B?UjM5OWtCWXRFL0cyL0R2aDNlMjM3bzNBY2ljTFA5NklVUmxqVlVsSEYxaFVW?=
 =?utf-8?B?Sy9YMko5MXVuWm5hVTNlUzZrWlNhNzVCUVBGQU9SbmpHd2FMUVNhYzJ1V2t0?=
 =?utf-8?B?S21iWTZYUHZXVFJrWllCUXcyVFE1cmEwVldsSFNWZkI3bWtCMGRNQXU4Ylc0?=
 =?utf-8?B?b2dyQjdhdG42TCtmZHh2RW1LbnlERlZud2JnbXZ3bUtONXUwMjZIb21iL2FP?=
 =?utf-8?B?QTVRR1VpQlpSN1dQTFhPRmNoVkVoYVhVM3F6RzFiREVla1JXRlo5TlRzdlJs?=
 =?utf-8?B?L1RzeGxTOWpVRk1RYjl5K3dkeHVLQVJsZzMrQnp6aG9mSzlSejR2QXM4NGYy?=
 =?utf-8?B?aW01MTVTa1Z5cWJES25sN3A0cjdyb2VkaXR4dTZnRTZjZzRIL2lmUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65106FDB74EAAE45B684E3C8A167827E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bfaGpV5b8cTB85/R0yyJl1fJH52b/hYnDGpAZ5qPzJFl+G5NPECoxZ7AZu+mKCZa1mTTEQsZD109CpAtDHFSSwYS7+dZYdrzQRgA+dflku5hZBebm94vr+htL7q2hZEUWNMnCOCpq4p9Txcn+LJo1PplTSCZhyR5NvapUF1pJUnsdy7TczdpiHrlLRtm01m/yKAomcsyU9aPellFjdAS3ekkDevcRrixwaK/1De3cNTUZO1epxR5FpNm8s28iLUz92K3jQ5v0Ug12p8nxL2oGopTZbA/Z0WVneHJQ4r1sP+dQ82WN0BxeicfWNUVS/IVuvDg20WnBIBqvTLBF3MMMw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5334b32f-fe10-4b16-c263-08dea0bc8bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 22:14:39.2885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GdPi5bhtGPcbI8aCHR1153ZRx3Hj4byOSWR733Q8Va6jH426mXtTM+M1lz1ZBV62C1zaKiFDEM9+pbT1ubIvgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8670
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTIyIGF0IDA2OjIwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBXZWQsIEFwciAyMiwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIFR1
ZSwgMjAyNi0wNC0yMSBhdCAxNzozMCAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToN
Cj4gPiA+IE9uIFR1ZSwgQXByIDIxLCAyMDI2LCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gPiA+IE9u
IFR1ZSwgMjAyNi0wNC0yMSBhdCAwODowOCAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90
ZToNCj4gPiA+ID4gPiA+IMKgwqAgdkNQVSBSZXNldDoNCj4gPiA+ID4gPiA+IMKgwqDCoMKgIHZj
cHVfZW50ZXJfZ3Vlc3QoKQ0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgIOKUnOKUgD4ga3ZtX2No
ZWNrX3JlcXVlc3QoS1ZNX1JFUV9FVkVOVCkNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoCDilJzi
lIA+IGt2bV9hcGljX2FjY2VwdF9ldmVudHMoKQ0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgIOKU
gsKgwqDCoMKgIOKUlOKUgD4ga3ZtX3ZjcHVfcmVzZXQoLi4uLCB0cnVlKQ0KPiA+ID4gPiA+ID4g
wqDCoMKgwqDCoMKgIOKUgsKgwqDCoMKgwqDCoMKgwqDCoMKgIOKUlOKUgD4gaW5pdF92bWNiKC4u
LiwgdHJ1ZSkNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoCDilILCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCDilJTilIA+IGNvbnRyb2wtPnBtbF9pbmRleCA9IFBNTF9IRUFEX0lOREVY
IC0tIFBNTCBidWZmZXIgd2FzIGFscmVhZHkgZmx1c2hlZA0KPiA+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgIOKUlOKUgD4ga3ZtX3g4Nl9jYWxsKCk6IE5leHQgVk1SVU4NCj4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiBDb3VsZCB0aGlzIHJlc3VsdCBpbiB0aGUgaHlwZXJ2aXNvciBsb3NpbmcgdHJh
Y2sgb2YgZGlydHkgbWVtb3J5IGR1cmluZyBsaXZlDQo+ID4gPiA+ID4gPiA+IG1pZ3JhdGlvbiwg
bGVhZGluZyB0byBtZW1vcnkgY29ycnVwdGlvbiBvbiB0aGUgZGVzdGluYXRpb24gaG9zdCwgc2lu
Y2UNCj4gPiA+ID4gPiA+ID4gc3ZtX2ZsdXNoX3BtbF9idWZmZXIoKSBpc24ndCBjYWxsZWQgYmVm
b3JlIHJlc2V0dGluZyB0aGUgaW5kZXg/DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEFGQUlV
LCBuby4gVGhlIFBNTCBidWZmZXIgaXMgYWx3YXlzIGZsdXNoZWQgb3Bwb3J0dW5pc3RpY2FsbHkg
YXQgZXZlcnkgVk0gZXhpdC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBIdWguwqAgVGhlcmUncyBh
IHByZS1leGlzdGluZyBidWcgaGVyZS7CoCBDb21taXQgZjdmMzljNTBlZGI5ICgiS1ZNOiB4ODY6
IEV4aXQgdG8NCj4gPiA+ID4gPiB1c2Vyc3BhY2UgaWYgZmFzdHBhdGggdHJpZ2dlcnMgb25lIG9u
IGluc3RydWN0aW9uIHNraXAiKSBhZGRlZCBhIHBhdGggdGhhdCBza2lwcw0KPiA+ID4gPiA+IGt2
bV94ODZfb3BzLmhhbmRsZV9leGl0KCksIGFuZCBzcGVjaWZpY2FsbHkgY2FuIGdpdmUgdXNlcnNw
YWNlIGNvbnRyb2wgd2l0aG91dA0KPiA+ID4gPiA+IGdvaW5nIHRocm91Z2ggdm14X2ZsdXNoX3Bt
bF9idWZmZXIoKToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAJaWYgKHVubGlrZWx5KGV4aXRfZmFz
dHBhdGggPT0gRVhJVF9GQVNUUEFUSF9FWElUX1VTRVJTUEFDRSkpDQo+ID4gPiA+ID4gCQlyZXR1
cm4gMDsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAJciA9IGt2bV94ODZfY2FsbChoYW5kbGVfZXhp
dCkodmNwdSwgZXhpdF9mYXN0cGF0aCk7DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gR2l2ZW4gdGhh
dCBTVk0gc3VwcG9ydCBmb3IgUE1MIGlzIChvYnZpb3VzbHkpIG9uIGl0cyB3YXksIGl0J3MgbWls
ZGx5IHRlbXB0aW5nDQo+ID4gPiA+ID4gdG8gYWRkIGEgZGVkaWNhdGVkIGt2bV94ODZfb3BzIGhv
b2sgdG8gZmx1c2ggdGhlIGJ1ZmZlciBvbiBhIGZhc3RwYXRoIHVzZXJzcGFjZQ0KPiA+ID4gPiA+
IGV4aXQuwqAgQnV0LCBJIGRpc2xpa2Ugb25lLW9mZiBrdm1feDg2X29wcyBob29rcywgYW5kIHRo
YXQgb25seSB3b3JrcyBpZiB0aGVyZSdzDQo+ID4gPiA+ID4gbm8gb3RoZXIgdmVuZG9yIGFjdGlv
biByZXF1aXJlZC7CoCBFLmcuIHZlcnkgdGhlb3JldGljYWxseSwgYSBmYXN0cGF0aCB1c2Vyc3Bh
Y2UNCj4gPiA+ID4gPiBleGl0IGNvdWxkIGFsc28gYmUgY29pbmNpZGVudCB3aXRoIGJ1c19sb2Nr
X2RldGVjdGVkLg0KPiA+ID4gPiANCj4gPiA+ID4gU2VlbXMgdm14X3ZjcHVfcmVzZXQoKSBkb2Vz
bid0IHJlc2V0IFBNTCBpbmRleCB1cG9uIElOSVQgZXZlbnQsIHdoaWNoIHNlZW1zDQo+ID4gPiA+
IHRvIGJlIGZpbmUgc2luY2Ugd2UgYXJlIG5vdCBsb3NpbmcgYW55IGRpcnR5IEdQQSB0cmFja2lu
ZyBBRkFJQ1QgKG90aGVyd2lzZQ0KPiA+ID4gPiB3ZSBhbHJlYWR5IGhhdmUgYSBidWcgZm9yIFZN
WCBoZXJlKT8NCj4gPiA+ID4gDQo+ID4gPiA+IEhvdyBhYm91dCBkb2luZyB0aGUgc2FtZSBmb3Ig
U1ZNPw0KPiA+ID4gDQo+ID4gPiBXZSBkb24ndCByZWFsbHkgaGF2ZSB0aGF0IGx1eHVyeS4gIE9u
IFNIVVRET1dOIChldmVuIGludGVyY2VwdGVkIFNIVVRET1dOKSwgdGhlDQo+ID4gPiBzdGF0ZSBv
ZiB0aGUgVk1DQiBpcyB0ZWNobmljYWxseSB1bmRlZmluZWQuICBJLmUuIEtWTSBuZWVkcyB0byB3
cml0ZSBfc29tZXRoaW5nXy4NCj4gPiANCj4gPiBZb3UgbWVhbiBLVk0gbmVlZHMgdG8gcmVzZXQg
Vk1DQiB0byByZWZsZWN0IHRoZSBhcmNoaXRlY3R1cmFsbHkgZGVmaW5lZCBJTklUDQo+ID4gc3Rh
dGUgZm9yIGEgdkNQVT8gIE9yIHRoZSBoYXJkd2FyZSBpdHNlbGYgbWF5IHJlc2V0IFZNQ0IgdGh1
cyBtYXkgcmVzZXQgUE1MDQo+ID4gaW5kZXg/DQo+IA0KPiBOZWl0aGVyLiAgVGhlIEFQTSBzdGF0
ZXMgdGhhdCB0aGUgVk1DQiBpcyB1bmRlZmluZWQgYWZ0ZXIgU0hVVERPV04uICAgUE1MIGluZGV4
DQo+IGNvdWxkIGJlIGFueXRoaW5nOg0KPiANCj4gICAxNS4xNC4zIFNodXRkb3duIEludGVyY2Vw
dA0KPiAgIFdoZW4gdGhpcyBpbnRlcmNlcHQgb2NjdXJzLCBhbnkgY29uZGl0aW9uIHRoYXQgbm9y
bWFsbHkgY2F1c2VzIGEgc2h1dGRvd24gY2F1c2VzIGEgI1ZNRVhJVCB0byB0aGUNCj4gICBWTU0g
aW5zdGVhZC4gQWZ0ZXIgYW4gaW50ZXJjZXB0ZWQgc2h1dGRvd24sIHRoZSBzdGF0ZSBzYXZlZCBp
biB0aGUgVk1DQiBpcyB1bmRlZmluZWQuDQo+IA0KPiBLVk0gc3ludGhlc2l6ZXMgYW4gSU5JVCBi
ZWNhdXNlIGl0J3MgdGhlIGxlYXN0IGF3ZnVsIG9wdGlvbi4NCj4gDQo+ICAgc3RhdGljIGludCBz
aHV0ZG93bl9pbnRlcmNlcHRpb24oc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KPiAgIHsNCj4gCXN0
cnVjdCBrdm1fcnVuICprdm1fcnVuID0gdmNwdS0+cnVuOw0KPiAJc3RydWN0IHZjcHVfc3ZtICpz
dm0gPSB0b19zdm0odmNwdSk7DQo+IA0KPiANCj4gCS8qDQo+IAkgKiBWTUNCIGlzIHVuZGVmaW5l
ZCBhZnRlciBhIFNIVVRET1dOIGludGVyY2VwdC4gIElOSVQgdGhlIHZDUFUgdG8gcHV0DQo+IAkg
KiB0aGUgVk1DQiBpbiBhIGtub3duIGdvb2Qgc3RhdGUuICBVbmZvcnR1YXRlbHksIEtWTSBkb2Vz
bid0IGhhdmUNCj4gCSAqIEtWTV9NUF9TVEFURV9TSFVURE9XTiBhbmQgY2FuJ3QgYWRkIGl0IHdp
dGhvdXQgcG90ZW50aWFsbHkgYnJlYWtpbmcNCj4gCSAqIHVzZXJzcGFjZS4gIEF0IGEgcGxhdGZv
cm0gdmlldywgSU5JVCBpcyBhY2NlcHRhYmxlIGJlaGF2aW9yIGFzDQo+IAkgKiB0aGVyZSBleGlz
dCBiYXJlIG1ldGFsIHBsYXRmb3JtcyB0aGF0IGF1dG9tYXRpY2FsbHkgSU5JVCB0aGUgQ1BVDQo+
IAkgKiBpbiByZXNwb25zZSB0byBzaHV0ZG93bi4NCj4gCSAqDQo+IAkgKiBUaGUgVk0gc2F2ZSBh
cmVhIGZvciBTRVYtRVMgZ3Vlc3RzIGhhcyBhbHJlYWR5IGJlZW4gZW5jcnlwdGVkIHNvIGl0DQo+
IAkgKiBjYW5ub3QgYmUgcmVpbml0aWFsaXplZCwgaS5lLiBzeW50aGVzaXppbmcgSU5JVCBpcyBm
dXRpbGUuDQo+IAkgKi8NCj4gCWlmICghaXNfc2V2X2VzX2d1ZXN0KHZjcHUpKSB7DQo+IAkJY2xl
YXJfcGFnZShzdm0tPnZtY2IpOw0KPiAjaWZkZWYgQ09ORklHX0tWTV9TTU0NCj4gCQlpZiAoaXNf
c21tKHZjcHUpKQ0KPiAJCQlrdm1fc21tX2NoYW5nZWQodmNwdSwgZmFsc2UpOw0KPiAjZW5kaWYN
Cj4gCQlrdm1fdmNwdV9yZXNldCh2Y3B1LCB0cnVlKTsNCj4gCX0NCj4gDQo+IAlrdm1fcnVuLT5l
eGl0X3JlYXNvbiA9IEtWTV9FWElUX1NIVVRET1dOOw0KPiAJcmV0dXJuIDA7DQo+ICAgfQ0KPiAN
Cj4gTm93LCBtYXliZSB0aGUgQVBNIGlzIHRyeWluZyB0byBzYXkgb25seSB0aGUgc2F2ZSBhcmVh
IGlzIHVuZGVmaW5lZCwgaW4gd2hpY2gNCj4gY2FzZSBQTUwgSW5kZXggaXMgZmluZSBhbmQgY2Fu
IGFuZCBzaG91bGQgYmUgbGVmdCBhbG9uZS4gIEJ1dCBpZiB0aGF0J3MgdGhlIGNhc2UsDQo+IHRo
ZSBBUE0gbmVlZHMgdG8gYmUgdXBkYXRlZCB0byBtYWtlIGV4cGxpY2l0bHkgY2xlYXIgd2hhdCBm
aWVsZHMgaW4gdGhlIFZNQ1MgYXJlDQo+IGFuZCBhcmUgbm90IHZhbGlkIGFmdGVyIFNIVVRET1dO
Lg0KPiA+ID4gDQoNClRoYW5rcyBmb3IgYWxsIHRoZSBpbmZvISA6LSkNCg==
