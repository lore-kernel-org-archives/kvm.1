Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76CF1A9FB0;
	Tue,  7 Apr 2026 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572933; cv=fail; b=gLwVBYKO5uiiM5m3lhuMUp9c/j5fYtsQovcSkuJbzwujFbqQ82EZgijYBmmH4eY+RTorMeIMPoPFlJycazGIY0FeErqbkEB6CRK8raKW1+XFEfgtGX6JZqZ13l0DzvicRb+zZvpDGS9rLS+Ieur9vAOx5lT7JFz4QIiH6mSkBfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572933; c=relaxed/simple;
	bh=sxXDxl//09Tmb+8hic/6ohXYco34dQxD8sLmpj9yUys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VReZ5L/3tAd6Muf31Xl2MDzqcPcBO3nUfrviFhST63aHBiv8+KR3qiGgA+8lEI4iGBYhoMTjI3YANxqkCX1yh72sM6Jmh2Za8tvNHEnmqP/F36Ufkmtsf6/BgWLb/LXcspYs4fsz08/8cNJbVwfdJVkXdvJesCd7O50rPd5khmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ancmgIwr; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=M9yjXdof; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ancmgIwr";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="M9yjXdof"
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6379FQX33400953;
	Tue, 7 Apr 2026 07:41:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=sxXDxl//09Tmb+8hic/6ohXYco34dQxD8sLmpj9yU
	ys=; b=ancmgIwr7ftb0ki4tWqsnryKXJ/39boTnFzNBYe3WV3pnH+++8yOmytml
	zNsckeMH+fM0Hxt+rs0NLzstPNuewSqzznQbYREA6ixpM2BaR94jwez0VWyPSLPk
	gtVQl49qu92dQe4Ygw9MgZx6nTw1I2Xsdy9yuY9CZmduMUrPwBAdLyl5Ek5FKniy
	XI6jDpfnxhyLdYxBNOAdpktsjlcNDovW39+w+Ab07KNTsgCx4C+nvbujStL7JxpS
	eka0C07lzsqVD2O+pW0x5P+VeEDWWHPwwE1ix6CTdLgp3015Lqm95l/psZ/BD7Q/
	mHckXilMkHyQItENr0nXtMmEjXFPA==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022113.outbound.protection.outlook.com [40.107.209.113])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4dcmsg1x6r-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 07:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naVkkPKxbX4sBZCE9YQ/R8PWf5WzB/nl/w8U+S0b+q9VVYltofJgrO8BttYHBrtL558FA0sAhGHIyY3aM4tkvyk08dQK2rz0+kS0HZfrcFzIHd8b4xIm4K67SKoo/Y8rfHxcxbDgu2pCgi82k3QompaI1aHJN20kvnX5GXy1Dforu/7NyvPvYAYGzxYebRXi87NumgeqAmXHLVEn2Bdi0TU2I6y/LO3tf1Gv5Exhytrw2KurNj443xeFAN4AblCJanXyBBYkc9B7hJb3pTHMkSUnu0CNl/8C2sYIP/ry3umxsSDl83dSFdX/UMo0IukoIgZ/YmtMu8udJxFOg6CMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxXDxl//09Tmb+8hic/6ohXYco34dQxD8sLmpj9yUys=;
 b=CvQFmXyXSZp4iVWeRCgzkEKmmD78OIeRHye1IhNoZyEjLRFEUlfMhX9d9wGTvvw1sFd1Oab7R6+1XSNlmIEjpfLyXq+zKOCmIRnWk7MAQG67QSWHvuSIgxV13mgf0kXTeNLeLxXvpXDueJj6PoNYk0UKR4PxFNUPUTp2yRpr5mOikEWQQxRm5i9jGI+VUsHLZumTGxP9IXAzjyOgnkdpOmYy4/QPy4BHTGO6UKiD3Wbn24bg//iisgY1a8iaM323BsIQwQ9Coe4CCsB7yChjY5S4B427f1rGcG8VJqhD3oK2uU5N+966YVwKGkU+LgT1xHrlxszxxIk8dEHC0+8UrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxXDxl//09Tmb+8hic/6ohXYco34dQxD8sLmpj9yUys=;
 b=M9yjXdofLOvM4nGu9QQq+Yxa2COZEEdqF+9XoBIT2DiFtp5P8ijZIWK8yFW5Xsk3sPxxk7fhau3y+xM/NHkqfOXKB61wZmr12iMUNMl4BBQipCJ/dAxZZwjIy5F3dIhoE81GixWNLJd45K57Pm6w3q1QeAe9JAMUoVZqBdwbtgV/oW4N9+I/h45I34q+GSL5cCVHTvmA/VRl3FSKDYSI53Jhpu5FpUtEeh79+rgc93OQOLmIziNfK5C3olyottYxQtcRAK/P0RWOpsAkG0qyLMG6dcNELEBlSSeR6lfvH9KGA8c1GTSReH0BDA49OcuN0QergwC3N6awHThPcaP5HQ==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by IA1PR02MB8876.namprd02.prod.outlook.com
 (2603:10b6:208:388::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 7 Apr
 2026 14:41:53 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 14:41:53 +0000
From: Jon Kohler <jon@nutanix.com>
To: David Riley <d.riley@proxmox.com>
CC: Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nikunj A Dadhania <nikunj@amd.com>,
        "amit.shah@amd.com" <amit.shah@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Marcelo Tosatti
	<mtosatti@redhat.com>
Subject: Re: [RFC PATCH v2 00/24] KVM: combined patchset for MBEC/GMET support
Thread-Topic: [RFC PATCH v2 00/24] KVM: combined patchset for MBEC/GMET
 support
Thread-Index: AQHcvUzQMiuRBN6BBkmcEmhJjsHrgLXTj9AAgAAG04CAACgPAA==
Date: Tue, 7 Apr 2026 14:41:53 +0000
Message-ID: <42A25797-9AA2-4DC8-AF19-35A8B2298603@nutanix.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
 <a7c32e69-afab-4289-95e3-330cc73f00d2@proxmox.com>
 <f40bc2d7-c02c-4dd6-a295-01f6d9b97805@proxmox.com>
In-Reply-To: <f40bc2d7-c02c-4dd6-a295-01f6d9b97805@proxmox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|IA1PR02MB8876:EE_
x-ms-office365-filtering-correlation-id: 934cc301-a86e-425b-96e4-08de94b3cf7e
x-ld-processed: bb047546-786f-4de1-bd75-24e5b6f79043,ExtAddr
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|38070700021|22082099003;
x-microsoft-antispam-message-info:
 zfL+h4Ue1Gp1EopCs7t4WA1FrngzL19rxabaXoZVNNL7QefGXgvRKy55lUel2QbbmTezrCZ+hyd/NOBkdr+BTE8mCJzXv1wlMnrFytet9foZl7iJyTVSr6ZB6GaWrswngaFnyE5S/iPKAdiFmnOBXQ/XKKMkjaJhLFZas+SPzbiU6FZIuEH1GEutrP7nkG8l2WEbRiNyFucn5ZBI2F2kTEuaV4Da/wGjTwYciU60bQxaYVo/pOCmRCfjt7UkcmOjVW/TVSMXJhMGtWAnYpMWn0hMaKR0TgasesGm0YaLvYyX9GQzB9TwxDGibEfAUufVm6+Rp5Ov2zjK80wVunLUgZfTLtdGREFljy1z/DTPDAHgkerC/OJd+DcuFxEZ7tXQvqg1oHaQs5aHXDxeIETKFe/i6I3mn3hUce4GrJqftd7Yw9QSZ/wQqmgmsflZu3ijXbdzMSiP7UmLPZ2FeQ3+qHJHwSiTGJ8YCy8ALjfs5K78W+eKnfdH4zf/ooADnhD50js+JpbvfpZE/ZEVgx9774oIepwo9sZhKJcAGKBUc83uwdKqu6kXe+8VpJl8ko5Id+RnSxJwoKMHyKIArtnapHqrCj2hNhNcVlFZFIqV9qVqs1QIg6orw97RVBF7SP542lgds5Cn4HRPp8k1Ze0Nc8zL0IhjBgiNFxUWCOX06YKNkTkiUiN4ooEukoRl7U0xCq6KeT1ptGqz4i00CYfEvkH0XQrFww4KusUMuOCSOxsSvDqq+RE6/dYKazlx3B4f/pIWdb0kv3pKf0QRxnYoT6lxydG0gbDxh3hTuIt1OR8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(38070700021)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cE5ZV0NPTTBLVURQK1ErUTlkYnpXTzRpMHRNZytkS0d0UlJDVW1WeHZ2YkpG?=
 =?utf-8?B?LzNqeVdIcUc4SEFSQ25ZbnFydmtYaHBkN2Uxdk8xYkQ0R1l3c3RycFV0TkI1?=
 =?utf-8?B?WXJGTEp1TVJWWWk4VlFwUnlTR2JYM2FxQjBWSFczYk1LbHpWOENQSUtVY0ts?=
 =?utf-8?B?eFFtNXRHdzRpZGt0KzZ5NEkyR0tzdURCenRUREc5RmFZNlJCbjU4cHFDSWI5?=
 =?utf-8?B?Q1BtWW5RMjl3R2hpYjQwL1dVWU8xNlArZE5SQ0NnaXhYN0QreHRhMmZ0RnE5?=
 =?utf-8?B?Y2ZERk5ZRUswVklmWGJ4WGtnRnF4ZzBSZUtpRDdpaVQ1bWxqUjhLbzdmL2dH?=
 =?utf-8?B?YmExUGFMTG5Mblk5TGJMcWVBLzQvOHo1M2Zkektyc2RuaTdXN0lIQzkyU2lG?=
 =?utf-8?B?ZmROK202Vy9DOVJJbytWVUVXQVYweVVBMUxOejc4aklINGVWQ2FmUTZsZ2ZX?=
 =?utf-8?B?K21hTlViUmE0aHRRVFRHOGhTZ0Rya0wvMzUvSzE1QjYzMjNzeGVWNzNYWWdy?=
 =?utf-8?B?T0x1ZERmZ1MrRUdEam8yamR6Mmk0VHk2QzVPWExBNCtCeXdCeTJ5ZEptNlhz?=
 =?utf-8?B?aU5nYnJqVldQeWlubzJPMUJjd3BLU0FLcTZFcmZyKzdFZG50TVBwRzlFU21N?=
 =?utf-8?B?WFdMcE9TcUQ3bW84SnFKOFR5djRJWHkxQ3pET3lxZk5TN2ZKS2JkWE1IbjYx?=
 =?utf-8?B?SXBpTHJyakVCdWtXd205YXB0OVZWaDBHQ1RBUHg2TXF1ZjMxS0JySXZ4Vzdh?=
 =?utf-8?B?UVJVSzRxSk9LREFJRXp3V3RSOUQ5ZVhwWk5IaTlLb1Q5d0JkTkNmWlVncFdE?=
 =?utf-8?B?clVEZFFsVHJZektBN2NWZlVjaXpGNzNCd2JoeGx4cnd6eWt0bTJBcEZvb0Jy?=
 =?utf-8?B?R2w1eXNqVVZvYk9VUVRWNFduMG43MzBMckhka1R6dGkzZHloeDIxTDZBemZu?=
 =?utf-8?B?aGYvOVNjczZ3R0lyd25tYkU5ZHpsSVhUYVc5U0lRbmZBSnpyeW9pWnlHL1c2?=
 =?utf-8?B?R1puZ2pHYkdpSXlaZlNJNmU0Znl2UUtXR2RhY0dzOHpROTF2WG1qRVNnVlZR?=
 =?utf-8?B?dFFKZCtCMVBKS3Vsa1ZyNXpOKzZpdnUxMHBiTGU4bHIwVWMyY0lJZUFmbjAz?=
 =?utf-8?B?UnoxUS9RZUdkdjMzWW1wY0ZNMSt4ZndFVWRqZGx1RCtEYSt1ZE5nRjR2TkhI?=
 =?utf-8?B?VU1qeVI0dXMvalJ5RmNSMGpVMkNjT3ZTTFFRNFFKcW5RdVh2TnZwdERpOFdL?=
 =?utf-8?B?Rjd5eW1KZU4xQ0tBV0NuZVdVR0NwdDJYYk42OGJVbFNod0RIeHpETmFHbFhr?=
 =?utf-8?B?L3Q2Mm4vWC9GNTVWQk9HS0xMNlNNWUhUbUMrbzJCL3Rxc1QwRUpkaHdiL055?=
 =?utf-8?B?UkVadksxT3J2RklNZ1M2bGphRjQ5TFN5QVZtS2pKUm12amlZcFI1LzVrQ0ZT?=
 =?utf-8?B?WEc3S2ppQzVaa2hNSjZlMkF0MHRTQkZoTDJkeFhaTjZlSUp4UWViUGJ5TzZV?=
 =?utf-8?B?cnp5dGlXWGpRK3hYQkxwMGpUQitOTmhlS2ZVR21ZOE10L2dXSzFKTmVvWEk1?=
 =?utf-8?B?dUxlVFFoazQxM0trR3ljQkRHZ25Mb3FoZGh2M3FwcnFmT1NxbHdSa29KRjlY?=
 =?utf-8?B?bFRKTStwOFFpZXpyMkdyOHhYaHE1cEY3YzVvREJFUEVMNE5ZNGEvNWY4WVc3?=
 =?utf-8?B?QTkydXFBRUUrakJhSnJ5Vmo4YzVnNGloa2YzUlJZNjQwdmlGWCtpbFRrVW5S?=
 =?utf-8?B?Q3M3TjVZUUI2UEdyVGdKaUpoWHEybWF0bmFtSXpqM1hIcGtVYlFud25BMDlo?=
 =?utf-8?B?UkU1TTR6cVQxdjRBR3AwN0hzaEwreFcyNTRaeUdYT0U1NlcvYlAwNmpkTkdh?=
 =?utf-8?B?UVRMaVVVYU5zOWliRHBab3k2aHdaTlpNMGh2cjM0R1pXOTdmWENvUU5uMlFO?=
 =?utf-8?B?ZTZKT3RNNk80K3ZaMk5aN3ZXbGlNTVBINVZ1YlNOWVo3U3JSVlphRTBMUzl5?=
 =?utf-8?B?cURtSWY4elNoQmNXUTRlbENQa2dDK0hmeS90aE5ZSEFuci94QU1uNFl6aXhq?=
 =?utf-8?B?cDVsc2VGSnZMVEVkUXY2a3FwKzZ1ODkvMXJITWxHUGg0azcwSi91L1l4M2dN?=
 =?utf-8?B?ZzI2NE04L2FyYnI1N3NlaWo1cGxZcXhLTUhJdzhiOGpiRGlCd056MEhpays3?=
 =?utf-8?B?OWsyRnllUUd6NTZ3QUV6ZnZFMHhQWlNlNnB0cTJueTArVGF1bzd1UGk3NS94?=
 =?utf-8?B?Qm9xMVhqVUZaVW53blpjK1lrYXR4YmdpaTY4UzREd1R6VzRHOElHUXQxc3do?=
 =?utf-8?B?Q0ZsZ29zc3JtQ1NnZk9ja0hCSmVReVFTT2RrVGhiT0xSNkZJSHBmKzloNVUw?=
 =?utf-8?Q?KdpMmTKYKPj/zS7k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E10DEB1217078847AA9301AAD2F5ABF4@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	WllTPL4N36ieCj7PJcXYImHVuxP5Wv34tIH+GhVffRfuTMpoadFwRC+BPlyB3LumHd0Boax0DWAlXVzBPJLe9xL/vlDQX8Zv1/i43TDiGQuA1smvM+rn6b8q6errF1RFIXhrz4UmhC1S/SFS2gyJTD1iyS57xq+ZswAvROioZOJi2EcvLOz9dOuzwUDZgW7QYeUxYNvwTO11XyszC6ykq10Q4JwxVdKdV/uSCUhTIUD95gRlZ3RW+jJ3JyEO5U7DzNVtLTSf5I1c9ntpnSUb8y+dZYo/EHHgZouyeHxssJl5Y0G7X0JuWEkNYskOmzF0MkgJn+gpBKBIjqo7Cg387w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934cc301-a86e-425b-96e4-08de94b3cf7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 14:41:53.3306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0P9ccBNky16hHsreCvf2YPIaHy/L1G4bhgvIJaQ5rENjIGVfI03LORevLHeIfcYuVN40V/BaalrfBJBISynf87PhWYiliA8gsAHbFHLnkHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB8876
X-Authority-Analysis: v=2.4 cv=S+TpBosP c=1 sm=1 tr=0 ts=69d517b5 cx=c_pps
 a=PAagVXhlguM9sGT4qHQNdg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22 a=Qm8iP6mkAAAA:8
 a=aH2rPjXTxZvyM4V2E1gA:9 a=QEXdDO2ut3YA:10 a=kDhhxE42lZnxL3pOKqYK:22
X-Proofpoint-ORIG-GUID: ryDXBlHhUiplxABDKzPqDdZdfGfyu2AS
X-Proofpoint-GUID: ryDXBlHhUiplxABDKzPqDdZdfGfyu2AS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzNCBTYWx0ZWRfX5QhkU3keQtcY
 uj48LwAdeq3RiEKOD4jNM8kfQDZWjW/MoF59x0S0OqfcWTdE+2pJaeIXh+w5X4Ye5waFcVy7r2E
 yzjsg9MJ/r4pqFqD7GHB4tvfQouzjYPMdEBt22mMq1oKSOZKR4IBEoV1PetE9YaYdwIjwGfMLh/
 jfMGvnkCqKQ7d2inddb0GAsCvLr9tu35F1wx5cWTUaFilOnwovY4lh4DwQDSAXoGa059qdhEpVi
 IBnEl4YOHHRMj7mM/xI1+XG0+4Bsr6GPiTOJ9pPd0pT+LDwg4lmQ3HIuhbDy5U/4pWqdmIVkIqG
 wY5yOxflQye2pyJAujAqrsZDMdTb3oaVzHHMwbqjGpcx/Pou5DaT7uyZyousPNoVjsESBtRTJR6
 zxnADDVqBCbNWEAoAK6CkNK+esTfdb89zzJiHHNSIroFYa03QtNPBHwqY2Z+OKCmPybUvk3fr9U
 bLJ3QcD9htq8gOcEeuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gQXByIDcsIDIwMjYsIGF0IDc6MTjigK9BTSwgRGF2aWQgUmlsZXkgPGQucmlsZXlA
cHJveG1veC5jb20+IHdyb3RlOg0KPiANCj4gT24gNC83LzI2IDE6NTMgUE0sIERhdmlkIFJpbGV5
IHdyb3RlOg0KPj4gWy4uLl0NCj4+IFJlc3VsdHMNCj4+IA0KPj4gSSBjb21wYXJlZCB0aGUgVk0t
RXhpdCB2b2x1bWUgYnkgcnVubmluZyB0aGUgd29ya2xvYWQgd2l0aCB0aGUgZmVhdHVyZQ0KPj4g
ZmxhZ3MgKCt2bXgtbWJlYyAvICtnbWV0KSBlbmFibGVkIHZzLiBkaXNhYmxlZC4gVGhlIHRhYmxl
IGJlbG93IHNob3dzDQo+PiB0aGUgYXZlcmFnZSBudW1iZXIgb2Ygc2FtcGxlcyAoVG90YWwgY291
bnQgb2YgVk0tRXhpdCBFdmVudHMpIG92ZXINCj4+IHRoZSAzIHJ1bnMgZm9yIGVhY2ggbW9kZSAo
aWRsZS9sb2FkKS4NCj4+IA0KPj4gUGxhdGZvcm0gIE1vZGUgICNBdmcgRXhpdHMgRGlzYWJsZWQg
ICNBdmcgRXhpdHMgRW5hYmxlZCAgUmVkdWN0aW9uDQo+PiBJbnRlbCAgICAgICAgICBJZGxlICAg
ICAgICAgIDYzMTcyMiAgICAgICAgICAgICAgICAgICAxODk0NjAgICAgICAgICAgICAgNzAuMDEl
DQo+PiBJbnRlbCAgICAgICAgICBMb2FkICAgMTAwMjA4MjQgICAgICAgICAgICAgICAgICAgIDc3
NTE5NCAgICAgOTIuMjYlDQo+PiBBTUQgICAgICAgICBJZGxlICAgICAgICAgIDI0OTIwMCAgICAg
ICAgICAgICAgICAgICAgMTE4MDQyICAgICAgICAgNTIuNjMlDQo+PiBBTUQgICAgICAgICBMb2Fk
ICAgICAgICA0MjUyMTcgICAgICAgICAgICAgICAgICAgIDMwNjk0NSAgICAgMjcuODElDQo+PiAN
Cj4gc29ycnkgZm9yIHRoZSBicm9rZW4gZm9ybWF0dGluZy4gVGhlIGZvbGxvd2luZyBzaG91bGQg
YmUgYmV0dGVyLg0KPiANCj4gUGxhdGZvcm0gIE1vZGUgICNBdmcgRXhpdHMgRGlzYWJsZWQgICNB
dmcgRXhpdHMgRW5hYmxlZCAgUmVkdWN0aW9uDQo+IA0KPiBJbnRlbCAgICAgSWRsZSAgICA2MzE3
MjIgICAgICAgICAgICAgMTg5NDYwICAgICAgICAgICAgICAgNzAuMDElDQo+IEludGVsICAgICBM
b2FkICAxMDAyMDgyNCAgICAgICAgICAgICA3NzUxOTQgICAgICAgICAgICAgICA5Mi4yNiUNCj4g
QU1EICAgICAgIElkbGUgICAgMjQ5MjAwICAgICAgICAgICAgIDExODA0MiAgICAgICAgICAgICAg
IDUyLjYzJQ0KPiBBTUQgICAgICAgTG9hZCAgICA0MjUyMTcgICAgICAgICAgICAgMzA2OTQ1ICAg
ICAgICAgICAgICAgMjcuODElDQo+IA0KPj4gT2JzZXJ2YXRpb25zDQo+PiANCj4+IEludGVsIE1C
RUM6DQo+PiBUaGUgcmVkdWN0aW9uIGluIFZNLWV4aXRzIGlzIG1hc3NpdmUgKG92ZXIgOTIlIHVu
ZGVyIGxvYWQpLg0KPj4gDQo+PiBBTUQgR01FVDoNCj4+IFRoZXJlIGlzIGEgbWVhc3VyYWJsZSBi
ZW5lZml0ICh+MjglIHJlZHVjdGlvbiksIHRob3VnaCBpdCBhcHBlYXJzIGxlc3MNCj4+IHNpZ25p
ZmljYW50IHRoYW4gdGhlIEludGVsIHJlc3VsdHMuIEhvd2V2ZXIsIGl0IGlzIHdvcnRoIG5vdGlu
ZyB0aGF0IHRoZQ0KPj4gQU1EIHBsYXRmb3JtIG1haW50YWlucyBhIG11Y2ggbG93ZXIgYmFzZWxp
bmUgb2YgVk0tZXhpdHMgZXZlbiB3aXRoDQo+PiB0aGUgZmVhdHVyZSBkaXNhYmxlZCwgc3VnZ2Vz
dGluZyBtb3JlIGVmZmljaWVudCBuYXRpdmUgaGFuZGxpbmcgb2YNCj4+IHRoZXNlIHRyYW5zaXRp
b25zIGNvbXBhcmVkIHRvIHRoZSBJbnRlbCBiYXNlbGluZSBpbiB0aGlzIHNwZWNpZmljIHRlc3QN
Cj4+IGVudmlyb25tZW50Lg0KDQpJbmRlZWQsIEnigJl2ZSBzZWVuIHNpbWlsYXIgdGhpbmdzIGlu
IG91ciB0ZXN0aW5nLCB3aGVyZWluIEhWQ0kgd2l0aG91dCBHTUVUDQppc24ndCBhIGhvdCBtZXNz
IGxpa2UgaXQgaXMgd2l0aG91dCBNQkVDLCBidXQgaXQgZGVmaW5pdGVseSBpcyBzdGlsbA0Kbm90
aWNlYWJsZS4gVGhhdCBmaW5kaW5nIGlzIGluLWxpbmUgd2l0aCBvdXIgdW5kZXJzdGFuZGluZyB0
b28uIEdvb2QgdG8NCnNlZSB0aGF0IHlvdSBmb3VuZCBzaW1pbGFyIHJlc3VsdHMuDQoNCj4+IA0K
Pj4gT24gYm90aCBhcmNoaXRlY3R1cmVzLCBJIGRpZCBub3Qgbm90aWNlIGFueSBzdGFiaWxpdHkg
aXNzdWVzIHdpdGggdGhlDQo+PiBwYXRjaGVzIGFwcGxpZWQuDQo+PiANCj4+IExldCBtZSBrbm93
IGlmIHRoZXJlIGFyZSBtb3JlIHNwZWNpZmljIHRlc3RzIHlvdSdyZSBpbnRlcmVzdGVkIGluLg0K
DQpPbmx5IG90aGVyIHRoaW5nIHRoYXQgd291bGQgYmUgd29ydGggZG9pbmcgd2hpbHN0IHN0cmVz
cyB0ZXN0aW5nIGlzDQpsaXZlIG1pZ3JhdGlvbiBiYWNrIG4gZm9ydGggdG8gbWFrZSBzdXJlIHRo
aW5ncyBkb27igJl0IGJsb3cgdXAuIEkgaGF2ZW7igJl0DQpzZWVuIGFueXRoaW5nIGJsb3cgdXAg
dGhvdWdoLCBidXQgd29ydGggYSBkb3VibGUgY2hlY2sgaWYgeW914oCZdmUgZ290IHRoZQ0KZXh0
cmEgaGFyZHdhcmUgdG8gZG8gc28uDQoNCkFsc28gaXQgd291bGQgYmUgd29ydGggd2hpbGUgdG8g
bWFrZSBzdXJlIEtWTSB1bml0IHRlc3RzIHBhc3Mgd2l0aCANCm91ciBwYXRjaCBzZXJpZXMuIFRo
ZXkgZGlkIGZvciBtZSwgYnV0IGl0cyBhbHdheXMgZ29vZCB0byBnZXQgbW9yZSBleWVzLg0KDQo+
PiBUZXN0ZWQtYnk6IERhdmlkIFJpbGV5IDxkLnJpbGV5QHByb3htb3guY29tPg0KDQpUaGFua3Mg
Zm9yIGdpdmluZyB0aGlzIGEgcnVuIG9uIGJvdGggc2V0cyBvZiBoYXJkd2FyZSwgdGhpcyBpcyBy
ZWFsbHkNCnZhbHVhYmxlLg==
