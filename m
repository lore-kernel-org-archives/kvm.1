Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.199.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6754138A706;
	Tue, 25 Aug 2026 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.199.210.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787697225; cv=fail; b=RelAv97+Z7V3wuvqWUibVBCksIA2lo4ZjSlNlPsdPSdvgGIhMRYdqMpT5AXdx50ELF6MF4nSGQA2xDa/6Sn7a2IgvxM3eFO8T07K2Wejz1kgF1ns0aCOaMwbHmXPaABweJwMSg/48u1hJtmotpPcpsq+W0uAAH7HOZZ0/Ct2dTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787697225; c=relaxed/simple;
	bh=QbpvNW1FkzSHTqLvGoZxIsG11vIiY/rYAYaQ/TqprmU=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TqQIun1DOUnS7+gcklLp6gawBrJgc+p4eGyQ1g5aa4zMsl8A7T3gtnNQW1upXW9sPSfnhb0mOBjFp7oNrZquqiZzzSB48O3mImWI5M5+HiCavs7Dpy7+mGKaM4umOLorRE6DV7oTogAbmCh4c1oeNPnNTqZGQPho4t4DakG5Bk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=FznxwR27; arc=fail smtp.client-ip=18.199.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="FznxwR27"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787697223; x=1819233223;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=8PoaT+grkj546uQI+qEcM374XEQf0KWQS4fwu+/h70U=;
  b=FznxwR27VSI6CgQGq7Hc3XMOSVpl8Mjara0lMBv03IID9LkPgVzTbBuO
   jZNK+L7fSOoXVtxQ9RR7umWXFpwPpI/4BQAXCW/+stqznCq4mV8Vepsgs
   jXy9lBZTKARnfkzlkN7s74u25UeuKbx2NaFiNetmt9B921iK5Z9YKnaVx
   Yfhk7RV2xHjasD0ErPD6AWzJZdDrVZumNGLr+hzoeAmgPvgnz38DYaXW6
   /dXtOSS6XLEbCpoFEXDZAFCU5w6QHk3O4pPv10q5wgjwseNUWRkGFL9Gz
   DXewGz0Ox6rIqrkKmHtsrDZMiw5nOXXROwb21qb9atmfdJX1YU3PCfpi5
   g==;
X-CSE-ConnectionGUID: /45HjlsyS5CinuNbkgCx+A==
X-CSE-MsgGUID: E6pZFRGeQKagoLcjE4bK2g==
X-IronPort-AV: E=Sophos;i="6.25,243,1779148800"; 
   d="scan'208";a="18335287"
Subject: Re: [RFC] KVM: x86/mmu: Prefetch forward run of pages on TDP page faults
Thread-Topic: [RFC] KVM: x86/mmu: Prefetch forward run of pages on TDP page faults
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 22:33:39 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:30129]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.12.225:2525] with esmtp (Farcaster)
 id 6836ff8e-e1e7-44ee-851c-fbf9952bb3aa; Tue, 25 Aug 2026 22:33:39 +0000 (UTC)
