Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205F337B97
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086292; cv=fail; b=kBrFryUFJ/BqzZaZ3Xu89ux8QFyC+KkxayJENejevLxdI5nZmPBH6cNfmRhUVQi6l3o/em2FCj7nsEmEH/0y2dycOrZIRBJ/H9IHovhSNA273iqijuDOInirkhCMRJ6NncHXWD0f2NXPxm4XafRQfQPN0NbPXJKBw8N4K+5pFrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086292; c=relaxed/simple;
	bh=HHkRelxwGynDo/vkmuNz3AGNmIN0XI0hcwOAyxoq/cM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KbXk8TIXGgLv5VDQy7sxug4O3RyjjdPlcrEhNg6AjdLPWO0KOB1SIbs6KYwoy+Lu13bTQXS5v+J6aEh964snHW/OM7IeIjug5p4YnpOKLWTcBFXDYAbejmjk8jwxvciMHw3Zk26BYjwARM4XpfReh5YfcyPgvM+wnYAyUNi/VwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ShPnN4Sh; arc=fail smtp.client-ip=52.101.46.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ShPnN4Sh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmmH//G6Xb7ulVKSwZGdIWJVgpUdBC8bWyVaGf5Z75RlrXZblROGEW3agFKhUnun8ifm6iaS24ma0FxTOTjxUdhnsyK+FEpojYrLLCqsqnGOIxh1eE0kuLWpbAj6nJ/NgmYJ5Ca5N9Tuugcz9Porkanz01FcHD6sxmqxLyCiO+AoeZms8BzRYP1Eq+E7vwU01PMHItr6o5o1zIA9zu8c0yd4ZLhStOV3NvYz0yNy6h4an3bRCsJ5eBsCvUeZy8mP+GXoGLeDyC6OuVdk8D6HBuXf482s3dpL9XIxRzXo/NhwP0csFk3UADLRnEy9+bLzL/ACpg8golwboF6bJfTQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTMUnmp5SKRWcf36HMxpU926Y2kHQImPNQoz+BPdizc=;
 b=XoC/JFlsMsXNrL/Je54SN/HLTG3NO/tRAkNheIiM1YDwGi9+k4j7K4cu+UEZvqjqFsOc+cW7TKR9AvvYkd2XLKyk6TxV5pUlOePywECBHYTQnlqlj7AMahbO0kUOL5xdo6/a8Gk8WilIwQoJ9m+a8NloWHoLBJMZlXC37WqfrlF3PhMbgyDEpQD6/26b8QaKg/FafoDywatbuC3RXsYVQ+MIKZItWoNUOHHK9Jj94bB8DJtOtWH4b8QD1i6Ylys8PwDkLoGWzaJnSjgdHZkDr3nGVujeJGhHPysDXinsGH89pkxSHOANTs9I3o2qyoavBqic9MmKPBasvWP+Og5nGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTMUnmp5SKRWcf36HMxpU926Y2kHQImPNQoz+BPdizc=;
 b=ShPnN4Sh5c3tZT4C01U1kZHV8LU6h5BVDE9BrfR5cnIdtUNRBc8vWg7UBs/VGw5iSN+bB1w2oQPca9ux2VIXuPLB1Az5SaBKxlHaEolqbdlT3ghLi54AoaIs1ndJ8Og370wHs7WKhxJB9p6G2ypG9MC/VwpfEmOpCysfKp/rHh9JrNcOtllxpn4brLDNLZuXCtBjSvIi6uughig9qlLvdPZIOtO7ANYdwmy5RzvKF8zzJamQ/4eiP5yvHf2Ve5TqrzWVw86jLrCt9wzrsS98zU8flhQ8zmpUAy5TdGpu9jAlm9At99tXIjn49r1St3CvE6++J2w3tUHNoQHRVKneRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:da::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Fri, 29 May 2026 20:24:42 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 20:24:42 +0000
