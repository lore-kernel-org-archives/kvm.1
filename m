Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637B3B95EC
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784583753; cv=fail; b=iqZtPLQ/r7n7oJ4kshqm9/drZd8fz40DtEcQ7j31poinDumIiGfX7bqRjmJg+MB9RjJzht2a7q3OnDzCU1dyi013/nDDiAyO87SbakZwGvih3VvS6tWWY1NXp35H9D1Vda3m9UboPTHhOYPX3du1Vg0cA/FxpaprEsMo/Zk/g3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784583753; c=relaxed/simple;
	bh=bB63kpkHGeCH3nhFSqWASGVwvX8kSCk+kMps08Cz2iI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VzZgcVddLhtEUL+QAUp1Y2z9x9ZGC6nqiwHYjrY7ZbExj+5iseof/RDjGfUhO8Min7OIbyC2GV/5bAajzw3cci3ZmgAOe5nIh8zpbnYYj7kyZfjZTSlR9pKiFKlyuMsptD8O9AChU+ptCG+kqCSJgEo4rNsJTy/U7+VWvByn+2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fmU9iynK; arc=fail smtp.client-ip=40.93.196.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fmU9iynK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlQckPQZzF6xx6799Oy017w1YpDfrjCfx5x1q/luP251aT+VLVEWQ9TZWcCCVNaXyuMoDJ8y47KD/F2iUIpo5PmGiDhygcvCbjm96g1fzn9c0ttAuhbxRr6yPnj1Q8ZilT4PmGgXRGW8vqzxRM736h+S0I4MMt32Vl7WooBShoAN5O5LFZi7SLLhUiNAvC5KU33/C9RY4x1bEqkF1z0TJtt0U7wb85sYXPUn3hHp1cuJDnwzbioAEPPLz3CW5uWFQrdmysUgHRxNHKA9gGRgJXgOKup5qonEyVYbWCFVa/tsKEA3Ut7iKrmH++7cosOZk/ikbVbdv4wH6cSLo37/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQVy/rSssoTHdHAzHFVqaIpNfZFVC9es+NOK1Lh9ceI=;
 b=xN/16QS/O/wd/OlbqACzO8SfrRu+MTm1VTHpcIdqBaSN568ev2YAE6WmZUbeo3NM6SVfcFoEk0swuwSABC+5NwKDnnVjEFxtZwhHVnQIQ9aPcFan90ZZRTesrEFrJ/EFZhZrz+wZkjdSuQlxJd23XBjJNdUPFhgwKz9Bm3BN7KZIIPGQcvZKqFHpavhsrb/hQJDQEe9ADIXOtY3qXp+Q2pKbJd3OQDn27F7K03hafLbCsNc3/Qa/7eJEkIIihKTvU53TNDKQCy6Ell/XVDatpcNrUtpeAzoO6xYqly+P6clq/yYtqGu2eeNA7AZWQXZ56KibtfZnENyDOqq5camMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQVy/rSssoTHdHAzHFVqaIpNfZFVC9es+NOK1Lh9ceI=;
 b=fmU9iynK9jydtcuFRvf/LqESDkqYeX/5fE/NmLQibAhvdN80YNw/8RxuRdWecC8HiI8yflDQciYKlE7nwZMtIOhbKb15aDNVRV9+RHo34xtEovojoZgAbVlJrx9HW4tHBsMYSX+aQtdOgUmvCqhIe8Rf2utXPQrelVZsA6wVzk4nT2jUtN7112faVu6go7C2nvccAt0wsiutYrsDbSp6WdSzt3EfX3Gyk5UqYyISUHTf6tIlH5pxJkP1smSO1rDyMPE7m2uJWL88g7u8LuxhdhcplF1ULy7vPISfwVgSJbXP3Lx0Q++LTwuFkY+QFNZauLzBTFE1v0CTjr5+Al2/xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by DS4PR12MB9747.namprd12.prod.outlook.com (2603:10b6:8:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 21:42:28 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 21:42:28 +0000
Date: Mon, 20 Jul 2026 15:42:27 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: Josh Hilke <jrhilke@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, David Matlack
 <dmatlack@google.com>
Subject: Re: [PATCH v5 5/5] vfio: selftests: igb: Recover after DMA-read
 faults
Message-ID: <20260720154227.1f727abe@nvidia.com>
In-Reply-To: <CAAdrzjsNJfkFjwK4Nwendph60=FFhYCbXkXzTXO354roK3GoTQ@mail.gmail.com>
References: <20260714-igb_v3_b4-v5-0-91503eddb98b@google.com>
	<20260714-igb_v3_b4-v5-5-91503eddb98b@google.com>
	<20260714211204.437281F000E9@smtp.kernel.org>
	<CAAdrzjsNJfkFjwK4Nwendph60=FFhYCbXkXzTXO354roK3GoTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CYZPR12CA0011.namprd12.prod.outlook.com
 (2603:10b6:930:8b::12) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|DS4PR12MB9747:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7d1254-1015-4b06-84f3-08dee6a7cbc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ndh5P0oAG5Cb8Dv72xBoZa9goHxKM6fGoCM3jl7vsUpjvCR5lmyTimMUKg6JT0nAxjVptsWcAxLHSmYSX3EG0RiRK+h15iA8SykhslS92Y5utkr9LuL/oMh0PhLbuAuLPg9I5L2zLb7rdqU/sL/3eTjmw0m69oLk6tba8kfKxGb8KFc/N1un4BV7Ubevr6CmEBF+ZTx2XZK1cxRVqDhGYmuNlfXugP4+SoTTssb9aduoxXhqCmfBPGyQVagcBg3/YoPz5hz5KOf1+L7dKqw6nNMn+KV1D9eft+q8DJvL08FFzdkFQ7maotOj5EqFlBysAljJqkx8nGUjZaepp0hP7owwNs0fMj0B08o8UC9FJaTGnqrekN7TEGbfwkQEgqQWH6fVrjK7flM8aAs5iCbRR4D4iM+tOZCJGIGBWsGZ+KRHBSG+YIXYjGfO5ddGKU/TTcsyfJXuu8VEfIVQNDb1aZ5c/9nknITNoZpTfHdSrhjfo5S2VhS+NR7yrCtHj88UUglRWbXAOGEf35Wvrx9jERSoYtRWRsuGxKv68MTP2E/qY1zJ3pmKEvLUsHB43S/dbBDGUroLBoCm5eKMx+wKPWYYDTBuSOXzYJklWbZdNddC5I0IWnbMjZnEM7GwZmHvh7JqNDuxj4MzDYCM0oW+BDMusan2D7NngGASyYfV++k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXBIeWdzWWtGaE1MdTlOaUVSMTQzR2E5UVM3MlJQT1hFdk9vdnFlRDJIVHhL?=
 =?utf-8?B?K3RSWVVIRERCejZydjNLaDBiRklpN2xEOWRuVzlyM1daYnBrWmFVcjRXOTBT?=
 =?utf-8?B?bmpvaGtRK3RyZE41RkVNaE9Yc0IwSFQ3MWlXWDFJdWE0elQzeEZJNXNvSEp2?=
 =?utf-8?B?dDkxcitpSU5EaVc2VHdxM3ozSGZNTWFGSzhEOVpaenR5UkRMOTV1Sll2dWV6?=
 =?utf-8?B?U01mOEZWSldKYUU5aGl4ZWR6V3F1M1FmZUE3RHUrVkVKVXNiMGZ3b2x1Ykcz?=
 =?utf-8?B?elZWZTd1SWtsNUEwSi9mZVZoZDZDaGk1Y2pJMmEydWpETWcwWXJ4RGFOOWI3?=
 =?utf-8?B?RC9FVDUremF6UEFvc3doVGdHMkNhOFlnZFQwaEcxR1cvMWdtZFFHeHBadVIx?=
 =?utf-8?B?dk40dTVadzRCKzhGai8vcmFVS0xmaFVFRWlnUVlxck5QTnZ2UWo5OXNwK2dH?=
 =?utf-8?B?RlB2OXd0WmpUOG5JWUlia3djTE5jbWh6cGZQczVmM3NXMmgxSzdyak1IU3VY?=
 =?utf-8?B?QU9UUlVKc3o2WTdBTUE2SUJHaVdYbVFMRHdEK1VRa3hCdVV0TDVrQXNEYk9i?=
 =?utf-8?B?eVVTSjYzWE9xUEI4UHQ2VkxRckZKbjJ0aU1rTVlWRTZVbnc2UkU0NEhSZDA0?=
 =?utf-8?B?ZFhCaERacFF0dmt2NXdLeVVtOHhoK0RuaWFPM2kySnhIdFMxVFFqWk1XWlBE?=
 =?utf-8?B?WHFUalgvU1MxU3NQNldlbzRNdjlseU03K2FNY0xtL0tqbTlKKzVLUmtBVTVF?=
 =?utf-8?B?dFY1YlY3RWErcmMrVGUvdnFkZkZpSzFOc2tQRVg0bVhtem5jUUJHNGJjdlha?=
 =?utf-8?B?UWhOQ0hydzZaL2pqRTlNajJReEhUQjl2NFRtKzlWMGxIWHc1REx1Z3BKK2NF?=
 =?utf-8?B?NlA1akFLMUJFcjhDOTJzUXpLQnE0bkhGeUVTQk5aaHg2YW43cndYUXhWcTRp?=
 =?utf-8?B?dDNKc0pIWm9hdTRPWHFBdlhUSGhoNW9vUmNHdG9UVUFBODNodFlQTFl0SWF6?=
 =?utf-8?B?cWlZbGVMU2VNMkh6WnpkY2FUbmk0SDhsaXJQQlppRVhYTnVOYlJhOWtBRERY?=
 =?utf-8?B?RUJLR1RTMTRqTEJrcUI2SWpqKzg5SGl1ckl6TVBBRVluQ3hwUmwzWmZWeFRs?=
 =?utf-8?B?emowaDk2L2UxTHZmRFM1RUxyT0YrcUM3ZE05bG9NelhTajAvdVo0T1lDckhx?=
 =?utf-8?B?YnVSYkVKUG9ZSDVmTFNUYVhIcHFHYlNCWEt0UzR2YVB3a2tGczVFS3hEeXVQ?=
 =?utf-8?B?V1ZrcEZGaWRWeUVmZFFYVVlzZ2lyb0srVGtYcFNxbTNSQ2JDZHkzRkorVG9q?=
 =?utf-8?B?NkRVSFJIUUV5anl5VSs3MEpibDFPWGU0L3pPQU1WWlZ4YUZyaFJFRWs3cm96?=
 =?utf-8?B?S2ZWZ1JlNHhJTXBYMnFrb2prNjM4enBwd0JYUWxlUVoxVDlwMEw1ZUFaeThr?=
 =?utf-8?B?cjRTTjZvYnZzZUI3T20rL3VKa0JIU0swZE5KL2xBcHc2VlJOa21wY3BmL3hC?=
 =?utf-8?B?MGpTeG9XQ0ZLS3kycXhtbkJjb25BUEI2L2t5WStKSWtXdUpUNmdyVy9zbFlZ?=
 =?utf-8?B?WGc1VVEwQ1IxZTRFRkxpSUpNWUx5UDNEMFRZZjlMUWhDc2Z2QTlpTkZUTmJN?=
 =?utf-8?B?d0ZLNUp2b2plcVdlMElyOGhCSXZqdUxDUEp0MmVvakVKdVZHNDNhbFFZb0tK?=
 =?utf-8?B?SzRTTUR2RVBHbWhZV3FFUG1heWtxTC9JUWlIdjcwZERob1NCRldzSVZJTUpz?=
 =?utf-8?B?M3QxbEJaRGgxaUtsOXltNWhyODBwanQ4ZkhzS0c1cmxNYTN6M1pKelFEY1VZ?=
 =?utf-8?B?RzJJbWNIREFKdFpRWWpNcVVON0lSdDFvL0M5NTFNa2pYUWZUc2xZdFZpT21Y?=
 =?utf-8?B?ME5aOHBqQitKWXVHcy81RzNSQkJuM0NIYVAwS2ZMRkhSaUJEVktreHlONVFl?=
 =?utf-8?B?KzNNcEhkeld5YVJuc0JTWTBNcmd3VTJFc0hRekVKVkN6M2hBZHF0VnJFSitF?=
 =?utf-8?B?ZG9LeGZzdFU4YnVnLy9lbWJqb2RzQXZsQzBYdm1UWU13L2RyMjY5S0pKbGhk?=
 =?utf-8?B?ZUtSMW1kRlpkQVBlMUYvamRBc2VBZkczTVZKdWxjYjNab3Y0bU9rcWVvOXFS?=
 =?utf-8?B?eDhhbVVCTE5WdzlIZWJHN1oxaDVkNmwvc3JIYUVRNkViR2kwOHZhcWw1WVht?=
 =?utf-8?B?QVJ1bnRxODJVM2loS29rcCs0SmEvd01ObDJ5RktEUG1jY3BaOGtaTjlXMVVh?=
 =?utf-8?B?Rm81SCtBQWtnd1BDMU1FMVJYNXNVWVFZdXI0akNkMVR0SlRKNHFCdE5Mb21O?=
 =?utf-8?B?V2cwUEtQVjZtLzJiVTdneWdxVGR4QmxpUVlsd0FCRWxMOThUKzkrZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7d1254-1015-4b06-84f3-08dee6a7cbc2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 21:42:28.7064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwg3iuEBbrb+mK2Tmd/v6bTGQqeL7e5nJEw5rhbp3SRgGvYaiqQCQIShKwPe12dMW63LYPCRAGVuN0ALVrmoEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9747

On Mon, 20 Jul 2026 14:27:12 -0700
Josh Hilke <jrhilke@google.com> wrote:

> On Tue, Jul 14, 2026 at 2:12=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] Test flakiness due to fixed heuristic delay instead of polli=
ng on EAGAIN during VFIO_DEVICE_RESET
> > --
> >
> > --- Patch [5]: [PATCH v5 5/5] vfio: selftests: igb: Recover after DMA-r=
ead faults ---
> > commit a631c99ce1be37dbbdda0314b730b2c6bd947b50
> > Author: Alex Williamson <alex.williamson@nvidia.com>
> >
> > vfio: selftests: igb: Recover after DMA-read faults
> >
> > This commit adds recovery logic to the igb selftest when an intentional=
 DMA
