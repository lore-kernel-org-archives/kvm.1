Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011062.outbound.protection.outlook.com [40.93.194.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799AA34C140;
	Thu,  7 May 2026 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778190616; cv=fail; b=ReUChnexGZlpor7A2hDhZwts+9R2S7XZzj4aXZNOn2gm/VTRXxc/stqxDY3OtqiLA+ooIxDdq5qPhXMvfGVw8UMojqoK7GhvRYP2jJevRIveFlNaGCceqBASoPlluQ91CTNTodsVRPbywW2omhigsSDLslwsiiKYg0z7I3cvtUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778190616; c=relaxed/simple;
	bh=Ocmx+XJgtGVVaKlOeDNKWPorPmL6bRsgXbjtevR1kiw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NAhMODNUdpVv0x/5KrF6HNWsyrsEfHJEQt3QullGDQXz/7/abBz9yxnB6UB71qOc8efFamcZwEGCfab8UQ2FDXqTVXbnUccIw4rsXf7y1N0aHN/56fPBDAv2F97l4iz/uedtRFtJxK54b2rEDm4BaevJcUOeVSxDjQRivK9Ih/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kZnCO3Md; arc=fail smtp.client-ip=40.93.194.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kZnCO3Md"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2DOUg5Iwpp2nCas1+qgoEif9d77oNRe4jxcSMMNhUNAz/Y+SiG6fC7BNoA+2NnR1S00YPO7ShB0SJpiL1pXgtN4qtnSEkbgoueD4kqz0E6L3JyTnRaONP8PiVGXJ/Xcw0JseFf85bY+Y60iMTCZRI4l2+qVTMvzZqQsbHR1J72vksSCUaGUmRJgyvCRsrvO/Dn7U6C8NXRhLxFDPTVp5wnw3UsW/zCuwXvgLNHyHTzWxN5z5GIe4b73LvB8VxtN7b4bCM8dqyheH76fz+KCw1UMhJGR3ykweRzBGBBqQAMGcqo7b/UpHaBbrFfMiTfKkv0n3S6xZ0jv2Qrthilx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DT/7TBhap3Cesu98d548u1+IG6riXOGevdycXz0ACaU=;
 b=Y+GmhFvO+fUJlNosMyfghhEcSt8r+kk+I0QOhMZ0VF6is+kaTPJVD9BY2xO84x32h+OKLEx+z4DA9cqUw+a0hQ0BwUqRCAgIqm+prBlnRN7L0KnxToyCP7SIWccXyEdf1xgFt8BteUtx+cOrD4agCA09nJkpBzPvf31fFTJdBMLbPB8Hx7GIadEwH+uuz3ppeG8Z0An9JaBVo7ZC9H3aF35RGYCuxw5WdL/71w4vwDlGzduN/QmYvwKxjRT7xFcQ5VRRnyC6bD4+/MA38hahB2RZbKr9VZ2OjaTCQds2ntBt7vN1ejmrs45rN52ua4FPyRgcfnmuHWBAuowUGk9bgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT/7TBhap3Cesu98d548u1+IG6riXOGevdycXz0ACaU=;
 b=kZnCO3Md6djaMJQLZKZkjdbHeiMQ+NJiCpMBly3XADh90YvwrDpx5RU8TqY7Dgn897zmJmufNYvOWveHIWnY+8muWJ9p2m28C4nElJ1LWzXZboGwqP6ol5L/WEKRG1ZFQW12AzBVFlKSpFEiaGZluFAV3TTtrypTfoQ3OhRv78g=
Received: from DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) by
 SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 21:50:11 +0000