Date: Fri, 29 May 2026 14:24:39 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Josh Hilke" <jrhilke@google.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH v2 03/10] selftests/vfio: igb: Use advanced TX and RX
 descriptors
Message-ID: <20260529142439.5bd03e5f@nvidia.com>
In-Reply-To: <20260527001444.69A771F000E9@smtp.kernel.org>
References: <20260526235417.2058313-4-jrhilke@google.com>
	<20260527001444.69A771F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CY5PR15CA0177.namprd15.prod.outlook.com
 (2603:10b6:930:81::23) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ef42fc-74f6-479b-b3d3-08debdc0508d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	g7KdXbUO1G2jWu8cLA4ydw0aZxvFzbtpVOVHcPLOEZ4nM3aBPd+RXXHmnqa8ZRdWi7fZb0HDyjgldS7g6dKeLxrxbCAKrRGLRQ0JWdKA/H9MtwXkgmzrG4gdcvrHwYj4H5HbfpGFj8EVOqcY6RapT03exEXT7xb/Vx37EqeksNcQuv3uVI9cOWPYRynWzmxWKB7a6lu42XKPPa5b24uAmtqd2+HI0kMTGSFToeXy3uaEMnTcPggerV9C3V7UWXogJPLQOe6T9CAPBKlCYo9SYnIPVivsM94VUziadCkzku/HR4xfns50MS51mTXEc2bHHYw0Uu4H2Mez8i7icOor1wFasBuNTZidt81tYi90VU8Gqc9GUigk533qWd5ccsHLT7PoGbjPUFCPVEM0L/xLc56LuF0WH1InP2dTmzbX+Yb2HEXEjmzmmkcYHzyzhTzFKQARmmkmogmK0j2/X1xMiwWZK9fyJ6y0UtU4loNUKS85pYqwpZ+OuUeBU82nvkmc1WK9vxz3peWIVqulPyrHbDV6dfYI2B/BpZ56taxoVseTYA3rT4sK6aCYZ2n6h3p6WqKeyOw4MJk9IQ9WYPIFFQ4/lBCepelejHAfFjvbC9a4pwSvtSER5fo98wd/SJ/EpZpAeS4x97bCshpKUa3CADL4PBywtN56eaNNNi8qrCoXKjA3vcpUPn1NdK0RaBwP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mYg5MAqbtqAUtQMWKz4QnA6RcbCxG9K4PZojIP9+o8SDqug0xC8xR1iOVLRe?=
 =?us-ascii?Q?LSpTujcOJ1IHuHd9QWrscAtseLVpTMro77pwKeyYq0j09/vUCfyL1yIqR422?=
 =?us-ascii?Q?/HSdAn1EIeeUpmPW41wEc/4NRtx/J0kJbCGVjqvWdvvnryhkOFaNoiViks/1?=
 =?us-ascii?Q?kQ5F3zWQRPBeWhHXzdy4FuVErGS6aoroqpJm5Dx18LYOTRuto3om2WE4m1vR?=
 =?us-ascii?Q?3AL59b5bLSlS74ws6dQixbhtXokdm0LQ1u5LMSsd9QZGSaVpRC3tNvzRgy4R?=
 =?us-ascii?Q?R1vu3AAvPNOkpepDKrd0sEgfYVdVmol2zlLvxF7l4FwOe8zs/bOqxtRDNHOW?=
 =?us-ascii?Q?EFt1wZCR3/my7guqWy/Ft0Jc+7vgwvNlLQD0O9874dgN7yavG3R0LAXgZl6k?=
 =?us-ascii?Q?2bV7Q7hz4dbuqPzuBQ0PB9BYp1JkIan7XIxvSfNP7Pa+X43X45XGZv0dWTcB?=
 =?us-ascii?Q?fRPMXBT5SbZE5Ow2PohxQYZ2PcsulEvuj2efu7zt8XpopS9ynEzVjsaobkWn?=
 =?us-ascii?Q?wqTdLu34yctQ7DQtQuiFOpePLYIQXIzm8FbfGQ/oiGk1KKbxXiOEGe/cJnmT?=
 =?us-ascii?Q?4pseVad+oPgsSZifnnmvwGLe8Wx74jLqqgC+F+ANKu3OjUktro0bPZzE5vZ7?=
 =?us-ascii?Q?EvpDCLUaJF4CWw3xgPFulmUt/2bRJDjCYKiz1lPTZv1LshZ4ajpKpShK+ZL/?=
 =?us-ascii?Q?ZHFA6sbfYXgAEXc++m+5T2Z+P2AiJ4OJ7CgPmI9f3edZl5tswbHaZ5tY1yHJ?=
 =?us-ascii?Q?rMFKpF1mx1VzGEcfYJuoS2E+2PyHbafHCHNb7Ww8fKUO03bMK21qJZWq5bcy?=
 =?us-ascii?Q?zmdEbzPs5c4iZZDKjw3fq7vBgddwrkBptuM2SE6vq+j07/SmWapB5zD2Zn+J?=
 =?us-ascii?Q?PrVrNrhKcSPId/IgP5etWvEp4kNHCO2OuyIr5wheMKb2Oj7jRoDPITkJB+UX?=
 =?us-ascii?Q?weexs1QwRZhEcKbmgqXK2SPKVLWdnnv8Rb5jjoqAz+zMjNn9RSJdgA8BbH//?=
 =?us-ascii?Q?K/nay2GDVqKkOCUmk/rwFjdWS6vLGYErwmH02/CL4aeealTSMp2srWfUTPDX?=
 =?us-ascii?Q?wUoXdUhCTOjJKy4WVtxUIng8P/I24R3HmG6G8OlR73E5bN0AEBNZkNhCZYCQ?=
 =?us-ascii?Q?hEshVhe1fUDvzXzyg94MSKWbrAytfC6I0GO5dSX+is9lVm/N1J1YrlRk8pk3?=
 =?us-ascii?Q?ef0tDWEOae27VapWZpCKmwmmE8BEWsKS9CZn6wvU0JHfiZY2lhkR8lG/YpRC?=
 =?us-ascii?Q?9tQYB99nWUXdTW8m9aiRw6Xkz0PTXO30LG0Eyfe8xNgo6y9PwL5b0ruA61og?=
 =?us-ascii?Q?vty8uoVOgSvhL9rNeM1u4gawkJ+jCtNMgV/7w629xEMIBem4NHZB0NWBw9bo?=
 =?us-ascii?Q?rL1wZv2862oqWELxgK1vMosCELKvnymIltphnDbSBVGw32Bu9XS0JtR/lJ4g?=
 =?us-ascii?Q?pNlGwtljX7C8OgV/HIuxDjzYeSXpONy9vBL1LCMNBc2mHSh1rOkxnxALnqwg?=
 =?us-ascii?Q?VSrPHr22CAvlxz8eFLETmeR4eK0RqIM5eHTOxxgdFqnqNOXbHGhZdh+Uv8x1?=
 =?us-ascii?Q?yDeqKBvVSamxDjV9f8mxkBU1XqZaSCRHVrlCN0FRsAUeydC5VxtGkY+RbWmF?=
 =?us-ascii?Q?GQrPG50zC+exkZQ0Tbz+qcYlRwide/ioQmTQvZxTDVYNTsnrgFX6VbNjzl2z?=
 =?us-ascii?Q?D6kBMbbTyKxZpj3I19gGYt0jEvyIwHycKtPbHBjB23oIHQiFMEREJxdaxrlV?=
 =?us-ascii?Q?taApSUxZZQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ef42fc-74f6-479b-b3d3-08debdc0508d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 20:24:41.7996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZ5c74gt/dPdPdrVh98widjYugs3Mp5Ewsd2jg5U0Be0uCHeZ2TfXl/oKtpltVdHNkMAsIE2mbjb4zPe+qtlDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323

