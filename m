Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059402AD3D;
	Tue,  7 Apr 2026 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775586639; cv=fail; b=kjCcGCaVmVi9bFjU7U9j1KG1iLGaggfI03nWRD91S1zOjmws0zpoAcGiu2u6xxtODS1JT5fQGWEKZ0Txvul8SMbXwKJvEXkWT53Pf75TSIUBiy6y3lN7OUErUE8QVyLBsAg4k+VN4XTcF/S+S3+CapiwOE+lm43WiRtM2rsoatY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775586639; c=relaxed/simple;
	bh=tVd7kDNbID8KAUMoHxxKttDhKCzuyeW+LqVKqIAde90=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NxriPo9Jz2rMLUgY02kK0mMPsJhFMJQJWClJ7s1dI0pHwdtiMXd3WhPb1Y3FHQGaMqHL5igDSJ61JCOJLocP5p6OdnY/zEOF2fniIIIS9cuy10rhQre3aZZ7qURA06lOy3GjC82AYIiv75gngpsCLjf81ZAQytdxm6BWjIeNP3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jiBF4NnQ; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jiBF4NnQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C35QK3YiQcxk8qQxJNTcjX9JGR66qRxKVdLZEoz+CWu2hV228TGQL6QsVI79pb764yZ/uNuOn4KTGhP1hhT8hykdpExZ5yA2yZZHnOCWBfTXtCL6R+9TAtrLyWaaALtomyP3ajv37D3uDn5iSKdzNoxA1BOErLNQloU01naw5JQ5XlLlJnbZeYFtYcFvoT6fcxyvfi4NqfPxLH9wtVYIP5khozLIOBPRAvg0EDLjBKqdjEPYmBF+cgWrQMyok2H9BJNRK7M+XUNUeunnn+qDo+54/R6uFBOMh2Q2JuZzP84xIrmSJRW7YKxAOgQn9UQCdp4KXSXuFGGzLxhRBXiU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7nvvKctgmD53dkZX1YSEyOnbZuyqbKkvYAZ0bsY3Mc=;
 b=pz9cLYU4dwyqmmgPLt09/q1itfdVK4DDNFN9xYS4HUg4GVxQ9HQ88Y2iM0DGSNoGXMFWKNyM7JdygiSjoPaFVG8+TAQcya4KOh4C9YvudXOYP0mJk9RKArb79vadOoIVBPqVfFiSfKNgr6+GoPD28FloPOx4fA9H/S9ShiJQJ+wGzq90zdLa3i62F0Aqyqz9sfMztUbv0MKMrgdSc+KQeLM509G8l0vFGIqM5OGpTxoW7p4yyrQwXQnrkuaJnwQ7pdF5KseHoFMlTqTu+wiyUC+v3v3tDx5E2+NfF2Eux0WRnGqt0bv47zyo9WQv3q7nq5EAKH9WwSoAUxB/mEm3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7nvvKctgmD53dkZX1YSEyOnbZuyqbKkvYAZ0bsY3Mc=;
 b=jiBF4NnQ/pW/sfLPZKLusBFNEkWQUB4sTJxHNYE1Lhu6lVbkvIxtCuiiJfzhAOakbUvEbfNBjmpbwVhrcVuSOL3xw3+Nk8KyEpRPexATSQptWqDpa2fHnHh3jMun1tKlITOwvi3x0pew8Sso1pPIJjmh/K8c+4kqA+D9XJYWVnY=
Received: from DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) by
 LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Tue, 7 Apr
 2026 18:30:31 +0000
