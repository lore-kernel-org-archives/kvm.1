Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B52FFDD5;
	Mon, 30 Mar 2026 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901726; cv=fail; b=RgDypuQdbwqhwQ2GNmFr1P/f9g2mS3CG/hPmlJt83enjDrTMGq02vHSS68nwc7ShsG+8y1XC5IbR0qkRv4k6JoD8BKMVHDI1ZkGf/gGoyG47VPIepEZDS6A2/bq2wu/mkdoe8xrIA5BbzqkB7TDJoPD2HSozJAbsYW04hCjpqPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901726; c=relaxed/simple;
	bh=u2x2Ovb+QIIVDp7KaqVPTH52QLp63h7uG89lxRlXyaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ItVuaYxy9GFWaLCvjS8CXG/JuafaVJNvi1z0UoFP9euPOSN5HIhenKhlhP4nYVCV945stByg+Mh9fotWVFeXpQniQP4dP1KjwFZD0rptjrfjtuFig07vgDsEFeCA+mTBYVeF5uJ8A5E6W4L/gKQGcSYy80G4cXNlt1PO6Ne8QAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rxy5iVBY; arc=fail smtp.client-ip=52.101.53.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rxy5iVBY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APRD9P1mcgQjHgFQ80jbuv4IPTo2Nqq3dZpPM6ZH50kDTXBepjs2Ku0C1VflQ1j6fP47fx9w8L9fu76R5tCnrd64NHAxVAQWLyF1n+juMbUOOKfLlJgVACgQFzzBTJEvdjxNahMU6do08/ZqtbniQZQz9FmgL1uHTXmKow4ws3jcoP9qduKCDa6NyoNrDx/tdq6kn5DPxMliHDEda01onHR4bTQCTUvrSOhsLUAxsNQF/v8eZTloBJRLpXIvxfvbmYOm436OWFJHJFYJeUBljNkHZa9aK5W1BKCUEpQXZPcUJU3ImGbdumUX9QnHXri4kWoQt/yw+o9AJzACetLSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2x2Ovb+QIIVDp7KaqVPTH52QLp63h7uG89lxRlXyaE=;
 b=i8oHAksNlkpDrzCsggzpNGdU9Lmj8ecnLiFunQ08tPFD3sUVMDPyrjWuBXorHISdKuu1Rapan8dDGPq9ARFdnKn25OZkzZJ3P0B6q0X9E2c41L1XQI/j3v7zH2gWbMnhBKd6N+hX0Vl6F8vjjzJyDXy+FLWuMpRbd3mIoLvboeBXPydhJ6wLtWj0vtib/d5tqZDt67PbmwH/8Mz7XJw/zsUie3i5TjcRiCLw72u1Gpo4s1pmyKAsx6KwhQgswT8omN8VNf65835BY7DBhHDuiynjTiehV5hGGJmyBRlLwSqzY9RX6E/z33BtSpY8/1oxRDHJqw54fSrwOhPGH4sQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2x2Ovb+QIIVDp7KaqVPTH52QLp63h7uG89lxRlXyaE=;
 b=rxy5iVBYM+5ogmGSwKwv2091f2Al4lJDI4wewr/XLCT5RhfNnGAJRRZ4xG44Ff0MXFruZaQ9aVrcEhvyIYYyScurUBlFLqvIQmH4kbFObxyt975v+aXBo5XaRpKNPVvFSoL53Z+LCpAWpT/CbaL2MW6+m5Ez1phhDBymNnyL6A8DG1Z7tocHwDiEnsa2aFj98ivBdNPN05vwLWSACJuYbGkHxJbAQmvSK9FIU53dW2icT+ajKbBv0Eh6+d5CVMAEmFD7y+PF9d1FqdOXxwJgDsByC+r9/Z9hwKgnKDFt8rrAEtcKqSB6/p4F35xdCIbhi3nKtSa2rOVfO4MMq1VNNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) by PH7PR12MB8826.namprd12.prod.outlook.com
 (2603:10b6:510:26a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 20:15:15 +0000
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7]) by SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 20:15:15 +0000
From: Rubin Du <rubind@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v10 2/2] selftests/vfio: Add NVIDIA Falcon driver for DMA testing
Date: Mon, 30 Mar 2026 13:15:14 -0700
Message-ID: <20260330201514.598301-1-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <accGyPMCOM_Y5VxK@google.com>
References: <accGyPMCOM_Y5VxK@google.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0390.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::35) To SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF80B25317E:EE_|PH7PR12MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a7137f-94ea-4b34-72a5-08de8e990e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+lilwqbw4AwKK3iHqJFHDyl+5gxypA78+yniOKsrOlJhlhq+lgB6Y5zlLsoUPzZHrYTpu4JtEiFK65s/2op/g4EGZbl5ZS7fErPJpM5DC0ODVq8g+I3KxoHfwVfcvolrnmTYPqBJ4TGmJqHxei2AwGhdHIyajnDxN/Fjg94YvwGgduDvXXLOYONjzQuLjpUnHrAV04cTkHz6nDluy55vICCX4OIaXy1cTGF/g5Qs5iEqa4l618zeQpweec0cBx5Cja7VYIKWUnM4cDCZ5FlFUXf9X/p8IYvmsSEP/3YntFANst+bzipvQK2lRsG7OgNCOJ/eDL2OIMUFRHK1EaP5MVU/twO3ifOMlyuRYsq9gvowwRRH39CuH8ca5koiZF5N/ICVbVnGJ5ER6e1kC5CBK9/K8yodD7jhm0JrUGUmhpSnu94xeCU2bfe7jsaXs/VwtAaeJHkTnrMXCu+ZGaZUF2+FQVZOOEoa1cqj+Vmnd76ZYjnmURnLld51Fhhvu2YleCUvBF1jPHgKwAiiJZXJr9iBGxOBoZvVqRxrdjKCv+bTXbsOGLDvYy6Urj3aIAxHXigoCMbX7dlNbclp9bdyJhhdt/uiAcWAojTmPMX8Z/jgmxkrq1jwz5C1sk1nN1QCwWcpUuqAQn+v6LIB/uVEylUcHbqU3ht+blrLBnjdalAxoS1wS0yvlMs8lcw9s7leUNjCa9SnbHSMKBTfAGi8N2ZEwjyJaKCJiieYGQsrM2o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF80B25317E.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gJDQzkvFF4/qAfH9xOrb12AygFZOu/NBNY4G1xyZwdXUIsVYcFoVb8nx5u1+?=
 =?us-ascii?Q?l2TpyJvaRhJaZALo3OQosXsO9Ll4irJ2G/VLBr0Y5XdJWHuqog0qID2W9OpB?=
 =?us-ascii?Q?QFLfA+jzUKAhN7vBTRkJgObaILJN7DiBj1NvVLPG2tt1CgkTwUbp9UKuW3X4?=
 =?us-ascii?Q?vHfipKT81DoAzwPXvxdTgXrW3MqYVJygX0kCbnKZdGqgwWlgcPvg7folAo3O?=
 =?us-ascii?Q?buPXPQjfl/BVGGxHOGxpEPMnRWhw6kJoZp78OnvYdFla/qtYgNpQT2bjmuH9?=
 =?us-ascii?Q?/HXDXaozh/xoe1dIIPjnMQx1CjWZ1I9yVD6fhSP/wwJ1YLBtebJlkhBHwfN8?=
 =?us-ascii?Q?5+6XXBMHOCyo72arMHQI+oC41j0zjvn+oMA8fhlpDY8a3tscLkuRvfiDkfEw?=
 =?us-ascii?Q?uSAS/5rYB7XwQBChqeApJJ6QiHdCLeAgHmgCn3wxffKRTtUJTc89C9S7x/ll?=
 =?us-ascii?Q?ImCbHRgjXAs0DuEBGRUDaFJS6UwYODh/vrU9xBVoDITScn2FsQ8g02SU1Elh?=
 =?us-ascii?Q?iFVqBKW1ludXYpogaS071VUQ4TT4QCuTN8niiFm6NAqYv51po+hkCEs5AMqR?=
 =?us-ascii?Q?yZ/27In6H+n1YvJvj7dHoXJRNCLR0nCIufKw2PcObjwOHS1Z4GTIVvhI/KmT?=
 =?us-ascii?Q?gPYu6eydxPcOVdwMqKBYR9DTxo13Kst1slaQ925Pt+/SCCZmTYjJb92nUhEE?=
 =?us-ascii?Q?YHW/LS9icdIT3KlSsIpoJ7GZ/adcH6S2DdrMhumQHF6M63BRPWG3WhQajB5I?=
 =?us-ascii?Q?f3r6HEqWxmhOPY0etr6hNUhDjifWaqmt6jExDTjdGhYN6qBY1NxNZO4tHbCx?=
 =?us-ascii?Q?O6GQg0lthvaX0xqIfCPqv2uOSmtQ4HqHcCZwUCBhLBp3fsUCLnSLBDUran5n?=
 =?us-ascii?Q?zCJBaQ8/Cd4pmSDpaR6aOFL73ed5/J60LLvwtT5JZnq1cuvrhjvBWh8X5gcy?=
 =?us-ascii?Q?cxx6MXpJvxp6Kftrf76sdkdqT1F5WJI29epnIZ80nzMnJ6hCig42sP+Ohxbn?=
 =?us-ascii?Q?av3eBz9oJuzR0yswulxqmTD4y3WBzpTgkHFBOd+GAFnJ2X7UMTA2QTWIqRY0?=
 =?us-ascii?Q?YyNl5TQHJPSqLuHEyXyY1UnDXZoI7+9WrPHOHYZkY+ZPfmY5rzSAmFJ79JZK?=
 =?us-ascii?Q?hRn2a16GhnO5EANg4M4kSJTdhSLWSc+Zhb1L+lR7WN5RqronS0BiZhu0CT5/?=
 =?us-ascii?Q?mFhUh7BIi8vv74KS8amqOO1QKsfNnRZ2F1BbgM+toSQHiNgX58DqnRCGYiEU?=
 =?us-ascii?Q?uus/imtperu68HDZ7NE0uNsKVawQavOHJRU1OdhELm2nXLPQanZvA4TRPJ9i?=
 =?us-ascii?Q?sbLnrT8emLGyUhaLoU/y1MXX+Mq/h0vZKacM75X0XRPAQq7y2f7tXOSv30rx?=
 =?us-ascii?Q?LkxN5nnoSLR8ii8Ax4+c7Kb82QwrS6H0/AFV6Pht3SiQdYF5ovQUSh2beay6?=
 =?us-ascii?Q?hAxHZKSBkjOKJwXpSRvNN7USBn3sfgbeQQNP1rEwYz2DVvDFR5kYEroLJPTi?=
 =?us-ascii?Q?pmyxwkjR9E2oVxgQYaJt8AzTv/jarQJ6IZSAU9hWwxup/r36SFCuY4thYY1P?=
 =?us-ascii?Q?icq1yPPuF4TZgTZjPMlGw/4pjNGP0XVD7bo1H8S2Nc9h0sWxM+icASP7Vret?=
 =?us-ascii?Q?pbfyxUf5FYOxyKpibH2jAqsKL3IoCalHq/EQ/UWvBqZD8tSOh82KMfHBE1vr?=
 =?us-ascii?Q?sjyWdfTvqIKiEoGcOlRwvKtmFwTHJqWeKW3IE9lTqM8TuF5A8exk9l3ykdkz?=
 =?us-ascii?Q?zZKHgdfNKQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a7137f-94ea-4b34-72a5-08de8e990e6a
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF80B25317E.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 20:15:15.8098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEBCLaM4UHW5xKJCXfZ26bpa9olcwM1DmdEieYlu0xrKndwsFmDa3euEAnHzjJKYI1f7Bi7CljDkNsFFLuAdBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826

On Fri, 27 Mar 2026, David Matlack wrote:
> Do you forsee this driver ever expanding to utilize other functionality
> on the GPU other than the Falcon microcontroller, e.g. to add
> send_msi() support in the future and/or support asynchronous memcpy?
>
> If so, the name "nv_falcon" could get out of date and maybe "nv_gpu"
> would be a better name for this driver?

No, I don't foresee this driver expanding beyond the Falcon
microcontroller. It is not intended to be a general-purpose GPU
selftest driver.

Thank you for the review. I'll address the other points in v11.

Rubin Du