On Wed, 27 May 2026 00:14:44 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Overwriting IGB_SRRCTL0 clears the BSIZEPACKET field, setting =
the receive buffer size to 0 bytes and violating the hardware specification=
.
> --
>=20
> commit dc2cc67e8a6e2c641907cee5129b78515c56abca
> Author: Alex Williamson <alex.williamson@nvidia.com>
>=20
> selftests/vfio: igb: Use advanced TX and RX descriptors
>=20
> This commit updates the igb selftests driver to use advanced descriptors =
for
> transmit and receive. It configures SRRCTL.DESCTYPE to the advanced
> one-buffer layout for receive and sets up advanced data descriptor fields
> in igb_memcpy_start() for transmit. Legacy CMD macros are removed.
>=20
> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools=
/testing/selftests/vfio/lib/drivers/igb/igb.c
> > index 5bbc6fca75189..c0f9cefb23e59 100644
> > --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > @@ -226,6 +226,17 @@ static void igb_init(struct vfio_pci_device *devic=
e)
> >  	igb_write32(igb, IGB_RDLEN0, RING_SIZE * sizeof(struct igb_rx_desc));
> >  	igb_write32(igb, IGB_RDH0, 0);
> >  	igb_write32(igb, IGB_RDT0, 0);
> > +
> > +	/*
> > +	 * Select the advanced one-buffer descriptor format.  Per 82576
> > +	 * datasheet section 7.1.5.2: "SRRCTL[n].DESCTYPE must be set to a
> > +	 * value other than 000b for the 82576 to write back the special
> > +	 * descriptors."  struct igb_rx_desc matches the advanced one-buffer
> > +	 * writeback layout (section 7.1.5.2), so polling rx.wb.status_error
> > +	 * requires this format.  Section 8.10.2 specifies DESCTYPE[27:25].
> > +	 */
> > +	igb_write32(igb, IGB_SRRCTL0, IGB_SRRCTL_DESCTYPE_ADV_ONEBUF); =20
>=20
> [Severity: Medium]
> Does writing directly to IGB_SRRCTL0 unintentionally clear the BSIZEPACKE=
T
> field?
>=20
> Because this is a direct write rather than a read-modify-write, all other=
 bits
