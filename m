Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D16C525A89
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651718; cv=fail; b=lzEIEpG8wQxAfFY7rGt9aPk/YKnteGcWIyMNqWjbsB09ipYZpI4R3nwv1BPSUduj4Q+NXlV2vHxDNE3WC/OQ2babm4N8Of7t0yafTWrRPzd8teTNJS2iH26Oop9DjsUjDveptEPSpedw9XYdjzlrR7f8bidPmB+gPAupw1ZgvDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651718; c=relaxed/simple;
	bh=KuX598sFpmHAwE4Lv8RqFLJXliBzruMpV9nIouy6Mp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LOC6WnmHloQ8ccUj3OAPxYQ5nCtOwqZDfBRNXLam0atEOtTe8dzLysJIOvGDZLQXWXix+1ZKlMWxWvfOZjzLGaQLBn2vQ06GPAL8kIvH6nrZg5vfXTP3zlEiJ+R9yJGcSTtgU0NAPc6gZE8P3qkCfr1aPZB9YoeSY9zMj/Gc2M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bv5OZQJj; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bv5OZQJj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T05GsQk9CD+Llad5/6Y4/9/Q+XT0LY1/xONTAHogMQIIoPgCahTv0ryDQsdKTJjoumVarQ3O47gcUt1rXTPZqpaXzA+1DKLHI8zscpawoka5kYa1AyFMsjMWynJlaxtyOFjA2Kod7ObVQUiRXtdBvowMWgG2rtwXeqaju4k9HL7PrnbbwaKT6VP/VawnYsuT5HnDt2t9jsjjAlsAOvBz66ZwjE/XpGqB3ozgoc6QtDgaP/vfG93Qu8nP6E61PoQpA5oPWZc9rp9AsjR4Km8YYnqy6a74RuOur1wnfOEy1jQqdpqLURMwwsTrf0JaAc80W/3f7niR/aTIrA6YBgG/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USSaLadD5HZV0myvONbZ4v65zu3rnNL4yD8l48T4zWE=;
 b=wJQRUTAAX1NwQtvJyQn7P3PNkl2ku5jU49wKhwgoBCZ6su73S9INDX6TF4SRr9kUOBksoRiwosknWfh4dzq7Sc4bFfrubLWbm6sHIeRE1Kqpzg80Qh2LRSs4fjRyI8rrcfDZTRakXUBfBRSFT4MXqYUhz9FYUfAQTdEI2B8RblW0dgXutpFxHB7DZ/1MMRORd653AwkY/amOR9PW3ZOIzGTnL1Et/Xi1YnaoQCyLMmbzvlsuqOUtLrAa2nCn8/7rgF2gzMNcK76/zcFBYUKw6269bWoC321+T2Jp/3pxEDbbsefafFgdbAqIzd5epoPDbDSxvsb33Wzt3v1gcO2QHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USSaLadD5HZV0myvONbZ4v65zu3rnNL4yD8l48T4zWE=;
 b=Bv5OZQJjm1yhvvoWo+hVZlLOFfNttViYI96uocqaihF7UnXIGa8fTUClA/Zz1VLoJO+Z8Mm1BiLe/xjf1JGheoxmOWluDTUxUtJRSBHIUvvKjQWBevmXbNsCyU6GMGFgISiO67gVfLYinzSl+t1UbxJriveoy5ciJ5pC7ecjvI1d0tpb1v6Msp4A79Q8fdw4f0BXuxpR3sHn+6YUALC6MPQgi+/NB3aHWvuQfujWSIbyyaUBKM2bpA+UeVUZ7WrfpC0Vv/7/mRQHltubgBGfdjVQi0oysXKXXWRIEwQhHyreFtfISgN/ohEmKxyjPe9VGdJquEKs6nsUeQNfKNVSWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH8PR12MB6819.namprd12.prod.outlook.com
 (2603:10b6:510:1ca::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 13:28:30 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 13:28:30 +0000
Date: Thu, 17 Sep 2026 10:28:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Zhi Wang <zhiw@nvidia.com>,
	acourbot@nvidia.com, yishaih@nvidia.com, skolothumtho@nvidia.com,
	kevin.tian@intel.com, airlied@gmail.com, simona@ffwll.ch,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	jhubbard@nvidia.com, ecourtney@nvidia.com, cjia@nvidia.com,
	smitra@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, nova-gpu@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhiwang@kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO variant
 driver
Message-ID: <20260917132829.GA3968357@nvidia.com>
References: <20260905081116.106613-13-zhiw@nvidia.com>
 <DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
 <20260914121217.70fa0d93@shazbot.org>
 <DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
 <20260915120148.7548a8ca@shazbot.org>
 <DLG7C7MLGSTC.2GSTD84WI595N@kernel.org>
 <20260916141718.GU3968357@nvidia.com>
 <DLGUPX9KPFKF.12CU304YAST79@kernel.org>
 <20260916162817.GW3968357@nvidia.com>
 <DLGXS4SCP3VT.28XXX09BL963U@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLGXS4SCP3VT.28XXX09BL963U@kernel.org>
X-ClientProxiedBy: YT4PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::10) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 115f7123-2c7a-4caa-cbf8-08df14bf9070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eE0jD/opmAFLo6Y7zy9Q1x7Bq5yLikQ/F+y/iMztz0Vz5fqo01iaB+wncjV1DpnuIo9LwIkXzx0arhp0ahR/S0P73Cv86RNau8V3k1hpGSrhq7iSar5G6VVKW+jhHod3SVjBEPESbqp4wB6rqVMGuX6uJETbq7N1G/AfeATZ1H8T+v95qB6rGSGJ/nNSmQvzDT4We5RTSiCTY2QBWOeDnFaZZ9AuiilDg80wrtfkaOEtZSKcJa8Dc21GZYDlTt1821h4MDW6ZWeM0/e/VCtdJ5mZ7mkwwF28SyGxJUVHN+8/7ts+0qI8oT1BmKNXhOcq4Wv+wvVgHNpPKtiOPr/cYIODze4I+PBTR66fqbLm8622OeZOD5RfDGL/5+X2+RX3I6T88zrUeH0zOkjxN4SGkLAJgl5sZUaDzteQDBio3VZiuQeOULVBS1u+RQ5kZUF3YTizv1ppa+Un6lwhvCjgWkudE+EsYt8zHTQu5eLmvObmPJAWTgMLbSeYgBM0ELHDI5kDiBcJikQcltTqq8GAR+g8XOGfmPn31mM1BVA1nev8TjrPuuGgloztWhFYeH+SNWBOJ9AL1+x6X+F26Q3+ZFXMPdiaXv3yuz+2CphhJDVQ53hsGXHx/l44w/KzQdex+ouIetVol/Pd20Crv+K8FMEiNdup0fbiQEXRADgyx+U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g/nqF2Fl5SvoYg5X/rtS4hedsRhl215+2+5fnFbw0erCcmsw/ZFvPeq78apg?=
 =?us-ascii?Q?VyR+pRIFeRnYRls2UVbJHTo4v+ZzkKuEuz6U4gJPEIsXW6wQ6RTzJbDvK6ny?=
 =?us-ascii?Q?kJ6cGqMhKnmV+eF9JX7bR3CnTJ+Kep2BYdrFzdWgPltlX6J1+rOLuhMVT8eV?=
 =?us-ascii?Q?jrg9gcAYxfd+SECeqsTMGgP27dWvLD56GAkJWc/M2pf5PmydXvrR6FNgEJgO?=
 =?us-ascii?Q?5MZWfqN2qNA8cRhCF9phVHrrvzjHS4reFvn6eXXw0OEaW4O+LJ9kai7K6Sy5?=
 =?us-ascii?Q?uiuq6NmjnMMleb+3XJbTAP6vMwJ2zrP89LnT6Jdco/EEXtrC8WTqtD3KPuTn?=
 =?us-ascii?Q?KXRJvl9sKG/R+0Qjb2FoMj25sLhviBB4qqKJk/Hc7NzdcEsu9fklT7fc1CXe?=
 =?us-ascii?Q?XJxbQVtKy9LdbHYzstk6nRjCmouTHOg4xM1X1D7ZPDa5pjRfu1vdG6Ekr5nU?=
 =?us-ascii?Q?VzwIebIHq9sbdEfqlQbj9vxerPt5DYA4/rBY797XZqK1aOURjKhooUTn8cRA?=
 =?us-ascii?Q?O4hvqQ7FIIoADFXgkTXtI7Ihs5134r2PjLDBHeCPiCI5rOc1VBDfsyGWWLd7?=
 =?us-ascii?Q?7/Cf2WMqTOzK3HAw/KJ7Q+f6F+nufDlq0PD1QnVbVpkzBq47K9XMd2RL0kBv?=
 =?us-ascii?Q?5SVlqk10JmRzjeJn7FBKw5nDyQr9fxpUtu1XHI8Z4XpOAXD97nvl9+1wYKtu?=
 =?us-ascii?Q?sjpA/foZp0+tQfUVn5GlbijyUpnWD9rR974rvNRR3h14VAAyr6hhsFLXjMr9?=
 =?us-ascii?Q?pJHMxAaA6A55yIqDmeocnjcgaYB95w5QKpbAWC8osy5xD6kSOpraYvTABvu3?=
 =?us-ascii?Q?EVL48kghYpw+u3bAfc5W6IqQFoTWquSlb+O0oP1DS1DWWZJqiMAwbzeIz0hh?=
 =?us-ascii?Q?zx2sHlt4oxZ6kaI6qE4TPLSNfiohX0IJqA/wMq2pS2itY0WJXMv/wvjA3HBM?=
 =?us-ascii?Q?Q1Xk6Z0xhBY/WTgKh4sVXzGkMfdpdu8rxRLnJiYstDVQ+6nR5qy/Uobuqip6?=
 =?us-ascii?Q?SNWt9B/OcgPRsQezb2IAbrDULlHWsLTKq52POL7fpnVurcwD56dAIJsx2ntA?=
 =?us-ascii?Q?x9UR5pTKrZKtazoK61UP3OZH7MRVJ2NDSiybdaI+Mfm0yd0jT8qH1qKr/9im?=
 =?us-ascii?Q?H9SPvjl+Q+2KfQsggh0jls8Kb4feCQwLUFg0VuOyNmaH7X/aY0kOv3yBn03V?=
 =?us-ascii?Q?2QACCDCNDwcqUugSIH9aMQYEfgm5v0/Xxhxys8TcOPEi56bS/dQD0SyjiZeV?=
 =?us-ascii?Q?s7z5Xd5wttnd1RTvxtEQFW10FNZUTr2Lo2eYOHAiYScvm03Ijz13EO0GgozK?=
 =?us-ascii?Q?7DnHi6wGssLniEcsHp8CTdeNUPDOocXhMdMwOgprDSM4xSSFUhdCtA3TG2M1?=
 =?us-ascii?Q?7NAMEwnOpmS6mhj8tyzIr004m4CNLgaEde7/Rt0Fe9tEjEElG/fZ1hN4lAbN?=
 =?us-ascii?Q?ZimW4nEsoxmdpLMb1qoA50PGvsnGBP+VtzR04Nb+pHeIpGOGvDQgaRNSXz74?=
 =?us-ascii?Q?prxLBV4bmqSRLYBZH0KVccgp+XyIDcsx8Y8yzT2TjEncmGvQrEiVNVUnBrrA?=
 =?us-ascii?Q?FZ3z+KEs6gJOXfWoH3JwaDbkqfLpKR4MNivN91K8DaUiwImbmLlbh03tn+m7?=
 =?us-ascii?Q?+OfymQZ6ccLrhFW+H7nhHQeisqfh2Zomi1Fy6C7SpggPYG9raAlanZhX6Xpw?=
 =?us-ascii?Q?tApJZqdEw9a/Fh3UJI9NigJTdQw6H38DosuX6/j2tENW4VL6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115f7123-2c7a-4caa-cbf8-08df14bf9070
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:28:30.5757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTdk5BGkVE98LD/swt7oQRo7uVpTMRMvmG0eelOYYZgLVqqplaqqwEeXUBK64rQf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819

On Wed, Sep 16, 2026 at 08:02:17PM +0200, Danilo Krummrich wrote:
> >> TBH, I don't think it makes a difference; having Rust abstractions is pretty
> >> much the same as having another driver. I.e. it would be equivalent to saying
> >> "before we accept another pci-vfio driver we need to do some rework".
> >
> > Well, it is, but thats the point when judging effort..
> 
> So it seems that we agree that there isn't really a difference between adding a
> new C or Rust driver in this regard.

To be clear I was trying to say I think you are are underestimating
how much work this is and how long it will take. Including all the
preconditon C reworks has to be included when considering how much
work is involved.

Why can't we just go forward with what Zhi already drafted? Do we
really need another side quest?

I cannot forsee rust bindings for vfio until sometime in 2027.

Jason