Received: from DS7PR12MB8201.namprd12.prod.outlook.com
 ([fe80::e5d:5f41:954d:be38]) by DS7PR12MB8201.namprd12.prod.outlook.com
 ([fe80::e5d:5f41:954d:be38%2]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 18:30:31 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>, "Lendacky, Thomas"
	<Thomas.Lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: Bug with nested PAUSE intercept on SVM
Thread-Topic: Bug with nested PAUSE intercept on SVM
Thread-Index: AdzGtpiRjeqXsvC5QHu6t6J5p0N2hwABTvkAAAAZvfA=
Date: Tue, 7 Apr 2026 18:30:31 +0000
Message-ID:
 <DS7PR12MB820106A839105CD9E9E62328945AA@DS7PR12MB8201.namprd12.prod.outlook.com>
References:
 <DS7PR12MB820101CABFA34E85442EA256945AA@DS7PR12MB8201.namprd12.prod.outlook.com>
 <adVL9nqJhJwvu1QO@google.com>
In-Reply-To: <adVL9nqJhJwvu1QO@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-07T18:27:46.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8201:EE_|LV2PR12MB5774:EE_
x-ms-office365-filtering-correlation-id: 1509f9c9-1524-4dcc-b2c2-08de94d3c016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 2nxotJRSiLuedojcLRk7hfdcy5Mcsv2UeZc5XYUnBQ85W19cgMewECwo2ORpUj0iQMeKbPf2QBiIoJZ5LEiw8iVVGRAdJ0oHGr+6nUvmKxCUvg858QzdeAl+RC+VeAiG2vkVWtkXDtmRXiQBWwMu1cSUcKTnprrWqdQjM68P68WTRo+O64sw9qemVGk1oBtd8JForer5chOl3MZ4wPE4lHUUHI0/ebr6Ngwy5DIhA2qPU5gPYpJXOXRtn4QJNac/b4PeESLeg8p9uP/1wuXw3KjvpK/1f5je54cXV+vNvMrdggIF2NxUTRxOjGJz4CuHPuwlc0VIcj0TcoNMoL4iPK4u2vk/38cNK3qblbeEeVygiPg2HE48eoRo12N4GRAVPZTpJKbbcfAHzQzl3ZLYvFkw3RLSo8gi/NGytgmldJKXG8leQs2zyiTg1DwIt7bZF7NnlP6TrxcnO8WYl4P+wlw11TnNT+bZMXKiiZfhS9Z4A6qd+19G7r+Fbdn82YVv7u706u1Z0ZXcNG2UWg288Tbj1F6YinaHAePCyWvS6NLBrNp0NK8r2MNdsYrXlY3odA7KW1dzszetvvU1EMTdW3js0eBGgc0vu4HXzKTVNLy9AHMRiipGj3IlvJAs/IwiXJySvAH9SIiiIcJqin3Y+kf4SsuHdokUIL+24x5QYrk8F9O6AXTbIo/JjtXOfJQ84x7PK/esoWooU3toE6j9SgpO5/1iPec8OaA6f45SrCXGjk2AxinvLV0yxu+bmsdbniTXMN9FNInU4MeNkaC0MiLCXxZa2C+4riielsBkAO4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gvZCiBM/3+1yTD1WJt4eqUQUYYgIhfbAydjrc5/d9D2pCOEWH9KZntzUFHOD?=
 =?us-ascii?Q?ByCwGbrrm6NdpfcQZCtl2b1YuFOg+n2v/6XzkkdikEx8xx/1MnAuYb/jE8pJ?=
 =?us-ascii?Q?CJZMSKCs0jS2EL61kEy1/DuWJnPdeA++Js4HuIUQnLkNy7eS90SP+/P4WfCq?=
 =?us-ascii?Q?Tu7O+LL3UBf4QzPaJx9PBpe6h/QXYguccD5ON2fA9esYO2JJspTspzhtliFu?=
 =?us-ascii?Q?xVqLzUkXafNtjh6ZMv4aFMs4JZtMGRcferoaW3SfNbWoJVWrNADJMoI7U8us?=
 =?us-ascii?Q?YaKEgUUWs/NJxjjbXKrtpNntQfvBeGBVG0VGyxIAQPa4qErnekxsB7B+OetE?=
 =?us-ascii?Q?YrMBkNGTJHlpRgVadkBTVz9bq41ocPcpdB7v0ibmNUZTHWfBC5CY52Bkbtnj?=
 =?us-ascii?Q?jkHssj9eNe1CJBckFKYJP7aVZHsCmce7X1KMIoZ6W8yGb/gNj72k2yCIhnzH?=
 =?us-ascii?Q?PxZDIz5zHHavtOPi+9+m2vcGfew+eS6rul3YUjxlwCngEqxqF1gARizfSn/0?=
 =?us-ascii?Q?MSmfY8wprop3NB3buoBP/AlyjNBLVdpWkvde4CgfZAXkyfjf7TEM3Kt0xTFo?=
 =?us-ascii?Q?ERUM5NSqEIkL577GDBxhCpczlEObVB5bS8UEX63A1a5a9HrdN9zOO3vMSqi3?=
 =?us-ascii?Q?WH1xajb/vVAJuzDOjWTaJ5/bQHaCoXNhn0CcZuF9dd/Hmc8E9AxNTZggIcpf?=
 =?us-ascii?Q?TKNtTx1mCu7n3myyaMkGvY8xHdSzISUdeqbut9cr2LyGq2XkPbXiNhSQdput?=
 =?us-ascii?Q?6Zi63pYCMDXIP9y7brlR/XzveObKyLLf053ylw0XhqE+DtGhGzhM/V5+Jjcu?=
 =?us-ascii?Q?HoV4lJab+6Ho29s9p+7HvyUwK7yIsqNdqYiQOEmT4ViZsXstg0MgBJjfn6pm?=
 =?us-ascii?Q?gjmCVAHz36+VIwSdn2wT2g9UwMByeSTloxk1T4gYjrepuO+XgttGqg1Y4t9S?=
 =?us-ascii?Q?e4KxFi0deMcVedXDiAfSmzhZ1hNZWbSGllaqnN/VjOKbuYX7/5ICW+ekE+mM?=
 =?us-ascii?Q?OuzyjTJSMDNtTvYgVX2LhFsTmcvKaY7LkHP2ogSz5qOcUlyxK4+PLMJlQjDd?=
 =?us-ascii?Q?JlVfZwUVt+edmlCbwgP4K+O3Go3g5X3y5LqfwfDgBGJ29SftteVBDV9oEoDm?=
 =?us-ascii?Q?nc5sgS39xCHpp0fmjtmLn3lXDuAq7Fta23caoesCkUVDWs78+U/Ps5pBjvji?=
 =?us-ascii?Q?iM54SQ4O4enQ+DzTMBbvN598QE2Le7r5Tcw8DW1NJieAJvC2JuYUlepBf//i?=
 =?us-ascii?Q?z9taNV1B7XejcN6T6W6F6GXeBALpztZm3riJwPFQxu5Axnwyy/d6hVgItMX3?=
 =?us-ascii?Q?zNrrs2XwObCvUr1wfzkOgvmoQP2k3/0AUlbeIXGSojjlgjQh5YeEtCBc/52q?=
 =?us-ascii?Q?GHaAtJKmmM48shKg1s4TgFEd4Elz2RsIfv61lGVYsklAxt6FFbU+G4QTMpaI?=
 =?us-ascii?Q?DL4hwQVBtLxDi9l7naEeYUKjEd+BGrQTApVKFgN3oczNFqVk7sXmU+UEUCLp?=
 =?us-ascii?Q?yh0rqwVcsbe3iSu15Xt5t88L8IBgZ//GqciD2Fu4auys4jhYcDZncyIEcIQV?=
 =?us-ascii?Q?3VvIhf300GH3BRqKoWr23o5ZG+G4EDfHGp/+vWh7kSfP9kr0EC9Cn7SUR2lM?=
 =?us-ascii?Q?S7w5DxEPzIcxdl/sJe9MT6ImBj5UngRV+QhCnnAJ0Es8CXyA9xAQmNPa33GZ?=
 =?us-ascii?Q?X3eqcC+SfZklk2RuI5D37FUSbQngsuu4R76pfgyWFA3wir50?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1509f9c9-1524-4dcc-b2c2-08de94d3c016
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 18:30:31.4880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPvkhVMEzg0rIRLvXT1TVpNTSXMZLXXnvov9qUSuiHQ8Fwr+iF/5btORaQBmNw/a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Sean Christopherson <seanjc@google.com>
> Sent: Tuesday, April 7, 2026 1:25 PM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: kvm list <kvm@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>;
> Andrew Cooper <andrew.cooper3@citrix.com>; Lendacky, Thomas
> <Thomas.Lendacky@amd.com>; Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: Bug with nested PAUSE intercept on SVM
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Tue, Apr 07, 2026, David Kaplan wrote:
> > Hi,
> >
> > On AMD SVM when the L1 guest is trying to intercept every PAUSE
> instruction
> > in an L2 guest, the PAUSE intercept sometimes fails to fire.  I have a =
theory
> > on the source of the bug and also included a short reproducer below.
> >
> > In this scenario, L1 has created a guest with the pause count and thres=
hold
> > set to 0, and the PAUSE intercept bit set.  I *think* the bug is that i=
f the
> > vCPU gets scheduled out on L0 while we're in the L2 guest, then upon
> resuming
> > the vCPU KVM calls shrink_ple_window() which doesn't appear to take int=
o
> > account the fact that svm->vmcb might be for the L2 guest and not the L=
1.
> As
> > a result, it looks like it sets the pause count to the default (3000) c=
ausing
> > many PAUSE instructions in L2 to not be intercepted.
>
> It's probably even simpler than that: KVM is completely broken.
>
> https://lore.kernel.org/all/20250131010601.469904-1-seanjc@google.com
>
> Paolo, can I finally apply that patch?  I brought it up in PUCK a while b=
ack,
> and IIRC you were resistant to dropping "support" for cpu_pm=3Don setups.

Interesting.  But does that patch solve my problem?  It looks like it would=
 still call shrink_ple_window even if L2 was scheduled out and change the p=
age_filter_count in vmcb02, if I'm reading it correctly.

--David Kaplan