> > read fault causes the device to hang. It introduces a reset and re-init
> > sequence using VFIO_DEVICE_RESET, including a 10ms delay to allow kerne=
l
> > error handlers to release the device lock.
> > =20
> > > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/too=
ls/testing/selftests/vfio/lib/drivers/igb/igb.c
> > > --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c =20
> >
> > [ ... ]
> > =20
> > > @@ -500,7 +522,28 @@ static int igb_memcpy_wait(struct vfio_pci_devic=
e *device)
> > >
> > >       igb_irq_enable(igb);
> > >
> > > -     return (status & 1) ? 0 : -ETIMEDOUT;
> > > +     if (status & 1)
> > > +             return 0;
> > > +
> > > +     /*
> > > +      * The descriptor never completed.  On real 82576 hardware this
> > > +      * typically follows a DMA-read fault from one of the intention=
al
> > > +      * unmapped-IOVA tests; the fault leaves the descriptor engine
> > > +      * unable to service subsequent valid descriptors.  CTRL.RST al=
one
> > > +      * reinitializes the queue registers but leaves the engine wedg=
ed
> > > +      * for the current process, so a broader VFIO_DEVICE_RESET (FLR=
)
> > > +      * is required.
> > > +      *
> > > +      * Delay before requesting reset so PCIe/IOMMU/AER error handli=
ng
> > > +      * triggered by the just-observed DMA fault can release the dev=
ice
> > > +      * lock VFIO_DEVICE_RESET contends for.  The 10 ms value is
> > > +      * heuristic.  The current memcpy still fails with -ETIMEDOUT;
> > > +      * recovery only ensures the next memcpy starts from a usable s=
tate.
> > > +      */
> > > +     usleep(10000);
> > > +     igb_error_reset_and_reinit(device); =20
> >
> > [Severity: Medium]
> > Will this fixed heuristic delay cause test flakiness under heavy load?
> >
> > If the kernel's PCIe/IOMMU/AER error handling takes longer than 10ms to
> > complete (for example, when KASAN or other heavy debugging options are
> > enabled), the device lock might still be held.
> >
> > Looking at the kernel side in drivers/vfio/pci/vfio_pci_core.c:
> > vfio_pci_ioctl_reset(), lock contention causes pci_try_reset_function()=
 to
> > return -EAGAIN:
> >
> >         ret =3D pci_try_reset_function(vdev->pdev);
> >         if (__vfio_pci_memory_enabled(vdev))
> >                 vfio_pci_dma_buf_move(vdev, false);
> >         up_write(&vdev->memory_lock);
> >
> >         return ret;
> >
> > Since igb_error_reset_and_reinit() calls vfio_pci_device_reset(), which
> > asserts that the ioctl returns 0, would this lock contention cause an
> > immediate test suite failure?
> >
> > Should this code explicitly poll for -EAGAIN from the ioctl instead of
> > relying entirely on a fixed sleep?
> > =20
> > > +     return -ETIMEDOUT; =20
>=20
> Alex, I'm guessing 10ms is what worked for you when testing with the
> physical hardware? If it's working fine, I don't think it needs to be
> changed.

Yes, the delay was found empirically and indeed we could make this more
robust if we retried on -EAGAIN.  I'd be in favor of doing that as a
follow-up.  Thanks,

Alex