Received: from DS7PR12MB8201.namprd12.prod.outlook.com
 ([fe80::e5d:5f41:954d:be38]) by DS7PR12MB8201.namprd12.prod.outlook.com
 ([fe80::e5d:5f41:954d:be38%2]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 21:50:11 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>, "Lendacky, Thomas"
	<Thomas.Lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: Bug with nested PAUSE intercept on SVM
Thread-Topic: Bug with nested PAUSE intercept on SVM
Thread-Index: AdzGtpiRjeqXsvC5QHu6t6J5p0N2hwABTvkAAAAZvfAF68uBMA==
Date: Thu, 7 May 2026 21:50:10 +0000
Message-ID:
 <DS7PR12MB82010A5DF5F8DE5830CF16F9943C2@DS7PR12MB8201.namprd12.prod.outlook.com>
References:
 <DS7PR12MB820101CABFA34E85442EA256945AA@DS7PR12MB8201.namprd12.prod.outlook.com>
 <adVL9nqJhJwvu1QO@google.com>
 <DS7PR12MB820106A839105CD9E9E62328945AA@DS7PR12MB8201.namprd12.prod.outlook.com>
In-Reply-To:
 <DS7PR12MB820106A839105CD9E9E62328945AA@DS7PR12MB8201.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: DS7PR12MB8201:EE_|SJ2PR12MB8181:EE_
x-ms-office365-filtering-correlation-id: ebf2138e-0825-4abc-51c9-08deac829cdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|38070700021|3023799003;
x-microsoft-antispam-message-info:
 Mq7K4os5UBowdciZT2iZd8G34RABExujE1hhCJzEQUJECNKj5c69X6fHdVM9GXfzoYU8I6wg3srP90OBqlR2omMGzR6qm1SsPPVKHvYUieeMwCGBY7qlDbrO5GRB/1Vc7PeQt4Atw6trD0gbT9EZxYnsjFBHtPXNP5YDO3JyAOMYOlE3Wd0KXFYYfXiwZy1UQqr7L28BK9xyBJPPrsmWCqIeZG06z6B9RbpbCffQ/Xf5cZaqEwQmEgebqw3YGjNhni+wpVWpNAhXXo4hBnYsj9zttH0ocBco2zdqx1VXo/NLrW/vsmMdHzP4xrhMUdMkMfCdFXXGiqaSbaqMl6sDmF2hGmjO7d76DyZDUpWrj404fKZUTnhfrPQw8Cq+8wBFXkW/TfdgKd+r92w1IsOqdGerKPd0ZWiudCTMciwsCUgcA/K5HLHdXstCdk4LTVJ16ds6kIaBmwtbgDNDfBgGkonxiYMyWGo00NZTeId7Qm1BB98OidQe5Eja35xW6rdWrMtPaeALaLyv+FWAkFrHXbBBCEGpqK2VvW0k5Z8ILTQIJ0NG9tC/fT7VmFgi3/MuQ2OWweP3fNCCp5Cggt5ZFHUu11v8QzXc0GUjVvTY2FWVLUiQDojBeH14mfDI6ooW6DZ+ifnDsrrSh0u6Ir+Q7lo+8FMAkpJlyTQK+ASR1IT+9g+ym3uaVmzB8oDgm62SZ83MnopOVZF9qKffpJi7VKWpq16CK4zeAA5wvnIaRjSmbg7qUzUeSCLbZy9mKQms
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(38070700021)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DxqQN4EhB4UqOEP08nh3iOrOy/PuBHNoyEWE3xfIXimm0pA+AnHsuIbgPQAP?=
 =?us-ascii?Q?BxSvdP3lBwUqFIy0BkxGgX0UM6Lpd2wgAP370FeDmxjK5oCHTX0GX8NNTxyy?=
 =?us-ascii?Q?U2c+X0vOqdgY9FJsvK2pkd1F7fhRszzQLlLEW9vgMlKOInChs8SQxI8zMZJC?=
 =?us-ascii?Q?nD+a9HnBWKuev08iTOhfTSLPnyKtNUjZabD8QvwPKqXSQj4XNDwN8Fmxh52P?=
 =?us-ascii?Q?ORzUTvrIPdURMvj/Chz0IIAUYboV/LMM5jjnMa4zsMIgpYs/r5uK7CAsM3oo?=
 =?us-ascii?Q?bw7xmDedaSiBspS3c4WL9q59KolbeNy6oEIPlTwgS5XsJI0cPngRe761h/ku?=
 =?us-ascii?Q?qTzhYhGfnwe1il+JJm7itKsWvpL2Zpp/JgJjMPxrxv48jfI7cXl2XsO39R+d?=
 =?us-ascii?Q?z1CVHpGC+pjjcj7ZELe4zD3uMqRiyWWHFt2OxJoaFnkItuo/XnyV1x+/1rRc?=
 =?us-ascii?Q?h1JVi1tTu6r+BVVNkEyj6qXUb1SkWyZIt2t6++nWN6Zkz7irjt9avjAhO4RM?=
 =?us-ascii?Q?iG2aO2RkmgqPRm8yr9e5bQVZLYQyF3UDwXoQBukKpZ/meyN5IoOh9n4G38fE?=
 =?us-ascii?Q?VyZHPtcGiql7HwaVklNROwuueJfPFlJpHwJh6vnpVgnwPRbgfx6Z3Jdhy9oL?=
 =?us-ascii?Q?4PaQsKk1T01p6hN/NY5D5NbLUR1Ocw6CzlC3C6D7tH1tZmfeMSrw8I5lcQtt?=
 =?us-ascii?Q?GmDd1WQTF53FB4WR+/IQsDvSZ0yYTeS5tRxgDAz1VYP27InSHRAhrP5ghlkP?=
 =?us-ascii?Q?6lnztO5IqlFjERMIW5a/wEy5Q2qGOpLByMUvCzjq/n5/KOcyY/qdUAnf4jXS?=
 =?us-ascii?Q?I+XLOGp01KZANP38puVO1ghzR+pJkC6H4w38aiGJURUxEGdOobtvEb5bdgpO?=
 =?us-ascii?Q?AsUDuoua/8MskTk/m/NCcgGt9fRjOb3mtXrVn6TWDsA5fo82quUqU4tmkSK5?=
 =?us-ascii?Q?uq8QEGMTZvPpSLOqB1bZjW0vE8+ncQau3GUGv1a+W2f6xY7Rz3N5qy8UMyDm?=
 =?us-ascii?Q?y1GuIvW+TvsFRTza8tzYtYnWFshzCUN4c+ChxEU42bqoFBdUpVp/zYMwlWJl?=
 =?us-ascii?Q?GNtj/YVEVTqeUn76lBDx8BZm4atxZiPOGaBMOjw2P+uir47vtyYveSCrN2qb?=
 =?us-ascii?Q?iSYUfptIUb4/WtU/vGWltvYU3JNYwZ90vfff1nTlYy59QLtCAiEdD5rh/szB?=
 =?us-ascii?Q?sR3pa3ZLvq9dl9e9Y/lcXdeQRB4UXgDnHf4xGn1hZolzf/9dkfj1NtINg5RU?=
 =?us-ascii?Q?B3zsGwuCCfGOlqrXJtgNla4vzoxoPMxAHRnSBkPPp+LbJnWBCWSd812fwg1c?=
 =?us-ascii?Q?tJ8iqTR9mAPR48kRWYiLsPjMlRom0RLcFrnhFVt7IDNVquYxezZ/cjfdBO6h?=
 =?us-ascii?Q?nHPdV4p74oZ4jbh/erUbDis2ZCoOmtn9vtkyVkVTgKnd1ZpdRG7VszB8o8Aj?=
 =?us-ascii?Q?ZV0S2HpoqiqhU6V/cGuVHpIiD7de4ai5yJ88IsUrdFxtzoE7DA2igg/fVzGd?=
 =?us-ascii?Q?rzk8A2K/6YksWypP8CfYkQJwxx/hbvWBqaB//5hWiI1n2S57KFbDW7yLJcqY?=
 =?us-ascii?Q?KdU7UtXqMInwsCS5C8iIlnX8+GG99tHEYMOTGKT3ML0i2ODtEvdFRYWAbJsd?=
 =?us-ascii?Q?mlcJAneFwcYuQ+va/LIAGTgkQAcKKnDU6ulOO1iQSAWm0B38Ex3R3hYfMC5o?=
 =?us-ascii?Q?ihMFv94YW5woW6F+mJiqlxf7V7vbOq45fEM7G8DGnZPkyTsN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf2138e-0825-4abc-51c9-08deac829cdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 21:50:11.0400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CqrWz3ocMGQKQWA/FlfxiMb/lQQNStEuu1/9VCF6J9I0mNvelO1D8b/OmqjkrT7t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Kaplan, David
> Sent: Tuesday, April 7, 2026 1:30 PM
> To: 'Sean Christopherson' <seanjc@google.com>
> Cc: kvm list <kvm@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>;
> Andrew Cooper <andrew.cooper3@citrix.com>; Lendacky, Thomas
> <Thomas.Lendacky@amd.com>; Paolo Bonzini <pbonzini@redhat.com>
> Subject: RE: Bug with nested PAUSE intercept on SVM
>
>
>
> > -----Original Message-----
> > From: Sean Christopherson <seanjc@google.com>
> > Sent: Tuesday, April 7, 2026 1:25 PM
> > To: Kaplan, David <David.Kaplan@amd.com>
> > Cc: kvm list <kvm@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>=
;
> > Andrew Cooper <andrew.cooper3@citrix.com>; Lendacky, Thomas
> > <Thomas.Lendacky@amd.com>; Paolo Bonzini <pbonzini@redhat.com>
> > Subject: Re: Bug with nested PAUSE intercept on SVM
> >
> > Caution: This message originated from an External Source. Use proper
> caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Tue, Apr 07, 2026, David Kaplan wrote:
> > > Hi,
> > >
> > > On AMD SVM when the L1 guest is trying to intercept every PAUSE
> > instruction
> > > in an L2 guest, the PAUSE intercept sometimes fails to fire.  I have =
a theory
> > > on the source of the bug and also included a short reproducer below.
> > >
> > > In this scenario, L1 has created a guest with the pause count and thr=
eshold
> > > set to 0, and the PAUSE intercept bit set.  I *think* the bug is that=
 if the
> > > vCPU gets scheduled out on L0 while we're in the L2 guest, then upon
> > resuming
> > > the vCPU KVM calls shrink_ple_window() which doesn't appear to take
> into
> > > account the fact that svm->vmcb might be for the L2 guest and not the=
 L1.
> > As
> > > a result, it looks like it sets the pause count to the default (3000)=
 causing
> > > many PAUSE instructions in L2 to not be intercepted.
> >
> > It's probably even simpler than that: KVM is completely broken.
> >
> > https://lore.kernel.org/all/20250131010601.469904-1-
> seanjc@google.com
> >
> > Paolo, can I finally apply that patch?  I brought it up in PUCK a while=
 back,
> > and IIRC you were resistant to dropping "support" for cpu_pm=3Don setup=
s.
>
> Interesting.  But does that patch solve my problem?  It looks like it wou=
ld still
> call shrink_ple_window even if L2 was scheduled out and change the
> page_filter_count in vmcb02, if I'm reading it correctly.
>

Ping again on this...

--David Kaplan
