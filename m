Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.199.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3948BD54;
	Tue, 25 Aug 2026 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.199.210.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787679538; cv=fail; b=LMpkNYhdUYAnlLqO7yJWTJ7VlMzi4LDMhT5eTkNkllNeLML1LwhQL4w/Jeh3Ikb8JLoykLUfKupofCgwZqKCI542FYq1XOcWWxmwl1ox/SawzBEye0GZwz+w5QV7S6/BaZlZeqI4eTIl2dhSNDjGX5zHDaosSQZiKu099/Uiksc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787679538; c=relaxed/simple;
	bh=+ZaftVhWPvFswNHMBUQP4SgjZadjPiNi1U5Knq3bEPI=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ci4rLI8aZ6BvFY5h2plMs2EarUGf00mMritjpBcaSP3QDoHpE3Q984hdWWczi0i8Um48HIwMdKCnXsyKTEe3omw2N2V0zFCqGdTxNSeJp8TlHVOg/OiXV0SWQL2Br88C2iVa2ULiXSLVwQz4h5R9fdDqGoON2146ruEl6jkA23A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=gouzF10r; arc=fail smtp.client-ip=18.199.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="gouzF10r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787679535; x=1819215535;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=HW8lwNd5r1hGfTtDPGYr0ocoRg2Dnly2+Ufqy8vupd4=;
  b=gouzF10rvBlG9uiZvxCPLSupZktOzBifi311pefu5wWgEXoj2WoB/esE
   kT65cOyjlfEIbm7O/9i3dSE3O0X2T2bxBvaksx6U10WjjGLigMzwZatuT
   un0Iyx2dfnVO/pJWBPQQCh+9EANr6PhsHzQBYLZ8p7lvOPvP0wNIvjvmN
   AZAIqPWtrKhrAcD+S8F/oi3f3woOuQLA2wAp7WYJ/BnZ37Xm0aS3wr7bM
   LZ1WqXRvRfyXdu7+nJZ3xe0uixKSxJs/3RatQegT7AwXDkUz4n65bWsjc
   sPE13KmKeFgWLWzZbWvFFvIoNt+6LZMppwUPVju7t+P27BjBO7S2TDbFw
   Q==;
X-CSE-ConnectionGUID: 2DsTmIMFRFi6b1kjPUglkA==
X-CSE-MsgGUID: W/NMTbuLT7y6CuUUPdwGCA==
X-IronPort-AV: E=Sophos;i="6.25,243,1779148800"; 
   d="scan'208";a="18325872"
Subject: Re: [RFC] KVM: x86/mmu: Prefetch forward run of pages on TDP page faults
Thread-Topic: [RFC] KVM: x86/mmu: Prefetch forward run of pages on TDP page faults
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 17:38:50 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:4786]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.28.49:2525] with esmtp (Farcaster)
 id 2cb4353f-c88c-40b7-8224-5d6f5c68bbb6; Tue, 25 Aug 2026 17:38:49 +0000 (UTC)