X-Farcaster-Flow-ID: 6836ff8e-e1e7-44ee-851c-fbf9952bb3aa
Received: from EX19EXOEUC002.ant.amazon.com (10.252.51.145) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 25 Aug 2026 22:33:39 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (10.252.50.44) by
 EX19EXOEUC002.ant.amazon.com (10.252.51.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45
 via Frontend Transport; Tue, 25 Aug 2026 22:33:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKCCq+/SE5uUCgZH7krFcHtSBu0Y+OBUh6hsZepfqnp56uOtxDbRftW+MfC0uwWShXa0rTQruns+XUhUYNIwI3eIjFnpz1ptIIs5PCukILhdvVfuRYDoZu5r9ORfx8PWZxQgKZjLeREIGM1vlgtAey036fT0nO0MenlAYd35zeJ+ZBaVh3j+ua1OC+hZYjrgp/zdXK9li7Y2GCvvmiP18z1bkO/bIbxQuBxA+PkzgYiQgGci/005D6VyMnNnoQ2fvnqOwzNO4x+ASk0rttRFjZXJ4ZQHdyPCM3vNJVSk21cp0nlQFXXht0FCNDQTMPEqDMeAro4Ffx7LuRk79XrHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PoaT+grkj546uQI+qEcM374XEQf0KWQS4fwu+/h70U=;
 b=YA0cyH4W3t7TkMNVHepxaCpyGeiNKjDYzZ4f7/Es6L0HzCd8/tFE+JSNxpahDnfHqYV4lLBEQpwnFFyxAyWng16l3xzQX3z9sm3xShHgmSGs1iuCIQzRnU5eRWaVN9cblronYup0a6GrLs1ezC/W4o/h6mRc5Q6jbMbEm2zYcQxi/caxIqE3vAszipxCv8xjsCSerLq6DH+CVg9uCQXi4ojw9Kk2cYovqj1iEUk9fty483hjTL65UIOBrpfmcqwUmEXsvahT7+W4gd7FAmPpppFECa5BgW7P+iQAaEeO4x50tv8pOB277rqEOIySErd6YMNwsY7+FTII927QNRbroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from GV2PR06MB10711.eurprd06.prod.outlook.com
 (2603:10a6:150:2fa::20) by DB9PR06MB8044.eurprd06.prod.outlook.com
 (2603:10a6:10:269::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 22:33:35 +0000
Received: from GV2PR06MB10711.eurprd06.prod.outlook.com
 ([fe80::ef79:3e5a:90ef:ae71]) by GV2PR06MB10711.eurprd06.prod.outlook.com
 ([fe80::ef79:3e5a:90ef:ae71%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 22:33:35 +0000
From: "Marangoni, Marco" <mamarang@amazon.com>
To: Sean Christopherson <seanjc@google.com>, James Houghton
	<jthoughton@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-patches@amazon.com" <kernel-patches@amazon.com>, "Mancini, Riccardo"
	<mancio@amazon.co.uk>, "Zoumboulakis, Michael" <zoumboul@amazon.com>, "Marco
 Marangoni" <marco.marangoni@proton.me>
Thread-Index: AQHdNJqdXqr/eEZTQESKiH5g17VLlbau7DOAgAAQ69eAABKCAIAAMQqAgAAA0wCAAAnwAIAADXAW
Date: Tue, 25 Aug 2026 22:33:35 +0000
Message-ID: <GV2PR06MB10711473E66D334489572ABD8B9AF2@GV2PR06MB10711.eurprd06.prod.outlook.com>
References: <20260825140159.70997-1-mamarang@amazon.com>
 <CADrL8HUcr5Fei1PX179bkFmMJ_S+eD267SVgc85cm-rpcahwmA@mail.gmail.com>
 <GV2PR06MB10711C9FE46F33B0613DCB66FB9AF2@GV2PR06MB10711.eurprd06.prod.outlook.com>
 <CADrL8HW8br9KuYoELj4id84ib_tGZrBh3zZGbjerHuM8uiN7hA@mail.gmail.com>
 <ao4CufEI_pRCjbMF@google.com> <ao4Daj0hnwjP9Lpf@google.com>
 <ao4LwI2F7jDezZh9@google.com>
In-Reply-To: <ao4LwI2F7jDezZh9@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR06MB10711:EE_|DB9PR06MB8044:EE_
x-ms-office365-filtering-correlation-id: 4fecba9c-c54a-4a60-5a81-08df02f8e67f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|38070700021|10067099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: dpfDqFEHmk8ZKBBfJJS10QR9WsoHE1UWc67eDm02+TAhigwpo2lufhthRxYjbpiUj8yFX085PJEgH77CTEB7Yk5LC+EzGHqVviU4ijeZqb3/0i5tsb1lkLdNblo51X5dVrqCgZOh2HmezAybymR7o6M/7K/47tSrNzB6rAKmu93jrGE+QTv1E8lzjZ2PGDJB/MhCnhSxVH4AEt/IV6P+Gu5SKJkljzqHSZSZpnPiZ5gfCLAkOu/7qp0zOE/U6KXQ/YwZb4510bpctbaD8yC1D48kyGlFk99XVGY4aJzlAnrimuToBde0UeY9z5Y2JAmTWCkxkeDeCZz2Sh9HnMbXV+/xa6Kl9yFfSabXAcTrme2bq5NCb9p5+x5TeQJL02bzB0f1mMyQk2hSzDmq1yg1Dtd+iknM+CCLFfqOLyGveMie8bOr0tYKNOqcF9rZScxB/oleYvd+H6tbJ3wemXvliRnl50Ogf35hWl5RJWp0eu605sK2hwLC4lfwtWcOyCo+ghVRVKzE9wX0BtNJiRLa02zOqPu70fJXqUtWpF2JuWWDDmuR1iwn6SLrOsscA2Tr2v0KIpiq9rafpkfV+l0+3KhJbEk6jfUY/Wq/qXu65m8jIRC5FznXaDa9pUzCCYdSs9rNc1KH7LOJEEZp5SHmbh4e3w2eg7Fy4OMI0BXOkoNVhaiKafq2CzqFaDQ3k1muYMGckTm9gUtZmXTWQNM5h88ZdTdmXKpll/414eg4OBc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR06MB10711.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WDhtOyxjlX2oSlN9tYUMSWvyTghOFfUISWeO9ioHz2W8wV7FIL87zq/fv5?=
 =?iso-8859-1?Q?9JCY1liS4CF7WsyrsNG4hYhhBxAh6m6yLGF3wPSdcu7ObFFrQDFdYidFKu?=
 =?iso-8859-1?Q?IVIJC79xT6UXvFhdU0qgIsOB2c4pYvL+cW4DM6+azG1YHvcIhyqzDRFpnO?=
 =?iso-8859-1?Q?7NwpKtxITYoVySrPO6StPkgEGpXmYYWNwcx+Bbw0Mv6n86TYnc2F/Dnp8w?=
 =?iso-8859-1?Q?WrByz7iHrbdhK8jYPOWOOpFtIHR7xIcr9H0Xhit0bCGFb85hKhllBiq77T?=
 =?iso-8859-1?Q?mlReNi6FLy5x2Dd1zHPm/tL4yNcgBNVr8inNPxPkfupndpfjFpfxG6W2+R?=
 =?iso-8859-1?Q?Id7C1xZSwFyGAAC/gFoAqvz9xFNIG+pn8FGtEDX1qf4KDCtoT0ecKoo5HT?=
 =?iso-8859-1?Q?mDv/EQqzQVMZVoX21SJzaI6OLRvTfa9WepGw0gvuO8VKaj24bLNirB6NQi?=
 =?iso-8859-1?Q?GN8G6mYTnjvFGOH0352ClN9eWAEexDL6IdkdFgN2v+6WkjbbgJVebYH8YE?=
 =?iso-8859-1?Q?zhgsEzv54JCFxuxk2n/rDXxfrtijI5NIcdfaN1U52PPxHleKdjfStiVenM?=
 =?iso-8859-1?Q?e8wDtTgD8qIs3N4TtumgYbrcvWKWzKUBqnGIzaW36FbzcTkva+0luRHg3s?=
 =?iso-8859-1?Q?Ihjz1IBwY5aTItFNxpNIMPZUv387CwgqAiKrHcy1EoZOQzJGhwedc0CNeR?=
 =?iso-8859-1?Q?ChK4k5GcNiqSwa/JmYLrUfMW7vVYte0xA6XNc8zr0stxdpao2JTe0BrjYc?=
 =?iso-8859-1?Q?JwUHIsb7gz5eeywNAe+OmRsgbY5dWPVPggQ/VBapoCP2ihE8YYeTH0Gbjg?=
 =?iso-8859-1?Q?k2n09epFeaMaGRsD5yS8JLs0SBwL6DgJCS4Ljs8d1zc1ozbnqm5qID9djy?=
 =?iso-8859-1?Q?TmkQXHkWsh0JeSkyetpt0ffWn7afniA5L0xEdjrU7eVLgHpNZ12ET7MHGP?=
 =?iso-8859-1?Q?NeRPCzRhQ9BsuwUZtEu02GshywB4rsWVWZ3ttZ3MlLAL3bg8DNzpLcn2kQ?=
 =?iso-8859-1?Q?cBxtRyGM+ZI8y7kC3R5lrsdpI9qvtm1fWuVcCFQ2L6/Uaiko763XF5pMoM?=
 =?iso-8859-1?Q?X0fgQ7/4KpK0HzLFhh3ktmCp635m3yGcJ/27kW2D3k3PWxp6RwiQEEastC?=
 =?iso-8859-1?Q?DgE9o3/95a06489eJLyBwN4MqRuFMYbsUPVApKlVlclbr7buhT2yEnxnHA?=
 =?iso-8859-1?Q?Txe1VRMNm3jqsa4B+Z97YdNIgOKZYRJBJSBCUm7sSCrSSWJLENl598698Q?=
 =?iso-8859-1?Q?QWImDTwS8nJb0baZps+9a/7BlSaKEMGgw+8+qqVrkf3qiAFAZlVwxAolig?=
 =?iso-8859-1?Q?5VGO7uSfYOJPq8Q0Ht6srrqJp1XAV2MFcLs8TUic7cuhLXwaT0UEiMJYMI?=
 =?iso-8859-1?Q?OsPqzFG1KJsMsix4TmuruZ8h0GiS084lB03vxqgPfOFXOgXOV4wd0uA4Tf?=
 =?iso-8859-1?Q?7CII53VkVChf7ViSeXMEBSieCcY3lKJHW0NXvapvGfOIiQ5xQHDTW5qwHg?=
 =?iso-8859-1?Q?E2bFA09SZzpcCNT75Qprw4zlPh+7gGOAhf4HzDkTjQabeVD7e2+YBEU3y5?=
 =?iso-8859-1?Q?YLugCy60Wr9I3jpqZfByOv/eWJApZDF5wmv0DWfWoEtCb6OSz4OfFuFWNT?=
 =?iso-8859-1?Q?eu0yJvCbTvP7CHE7fG6y7y2rvFxjkZDA5+GQHPStJgQsUS6Owcyr8Eav9+?=
 =?iso-8859-1?Q?xD1SlCjNap3l6E9ADN7JFKo3zbNdhfg74wARaHc2iIS5S7yfr8qqpKuGFF?=
 =?iso-8859-1?Q?DhpfIOJtwcySg38/VKh/vik9iY5qgehGPbrSNT8n0meXn2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nCONL6Uf0lwnZflmmZSgDh5HaKiXdGER+Lr4wr5yCKnxbPajetRlWJarTCS+/lHkwgYJaOYsJG2I1R7SY5+wdZlf4Vin/UAxygxQyJRe7uiEE8FvJqHGqCRfndK02Y1jFGQOASqii6wyakVfrEydWZDSnLODOkSonN3YilSaG4l9eYn1Eg9LxKSAbOI2M4fC9zDFm3r4FG+5wbMkpJG4ZjXyE8svJNZS3DNVndzWXJu0pPyD+vA+ixCZg+pdsLyjtGOv3lhp0P7odHjVizGytt4HqSOfFtdoBbO9ZX5A/ABrie7bsG0EZFGjxG6M7Ev3sV08IDoJ6jVitEdwEMDrvg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR06MB10711.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fecba9c-c54a-4a60-5a81-08df02f8e67f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 22:33:35.1606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRLXd1PPpS/8ruCUshSB30gCawmE/d3k9mvtaT9q0Xbcq9hNvATa/hvWqarKf5nm04IFHEXAtLZJHE5FcIuNKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB8044
X-OriginatorOrg: amazon.com

On Tue, Aug 25, 2026, Sean Christopherson <seanjc@google.com> wrote:=0A=
>=0A=
> If it provides comparable performance, I'll write a changelog (or two?  e=
.g. to=0A=
> have direct MMUs switch in a separate patch), and let Sashiko and other b=
ots rip=0A=
> apart my idea.=0A=
=0A=
Wow, thanks so much for such a quick patch.=0A=
I gave it a shot in my test setup. While it's a bit slower than my patch, i=
t's still ~69% faster on nested (rather than ~75%), which is amazing consid=
ering how much simpler it is than my proposal.=
