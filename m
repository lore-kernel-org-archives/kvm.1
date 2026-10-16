Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012054.outbound.protection.outlook.com [40.107.200.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9088625B091;
	Fri, 16 Oct 2026 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139781; cv=fail; b=TLknPikCVWqZ6z2rNoH7PYh0qQQBt74DYj71jlsbmK6qiFWGRK4ARvCR1BCHC2Dp+PKiA2I0slhpU2Gb3ha6pjWnAot1qYaTYPDudFpNOsEXtzPzuCeJny6Sl2ufP6tP+cbHVpyZ7efFWvK8TH8pl7fDiPX97jt9pG0nKPlMXDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139781; c=relaxed/simple;
	bh=iUP2I64dIJ7ZdihImWDt4VRidqcUYIsMsVVF8BMGm7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dlYhuyFS1n8ZmOQI1gsiJzk9PO8Ym83X4oMZewB3yYSPCzgrqxQRQ+0REE5h+1F4FOewchCM47cDuW2oD4AjZ1zeaMaQX87HxCQaL50BNbeUP9Q51ieIoTja7/eFCUnZXgjK98SwK0Fn8SZ0tKmDEqygwT4tfApnw7DE2Dr0YdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YpGanFKc; arc=fail smtp.client-ip=40.107.200.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YpGanFKc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gc41CZy5MkTJBPzwEq9UoQN5OoS3KgG0Cey8s1STEayb7j8eAaUMRIMUo3uUNE/0zs1yzNeWUuGvGTWx69QFQb4Eq5DONJMgL94BYPf9FOk6dqqIfIGKFlCol5j1aqyIWgvXBzW2QvyIlZx9w7p6N3N4v45ZtGHBFrQ6rPBPmFUFBWVQBb8v+lDIuUddQX88nl1uYLCNhgkDyvf2imtyFfSvyJjsTlkK1eKkkTaTU0p/BP0Qq6OeywoQQ583V55vCcH2dGPJXl5NhaVPOKZ5Iny06rAXC2meaO1yhWhH6WUkquqPuhcJBtrb85BkU9XhVD55lkYMM3FfraWIUZBhMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUP2I64dIJ7ZdihImWDt4VRidqcUYIsMsVVF8BMGm7w=;
 b=XygikS5mOPJH8PJUATGzdLxRjoGRasidl7iEXyQWE6SCfBePRKMjt9RMjuDnWwc1poWUBRVxT/RNbhDBM1SIbFOba+MEmkBVwfWclMC38U2lWTV3Bf54WDuE0L+/rRd8tKN2qEEy4lUPRc9pn01C4UOhiCcztV+we8MscpO9oDzGpC+EOZU/15aK/W3OnN/r+DLMMFojWJQBXb5o6seQu0Ks9CP1n6cojYObBxpg3q4sBSE78FBBAKOGUglRwPqV+OfuWwz7AE2ikTYDNvJ7MtMlOUwsZuEwzRKIhwohfeZiCYCVrxtHwojeES021//rP2KIVckJKrQJdRWV2LXA5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUP2I64dIJ7ZdihImWDt4VRidqcUYIsMsVVF8BMGm7w=;
 b=YpGanFKcR7ELx3+8csXJ8XH9JykQ1BbbK0ufwpnqNFek1VrwluiS3c/42JCC6okgZbNlhGThCxuka+7cQ0qFaGV+iuRyrrMn6htMNa8xPtJXuNC7aUCelhfFKPuetje6uu4abfLH3bamcKDAqooI+2CXIUuk1IGESGMjaL57qCvTvh5t61IdsrR8Q61GV5WpaXM9lv+U2IQLG+hXtlayLU3hdq4WqpQg+nlsukW7Zn6d4JpD8xnzLm/Jw+3ofxjfmmv2SYpSiJ20T8Q/ujpQzJoXCZ/EpZAjAXee2PWfJFN/0g41fa8vp/0bwWQcNu1L2lPS2aREF1LG290adV7iTA==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by DS7PR12MB8251.namprd12.prod.outlook.com
 (2603:10b6:8:e3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 08:36:15 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 08:36:15 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Andrea Parri <parri.andrea@gmail.com>, Alex Williamson <alex@shazbot.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer
 Kolothum Thodi <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Jiaqi Yan <jiaqiyan@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] vfio/nvgrace-gpu: Drop the usemem length check in
 open_device
Thread-Topic: [PATCH v2 2/2] vfio/nvgrace-gpu: Drop the usemem length check in
 open_device
Thread-Index: AQHdXH4Gi2wRu0fo8kag+9HHmSiiH7b/2cMr
Date: Fri, 16 Oct 2026 08:36:15 +0000
Message-ID:
 <SAWPR12MB999267B9EDD38E7F4A10A5E0FDB09B2@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20261015081937.405320-1-parri.andrea@gmail.com>
 <20261015081937.405320-3-parri.andrea@gmail.com>
In-Reply-To: <20261015081937.405320-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|DS7PR12MB8251:EE_
x-ms-office365-filtering-correlation-id: f096cdae-37f0-44e8-df6c-08df2b608b06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|56012099006|38070700021|11063799006|4143699003|22082099003|10067099003|18002099003;
x-microsoft-antispam-message-info:
 7E1FGSAiujxnhGy39oP5yoRGRS508wEXRswIzDXxBcOzz3PHFm+QbR6bstHoxMudEsAcRowUI7jqSsoxfVJqxRu8spZCtJvhREs07taWIvR1SHvdu+IvbjLKFcY5rg1iQ0NPL5z7+gwqjhVAEmxf1GtMKja6XOhIEne/7pC3GBBONeJbbPSuzPKSPD2L/C0iEXjLzPX6TBGzaUaYmZFnhY4w0aySQcxXC6sFX7eGEOPh5nWaKcBO9LzrCKkvsBt0SiLmwpiyv28lJn57c3j7vjd+9ledaaYKyvqQzCK7kioT0OJGiWHKPA9E83nsNKDutw/5A41AAgtqqCMI+zmHkrRs26esPyEMoQkMKOHbSWRoArnuMmd/eeVf1J+fh1aHarjhm39+oP5oTxbo+LTycO8r/qL1j8FSBo5FWdf0kBgNyLieVmGfxrnsGJpxashwPHgvNR7IvcnqL7ODsJ8unQTjdzbY1qotATgM1LGeWLJKIMnyw6vSvC3H+jNsVPHFD1aN2c2imYB8EKLlthArn3/eNfhRynRTt3Qt5/Kaw1S/VLAJTGu6q7nrEltpx3Dzgw7ACQCFhCj/vgv4Ais4B6rmsfTPxY0fSM3zHAc9JWcxOmODquCGaRvpc7B1xU3Y6hsS5pRwsIwYYn/n1rfL/a86rpU/LtqTeF5PDMZxI7WEwdgFKGFedHhU5CL2aYCRPsCyqPlYO8EYDru8GYWsnUbr83+xfbmmNbS6bpApWVk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(38070700021)(11063799006)(4143699003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XRfrSNRArP9G/rPc+677VVtlmx+i3Ch7RWyimVWc5BSdX7y9LYEMXW31o2?=
 =?iso-8859-1?Q?pidfghmeOJIKZhvdy5xVnSZ4DmOb9/CbwnP4jMtdlewu5ybIrwnvjlMSYh?=
 =?iso-8859-1?Q?qjrjTXpb7Cf6rh1kCJCFm+IdIC8xRTuiXX9sq+W6W8UYJaGIF0BLImsU4D?=
 =?iso-8859-1?Q?LMwILFef0DeM+ORQ4TGxI8RuwhBHOUcHUpybrgYZzLKioU60X4VG0Pb+qg?=
 =?iso-8859-1?Q?qwWU+enaEHY/Chgv99/hubjR8dEtpY/lNE8F5NSVjUoWWgIzO2AGjBur5R?=
 =?iso-8859-1?Q?4787RmOY2h0CzSkgkzj801ebgGo9dDKtjoiFz5S8sD2y3alrj3jY+9g3qu?=
 =?iso-8859-1?Q?xBC1lcpdCygxy9+INMRmUGXzCdxdiN0+wrjbeOAKZ8QtRs3ql5N/rPIfhx?=
 =?iso-8859-1?Q?xRvob3+QnsOnad68TG0cUqyDQOQqAWnNTObkLrqwMuIowkGVyo8BuxGmDf?=
 =?iso-8859-1?Q?/QNEAQMm0p8Zd/LM4C43fV67pEWjxJFzbKlj2/HkP6n4wDY2VBeAyqtyj1?=
 =?iso-8859-1?Q?KLO3LA15BYpcZnveMe9Z/XRwqqwIdZCVcU+5lMT6AqQWS5O5ID4/ucO5r2?=
 =?iso-8859-1?Q?T6b1B4FSeU9IwewkgR9ia39KvsqfvpJUdkl8XuX9rUhYv4bNpRYhmneO1E?=
 =?iso-8859-1?Q?l0LqBLK8zrFeouOD/V596q41FbMjUZMRh2EwU4by/+kHElL/maatU2fBx+?=
 =?iso-8859-1?Q?l7COTqtCy9O0g9YE0Xso2f7p9tynQrPYUCLrm+shRqjom2Ibkn8ZilSBwR?=
 =?iso-8859-1?Q?o1KXeGLtTc2J5bRAFXq52ZoW6eb7ssTeJpjq3DVZg1QO6B3AQQSpGOneGz?=
 =?iso-8859-1?Q?/wN4m0kfbMoCsHZZHAsjXZct2pdI3eHZwaeiT+zhCRkoNKog/v7h5MwXHV?=
 =?iso-8859-1?Q?VWbtkddnIpjmoPks34HrFQEMk0opWiTuU2ncLcFrn5Th1IntH5UEPun7cf?=
 =?iso-8859-1?Q?p5P3i53Zwqld8pZG6Pvh9A9kYm4W2C4RmcPfDToSxletSgscJKwmu5o+Ar?=
 =?iso-8859-1?Q?rQAMj/xRHG/OZxAfO4E4d/9TzCgDYUJOuNrzvZefRSpczM+toxu/j8oxAk?=
 =?iso-8859-1?Q?inxqSVXukJKxTzCbqArJkPX6nq5dSZ02kbO38KnV8BPUT48tJPiBeP4u7G?=
 =?iso-8859-1?Q?xKzxi7RVgGTK22LdLoM6ovnkpFcyFriZ1SrIf8zdHkyxTr3AV2yiJuwwuN?=
 =?iso-8859-1?Q?yAzQq0hJuu2WY6VCphz4GkX7c+ounV86ImOhDgMUv81m+Q4OEvx1SYt00t?=
 =?iso-8859-1?Q?Pb5eexPk7WuNKQj99Orwajmov92FBre5ACabqAIWQB9UfYXrm2+to82VAF?=
 =?iso-8859-1?Q?9FYaiIRIE5YsPZfz9n9FvNvNmmzwDjFWc2+3aKIHuTWH7hAnz1HQDatD45?=
 =?iso-8859-1?Q?65xAMS7mj3eWJeGcDaKJXCemX0UlLUhJlNOKnRfQhfYCU00BEnyF0kvS+i?=
 =?iso-8859-1?Q?r4Xr3dWrtIabZrIxpl2rolZggyk11lKGyh7GpKjNxNHbcuRWmL25FW7Xtu?=
 =?iso-8859-1?Q?448SD2Q7mtnp59acFQQhzfIcC8vcyrI+dh3FMr+u2Njio9yxVWvz0Z9aMK?=
 =?iso-8859-1?Q?I+DVHcicEh5+NSptOcrDITNNjEXpR0yZEp123UfYZIwHvceO/oDvb4jHHn?=
 =?iso-8859-1?Q?XKRYmz41wou9IGCrfZaoLzMUaH0uTF1XNIangrfJ1VgM36TUXkqQXgsbCi?=
 =?iso-8859-1?Q?q2tavBRImhUW5SD5E3c9uNEf4aJaGh27JQvO5ms4CJ1F+odaQIEAcYbx+t?=
 =?iso-8859-1?Q?fNSdlES+TqvbJ+JGzPySuC/FHjVnCkZG6O0fTbBA8bQbSQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SAWPR12MB999267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f096cdae-37f0-44e8-df6c-08df2b608b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 08:36:15.9168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EcSrX/INnO3AZiikX4L9T5gLI9CuJcFL1nbZlTHqsfMsklWt16TvKXGiJtIDdF8lXhr8/UMTNPB3CgmcYo9+Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8251

Reviewed-by: Ankit Agrawal <ankita@nvidia.com>=