> in the register are cleared to 0, including BSIZEPACKET (bits 6:0).
>=20
> The Intel 82576 datasheet dictates that BSIZEPACKET sets the receive buff=
er
> size in 1 KB increments and explicitly forbids setting it to 0. A 0 value
> leaves the hardware with no space configured for DMA, causing it to drop
> incoming packets.
>=20
> This behavior remains present in subsequent patches in the series, where
> the macro is updated to E1000_SRRCTL(0) but the BSIZEPACKET field remains
> unpopulated.
>=20

From the spec...

7.1.3.1 Host Buffers

  ...

  The size of the buffer can be set using either the generic RCTL.BSIZE
  field, or the per queue SRRCTL[n].BSIZEPACKET field.

  The receive buffer size is selected by bit settings in the Receive
  Control (RCTL.BSIZE). The register supports buffer sizes of 256, 512,
  1024, and 2048 bytes. See section 12.7.1 for details.

  If SRRCTL[n].BSIZEPACKET is set to zero for any queue, the buffer
  size defined by RCTL.BSIZE is used. Otherwise, the buffer size
  defined by SRRCTL[n].BSIZEPACKET is used.

8.10.1 Receive Control Register - RCTL (0x00100; R/W)

  Field   Bit(s)  Initial Value  Description ->

  BSIZE   17:16       00b

  Receive Buffer Size.
  BSIZE controls the size of the receive buffers and permits
  software to trade-off descriptor performance versus required
  storage space. Buffers that are 2048 bytes require only one
  descriptor per receive packet maximizing descriptor
  efficiency.

  00b =3D 2048 Bytes.
  01b =3D 1024 Bytes.
  10b =3D 512 Bytes.
  11b =3D 256 Bytes.

False positive.  Thanks,

Alex