X-Farcaster-Flow-ID: 2cb4353f-c88c-40b7-8224-5d6f5c68bbb6
Received: from EX19EXOEUA002.ant.amazon.com (10.252.50.139) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 25 Aug 2026 17:38:49 +0000
Received: from DB3PR08CU002.outbound.protection.outlook.com (10.252.50.44) by
 EX19EXOEUA002.ant.amazon.com (10.252.50.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45
 via Frontend Transport; Tue, 25 Aug 2026 17:38:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeBvAV7zeBI+7Y42tSnrtQDMF7PrSUpvBNQVa+zk3PQToJ9JNRXKn60urx75Ps6t4anKxZAyG5I1ntq03+mvEIIDu9PFpzMkhPZn4HR7M8y85GCmgBW6IFZDGEXfUyuA7gy/t/lkYHv3w2Vmifd5/uDiRGqpa4BFXcksNDNZWfd757o3j8Zz6eWKgFoNRGgKhfweVTdCc9UoVApd8swtmKPGR8poc0TZVlbIBRcnKu6enEFi5mD5MWAyxaTpokx6/k6MBlnWH6iEOzyd753BP1RU6PvtIaS2GOWcobV4VqV111qmk4Q2eOThbIATUNviZTq6IYNslqGGfZVbI+0rkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW8lwNd5r1hGfTtDPGYr0ocoRg2Dnly2+Ufqy8vupd4=;
 b=W8zTRT95SkFSIfsqJxoXEkyyD2cZTsjTD0lUT42J0idQabUkV7v7F+qsqTVsoarIuwZDilvNtnUDrJHXIS5+rXykG0gQGvTUtQHsmVptO+/0wdLJjnGobwI8Ia0JRM5gJykqgqu0VyapwcrjqLvcXyOsVJGDZraUK9rD17trSBt4CWtJs7VX/BmSMsGr2ucsDKt7P3xFdSKdmOMHkpX8YIpPrOD9l4ARNe2qeS6psIKsOz0izrf36+hyZkfGC90tYY3xiJQQGm/xxzuo8HPHI4n0UzsPa4NkNA01QqM1XOsK1C7dtWMR+xvuUInhHLuc8JboNTIyXFO+k5uSMJC7Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from GV2PR06MB10711.eurprd06.prod.outlook.com
 (2603:10a6:150:2fa::20) by VI1PR06MB8926.eurprd06.prod.outlook.com
 (2603:10a6:800:1dd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 17:38:43 +0000
Received: from GV2PR06MB10711.eurprd06.prod.outlook.com
 ([fe80::ef79:3e5a:90ef:ae71]) by GV2PR06MB10711.eurprd06.prod.outlook.com
 ([fe80::ef79:3e5a:90ef:ae71%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 17:38:43 +0000
From: "Marangoni, Marco" <mamarang@amazon.com>
To: James Houghton <jthoughton@google.com>, Sean Christopherson
	<seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-patches@amazon.com" <kernel-patches@amazon.com>, "Mancini, Riccardo"
	<mancio@amazon.co.uk>, "Zoumboulakis, Michael" <zoumboul@amazon.com>, "Marco
 Marangoni" <marco.marangoni@proton.me>
Thread-Index: AQHdNJqdXqr/eEZTQESKiH5g17VLlbau7DOAgAAQ69c=
Date: Tue, 25 Aug 2026 17:38:43 +0000
Message-ID: <GV2PR06MB10711C9FE46F33B0613DCB66FB9AF2@GV2PR06MB10711.eurprd06.prod.outlook.com>
References: <20260825140159.70997-1-mamarang@amazon.com>
 <CADrL8HUcr5Fei1PX179bkFmMJ_S+eD267SVgc85cm-rpcahwmA@mail.gmail.com>
In-Reply-To: <CADrL8HUcr5Fei1PX179bkFmMJ_S+eD267SVgc85cm-rpcahwmA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR06MB10711:EE_|VI1PR06MB8926:EE_
x-ms-office365-filtering-correlation-id: 00e4cbb6-8418-4792-7b33-08df02cfb526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|4143699003|22082099003|18002099003|11063799006|56012099006|38070700021|6133799003|10067099003;
x-microsoft-antispam-message-info: b8IxlhHKe/PWkVnZGYgMb1iz9qamny0btlDb16Sy31dQIUo0zWp4jdrQP0yddSvlaQ38TcaeN1popeYsn9/b4DN9Y2XLdpPg5VWWRArReGKsnFbFWbiE8i+h4QszRfIudT0QRjMDEwdxvVcwqToVLgvY0R1lu8yg0ZbrPaNCZH+vFf/ac5HaXZP/cKxZFsZRn2TPPcoDskesw0Q8eTS9xCvjwRNA6R7+33DdGIwkrMA65KHw5pqJ/+2utHnFl5TUq9mMzNxyLcryZawmlaPvv5s+p1/x++0xd1rCprTlZ9N3mccMJpKcJevk25cuCxoLNjPVaZTMwrDkskjjLvfGWJm2Y0hCYHnK4qVqDv+W6sS0ZBzLdfJ4LX1RhbWuCDWrusjP9snVGND9T5hNCsehnO/rriyrEzFhTQGTJQkm871NycmkVc0XyZCzeolkja1YvWl1EE8Id/BpZF61a96U5ZqndONIGlclQ+AJG+tCkqSk/IYIAaTQ0EEZqHJLNz0srMU+QKmBvUW5ERuphSZ0cTen1S3337q/eL9+Juczaep6XMCfNcjMrxYF6MAGj3koSihA0Pp36zxphYx7ThzBqJmGGwpmIK18HE4oL8G92BkSSHvS+KobpSSf0r5fZmMFdzuI493X9VzebAbJOid2po9Ijxb744mSGEBIjLk+ESDir/jMnCAl/ew51i+w12e7OIgwyYNy91UB0saO2kf7IlQLdruZQfLQUNxLJsgVdq0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR06MB10711.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021)(6133799003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kpi8w+GFnVP4RZnJHTmsEZDgUxf+gyllBhXaaG78E3NVIk3T8wqu2SjgTR?=
 =?iso-8859-1?Q?l4bK1XXvDlc59nj8RAkHyQLaMZUjntlBEqSCt0Jge7Vl9J8pPXnjTpA70w?=
 =?iso-8859-1?Q?/hRZxRXuU6hefOb0Sc9sGM834eNnOM6BqKptEVPZ8mbK5DBXvFcXD17lKB?=
 =?iso-8859-1?Q?9tELYrOZD2hMQw9TVDfzlSLnrh+U51HQbSw4Uk1tllEpb1K6qJ7mrnI5bf?=
 =?iso-8859-1?Q?ahsG03+n3qNJQts/xQ4IrShc+5QJ9xcA0Z+dC/UVp2Gqe1yr6WYXfMdQK4?=
 =?iso-8859-1?Q?AKVLFKoz7E7TqFPO2mWfULT/3wpAKQUdUy9W53Og9xTFtP650w44XPzCgo?=
 =?iso-8859-1?Q?/u7SyO8qPflVqDEukSZNYyiOzeo8N1FHfSmJDAIUbFLFuVNKUX7jQbSKU1?=
 =?iso-8859-1?Q?LlogO/vTlmzTpJeRCd0Qp4gviX9nD3z+mUzzD+yXn6TFjDGNHbsAdRk8Hp?=
 =?iso-8859-1?Q?99sLmvH2+EqQvGQCbDbsLHHztwOrLDfU+wTH/IUiZdxnMd2PFV1PbaCmy6?=
 =?iso-8859-1?Q?D6J25PNCVavxGdJ/Su+v+ghYW6T1r13M7lqwQ+zVNwApazXFNSO6n3+VXP?=
 =?iso-8859-1?Q?sagxUlG2I5gDH5zd12AC6hCA/fs4INN6cS96qE4QDcFKXGzia6W7/Tvslv?=
 =?iso-8859-1?Q?TGak3Zl2xBEZNRK/Ha0Gzsk/6riM3s/xOXorrv+HAEjXXKcOw/gIDcqVkW?=
 =?iso-8859-1?Q?w/ZOqUsBD1dKIwxjIgbUhvwkZprXmwFBSbpX6ANeqpg1Z8zwiyvowgrU5w?=
 =?iso-8859-1?Q?2FsgWNI20EfGm4rRVnOranbO5kWWJ3/oTEUlSwdxW/88f7j+ai6unhO/k9?=
 =?iso-8859-1?Q?basrj/TfCpLy0KY8fQI/VIvks48CR6FWAukRDlPGSVgWa82cIi8XrLnL7u?=
 =?iso-8859-1?Q?iW6h0DtBCkN7HpwuAvpTOZI9ZuIkg7Um0mwSNoLw6WXmWnUhsrNz6FtmyK?=
 =?iso-8859-1?Q?zi4hEjK10KdG3tBSql92G3uHVH6/jqBJWo7IulS03dePqoGhyLoiuWhD98?=
 =?iso-8859-1?Q?pZG1uMf/FlrcTF7tBwqsRhiNUGdGjJQJeGfhk2JtWONOuMZBRdCMLbXRrV?=
 =?iso-8859-1?Q?tHDlNWpih6HPGWcX/seNIQ/cFizYosf2QRaGX3AhW2t/bdp9XT6XikabY2?=
 =?iso-8859-1?Q?b3zmNN8tqtrhIirovsf4VVNzMj3O5kmAt2X4V3T//l0+22sD53n5dtliAP?=
 =?iso-8859-1?Q?/WL6hrpkz3m0E8DdRfsVpTGI6Yjvw+FoMrkhrYdUZAw6Xt0zZRjpRvzrou?=
 =?iso-8859-1?Q?6GPjNlUilfI5G9pyy/glmnpaliGuOgPy2Ph5pSdMzzeujY9MgU68QEv8XU?=
 =?iso-8859-1?Q?cJdC8freaiwe3vYweYrcmCCR0SsEKfl6Ci6Pa6RmI/NfG6QLBc8Z+GIYi0?=
 =?iso-8859-1?Q?9fiyLXeFjf4G6ruYM4Q9ZGVG3XEQ99l6U3fYiJ9PjNH1kyiq+aYw0YMNPl?=
 =?iso-8859-1?Q?bZ5aum4UaFNFLWx0475EGLgzBxQV+UjCu+QOCjR/s11HdCF7X+Xp8jt06N?=
 =?iso-8859-1?Q?KrV59GkpeWY/APIAVaW6DuOhBlt86T6cv6OsdqFWWsndcZFpwaLQYvZVo2?=
 =?iso-8859-1?Q?dO9re830yINvH1/HRNQZ+NwRRI/JyZ5nFpVAHUjZIJv+7hCqo18Ou7PrM5?=
 =?iso-8859-1?Q?IKYRzQpZlzH8lDakj9xtBKU25vT6cR8wqCHybRALWgM3Z99P2o4oMSxDk2?=
 =?iso-8859-1?Q?UfDQ23LJtsOqXR7RE9Z0843/PeAzaiQG5BRFnakZ/UGMpxvXTKbykzkPCc?=
 =?iso-8859-1?Q?uliH+ynfUP3HmlVFPDxiP8vocoQ07jUOjAJ1fFMd3ghcBR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: C77LD3KBQFi/PlHa9KTXSIvannmIa1FP+d07VcAiv+EylBiVc8q+EaWsmMjbEVmOlJ6OH/l7EE1zZABf4CgKIXjFgQqWCq2sotUiRNpd50yKkUiYdW0msEypH7IcPcdnMTosoARCeft47Rzj4WfE0zUVX/5WulV7fxwfHD8UVTIFik9fhPYxRvvc7vJZ2UJneOZkPA1n4QHN14wd05KRi7Ku0goCeyQ1Xan5t20Si8gBPzq9oFaICNJ+ckqyT6LVmJU/UkDUUrfMXOntiLLscgygfTgUXhfPbbO0gmnT0R7Ikkn7T+Bo9aEfnaL8ConoLO0z2YZC7kT4Qh6UOTJmGA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR06MB10711.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e4cbb6-8418-4792-7b33-08df02cfb526
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 17:38:43.0207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PiVNtGf/Co9PnmrHOvGbGfgChwEIXmD7R+9fE3I7amgSxwfnrY071O0Y0y/xnEtHbaAFzRPRFVHSnwQE26voQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB8926
X-OriginatorOrg: amazon.com

Thanks for the replies!=0A=
=0A=
On Tue, Aug 25, 2026, Sean Christopherson <seanjc@google.com> wrote:=0A=
>=0A=
> On Tue, Aug 25, 2026, Marco Marangoni wrote:=0A=
> > It's worth mentioning that I also evaluated using the existing=0A=
> > KVM_PRE_FAULT_MEMORY ioctl, but this doesn't work well for our use-case=
, as=0A=
> > it requires the vCPU to be paused.=0A=
>=0A=
> What about if/when KVM Userfault[*] comes along?  I.e. pre-fault memory w=
hen the=0A=
> vCPU exits to userspace.=0A=
=0A=
KVM Userfault + KVM_PRE_FAULT_MEMORY is a valid suggestion, however if poss=
ible we'd like to have _both_ async page faults and prefetching.=0A=
I haven't tested async PF together with prefetching, but tested separately,=
 both improvements yield great results, so it would be a shame to have to c=
hoose.=0A=
=0A=
On Tue, Aug 25, 2026, James Houghton <jthoughton@google.com> wrote:=0A=
> I think part of the problem in this case is that UFFDIO_COPY will=0A=
> install 4K pages (IIRC), I think a more natural way to fix this=0A=
> problem is to:=0A=
> =0A=
> 1. MADV_COLLAPSE after doing UFFDIO_COPY.=0A=
> 2. Make UFFDIO_COPY install PMDs when it is able to do so.=0A=
> =0A=
> These don't solve the exact same problem, but really userfaultfd=0A=
> should already try to install PMDs when it can (#2). If we have #2, #1=0A=
> is mostly a no-op.=0A=
> =0A=
> What do you think?=0A=
=0A=
Directly installing PMDs after an UFFD_COPY is something I already investig=
ated. I didn't mention it originally, since it touches exclusively the MM m=
odule.=0A=
For some context, with that approach, in the same benchmarks, fault latency=
 on nested is reduced by 92%, and by 44% on metal, which is significantly b=
etter than my proposal (which "only" improves by 75% and 22% respectively).=
=0A=
However, that approach only works when the copy is done in multiples of 2Mi=
B, and for some Firecracker use-cases, that's a no-go (I can elaborate furt=
her if necessary, but the main problem is an explosion in incremental snaps=
hots size when managing memory in big chunks).=0A=
I might pursue this proposal in a separate patch, however I'd love to work =
out a solution that can be applied when userfaultfd works with smaller chun=
k sizes.=
