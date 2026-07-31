Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759743B8BD7
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491518; cv=fail; b=lJStph2lpi207xv8nzsu2epjIU3mH3EwlRN6kOFyu36NC1WZdgbW9gDCaVJgWdZ/YTn5pNFaxxXKe+QyN4X60ST35hQvDUdC4/4woFPLExd7uoBWWtmowAxsgONM8kJqEibxLsLDAd+eizYdh7z2P0MTFgpKtwtP6Inq8IjZjPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491518; c=relaxed/simple;
	bh=kqbBRroi0SlnO3srOedRWn1f5FluYI0cvEeM0XXwRpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NYnCd7v7o4VO8nyElqhDIMwAbGuRS/Z405Kd/HPbxPXNWH1T+8PrUcjIhDgmwGGeF9i0h6g6FAuGSKKqqvksAwS3zALYCVlMNLm33IP75Fo+hlOt/O7e7ZsrAfUOFoHdN+i7ZqCtVUa2ByoLPIZQ5oBOiuyan6X/xNyoQP7V1t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=nkiMtReK; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=a58OH1rw; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="nkiMtReK";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="a58OH1rw"
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V7xPSX139274;
	Fri, 31 Jul 2026 02:51:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=dDsz9oMPAPNcvlLjneLKE0U4q/x6XlO3TCMBCy/nO
	Cw=; b=nkiMtReK8EjIDjWi4+5xLut6YUM+pxBg7d7xLpVr9oZbjbYCbX06hLkVb
	CJ3Auz2LmACqqvTD8lPx/1epDUBuJBwXZH+VpKBAU4eV/S8MZkyb2NoBcfMVJgu3
	Zz8vYgnvW+nT895iSZlPBwxZB3yUFtuaHp8Ykd/fxwIb5sx43zOctOuadkA7OGf3
	hMJjVvVymx06vGUnDqw3gxgjwzfPOVnvv1yH5X6/S+8w9uyISSYIv6QltQrkZr4C
	RaevDbL7Uc/x8VYR/6P/8hfiovXY1inYPd5VpbTEMKB5Nn+8mPMgdDDSJl3E1hbn
	sJjzr6XTYTbhsDlaknIej7ZjzhT6g==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020138.outbound.protection.outlook.com [52.101.201.138])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4frpcy0dqm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 02:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mICYhSKzFiboKuOPmAhS3S+QEfKLQBSLyTQQqVm4MjqoUE2Zf0cMWe6wDaYe8UclEFkU6dLRT6adAUKex7jOxTUK5AcFZnJqQbmrXy6bk4YVngcq7o6i6GiVCCkMwI71ofZU/Fxa+lvRzkD0/e6l0p1nwqtu+Uab9i3ol+RPMjs91zESj5M5dQXohIls7X1xGoEPTwTVDv/mUyXwVoKBKHLtC6vPh0iYDfH820qUjbt0IKHoIIsvy8DDiZThesl+xx+OV4/me8KjsoLmoU/65kgyLyBn9qED28BhhOscPcOPUSNepSxXRZShBPVv7atF7U1n2X12asZpiKsWsf8tyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDsz9oMPAPNcvlLjneLKE0U4q/x6XlO3TCMBCy/nOCw=;
 b=fgOybvDBLLGHp7TCtq6j1sonue6wJl3ZLDtXUc3vGcv/zk+lNO4wQEvk9fVC03aPHwV+/pKpX4FfOSwQKsI2ZpS1SCBB7djWRr1RvfyP8ut4ywSZKgom9lxrQrhQ0Nhv6UU45tsB4Pm0cibnLeXrtRn6IsFbqZg25eAj3budr0/78KpvbrJgJaaDQc2E6jzrFET9Gu4qVmKjLzZUaKvhhybaRYuBGvTGcC+uFwuzVp4kNmBqiuRPvReO+xwGcjqCYZY4dZCU6BNt/gXcUbW9mYw0D83n81H1woPYCNw5NRNlkzX6m4rAGLd5lTZuZGiVVE9JkQ5tJ9HVxUIJiSxFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDsz9oMPAPNcvlLjneLKE0U4q/x6XlO3TCMBCy/nOCw=;
 b=a58OH1rwNSTV2RippMgbO4jEcj34vwaEtwA+p5oZDKUF/b2sT4FMvC2b6Q9DNd7kCjpVFd2GNLLa/QOzzjdJynnAAy7ZDphQQ8OSYnhYAOuIn/NQO3CkDm3r/t+VufvGwSU3gRWk0doVpWVQNefqXrifatpgaS3llW/EVCVqx8MHSGNNV9ICOBM6+s/X+KRaflZEhPKH1MA78uf5ihlzr9e/wM5aN2HBqufpEzRBG0tqQbc6ZUvvOrwR3e658VeLD8IEzsPhCiLjkc+WnFzmAv3LAokd8WPsVaz9fFg0LvY1NU83+L+NoOEyEid5UE6SJ9yWNYbx0TE+NhfvQgYDqQ==
Received: from CH2PR02MB6197.namprd02.prod.outlook.com (2603:10b6:610:4::25)
 by CO6PR02MB7842.namprd02.prod.outlook.com (2603:10b6:303:ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 09:51:37 +0000
Received: from CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab]) by CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 09:51:37 +0000
From: Florian Schmidt <flosch@nutanix.com>
To: Cornelia Huck <cohuck@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: kvm@vger.kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
        Florian Schmidt <flosch@nutanix.com>
Subject: [PATCH 2/2] Add HvExtCallGetBootZeroedMemory
Date: Fri, 31 Jul 2026 09:51:12 +0000
Message-ID: <20260731095112.2975175-3-flosch@nutanix.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731095112.2975175-1-flosch@nutanix.com>
References: <20260731095112.2975175-1-flosch@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0057.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::12) To CH2PR02MB6197.namprd02.prod.outlook.com
 (2603:10b6:610:4::25)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6197:EE_|CO6PR02MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ca9bfb-f0d3-41f6-b4d0-08deeee95017
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|23010399003|1800799024|366016|38350700014|3023799007|6133799003|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BqiQiiRBuJKvvqjl3OzCi25RINsNvNrWamLO0TOmna9RXIe1XXmhpMwcPNtfM6x/CFkfHIHPM89ebQC//nnp2P6d8edNWXQtWzUDIkN4TMiOCyNDb2J3j8EGoZogD/9mCfYBjvhHFxX2/JYOIY1OSUN+r3I5Cfle9JJ8OMTpfOOBK2c6Kc4EXK1lFmihGcdKVzVLHm/3+8wnJv+pdTcOfIcMBMS/sAun2LO7bNsPIqP0Vxr2RckBOSxFxPxeePWpo3vNzMbsHwCqrnta+tc6d/En+JGO96VBMZc94AiSJxLO20vErbYgGrssKlmJ+qhQevpVBodTkTPkmJScMeNeJBKBOMx4CZu4NsBflc2MyMY6jyTkshiikiqEjy3j7u8BpjzkcQK3E39BWS/Zqs/pr+VA39TnDJi2ZLWT70xi7PpZ/cioRQKmeXAORwWHQh7NS6IG/Kr2Z47zQaZqz/ElrMj+Nl404PBoGnhlCrYW5NvFKHxumP8Y/StJpvfgJMOJgdTFVqdlV3jDciQelaHxYuzAVdAM8CpJE9jMM/ltOBzUw+Byws2RQjAdPvjyU/y1C/91OpVckMYROTPlXymBTB5goeMHkbHL4trVlc4DouzRJQgKhM+gAf8RXmyoKA3DCPoR6/OXrfV1A6/CZeu6EePL1oBEvoU3ZtvWYezRvuJ+55AgCA4zJxXIbSmYyXuLcVFma3afCI7p6dhLBv7v49XvL65IMt0D05CZlhz9bEo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR02MB6197.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(1800799024)(366016)(38350700014)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A76Xq/sDT4YR86YQd9QtLnnsguWV6+jBmWpgV15kHhhQ1oydbgwCNBlk4yfV?=
 =?us-ascii?Q?C3pvtI977Zds0ufOizcSZb9K/qKc01oNi9xbMdhbnli8xn7PgY5JRJrWJHpB?=
 =?us-ascii?Q?X4LqAWijnIKISfvlmkFqKWAwUSEmCwxNZ6lUbQicB8mgakVAC3PMwn8f4wtw?=
 =?us-ascii?Q?NwgKRqM5XqX0P/pHJ47CWWaksw4wttjkth+N8wvpa+xvi65+b+DLPBn+/Dg4?=
 =?us-ascii?Q?3GmEdClfl7OA3OzAgob3GwUHlpVNc5fucb0xbznIlwcISVQ2hYGEYPevuy3Q?=
 =?us-ascii?Q?VQfHM9B1NSI8Nl9p8oOSuobmBjnzSw67DADb49TQNDHbW9BTdiUS8LGq2DfK?=
 =?us-ascii?Q?69Y2E8aQyBWSQ5HyPRVmFy/ZdvGlYeeoli7tnFdlUQM+Z5loR4Sn8OVfLrRL?=
 =?us-ascii?Q?+7D9GmpE+380gdJ0CEEEG9l22OlflEdnTfsyfwtAo0J8D1agperZZSmQmlwG?=
 =?us-ascii?Q?zwRnXWpg7JgOvDVBSQoy//f7egfHmsc5T1/RKYaRVioFTONrHjLrpFzIskYO?=
 =?us-ascii?Q?2MG+owS8jgKvXc8UoTwqUuRbDq5v0yQKtC8/+y/jZpUfV2gJ/d7OJTpczz9v?=
 =?us-ascii?Q?urlV25xUetqC9xpMGTvLxYjKx+1h7PcwMdV0PrFoeAttwtis/nkgZ/LzCzIf?=
 =?us-ascii?Q?9n4vM2vcDQsO2LSkZufThmVElcR6CbDJNNzyfpJnfMO1DJ1uSf4hyWa0GjYw?=
 =?us-ascii?Q?RWknqYRcsnM2UtCVTco07aGOOJMaW5vUGEpcaKML76X2fCa5mkKyg6aMIAWP?=
 =?us-ascii?Q?Nx/3ZOsnkVV5/9pePVF8weUhsKALxXr4ydrBB/v+NRLQijOra0qDitHbMNot?=
 =?us-ascii?Q?+osnlkW8wgZiUJrWvEbBORScaiD24dt7/KBkydl3qtzlsyk6Ukkrok+r0Y3m?=
 =?us-ascii?Q?4n7zUC4HPRhCITiz2fMxl8g7qA8c1pa0VPJveyRWpeWxLmv9RP6ltlvbuTnS?=
 =?us-ascii?Q?DBq9wDCxkKNnJhFhtzkc+B6ZkkuGpNIjGKVR3RKafWOayiuMpg55UE/R3jGV?=
 =?us-ascii?Q?Lsf/oKRVdVWx9st5W05ifUQWOD0zIRf/pGrKn4EeLAhcO8WCtXU8eV/UpEa1?=
 =?us-ascii?Q?1GE81JFprpIMY6W1Ck/sHLi4dukPxfIJETaUtD2tLY2SuYoHGom2QSVjm/ZF?=
 =?us-ascii?Q?XXmiDKH5CA1yjukKvSi4PmRHSghINpOW9OxNvaoiAEemikVl32nA255ze+zO?=
 =?us-ascii?Q?Kv1zMXBs8VTpbScoGSsJMZ9cUmrhztclQK3TBC4OVLP2iFRw6YJjg5XNfx4f?=
 =?us-ascii?Q?CKCNAuYIxcgyVfswhMrLukx0LZ1NzjjF+w1mSOm6xraz/qb0HGbfuUXRJ+o2?=
 =?us-ascii?Q?YD+5nfCCqp7c3nhyz7Avl7kUR/gCYN7q1pQMDOmJzpgMkPR5VCFsjWroI0pK?=
 =?us-ascii?Q?2U2WcQacakEaRHRwullett+E1+T4Kcmz/hwDqNG1K0Ny7u6whpaia9uxBUR1?=
 =?us-ascii?Q?h5ls3fXxbKa6zZz6GIABgVcIUwqpuQ66GiqMSVw/GUY+AfYMozsoEYCiFEwC?=
 =?us-ascii?Q?Bv85/VLkBlNP2KSbYIwibSgmu6GYsTnGwzEoFm/nMxkqQzJEXx8zhWzHLPnP?=
 =?us-ascii?Q?RQoZxzekrtqtIkm5ArPXp7LmX9Gy/gXIGZGe469AN9ojUg3oMpRA7b11ZZtw?=
 =?us-ascii?Q?3w7YUMrcI49soKiZhR6Dniu9wCeS+Kqab3Q3iKqHv/oCPmfXj2vk2H1fmQbz?=
 =?us-ascii?Q?3SqolIu5wls9FFtAaIZxKZab9JeaNRWztcLYRP8upf++OSJzmgryCfGVWTq7?=
 =?us-ascii?Q?GBzqlfcMxbMo7TJj2JbcrudLaJn3cdw=3D?=
X-Exchange-RoutingPolicyChecked:
	M2gAjEV5Awd6XxO1uoBpM7+kkyyXu1IQOOtVWU82QuHzanwws3GYz5jSEnWg1NmmYVcJZIuB58QUuRc7qrH5syXOfnKkaERp1UgzqW/EOOI6GJUTsqXfrqNuwADgeaQ5SDyhUEARDwfz1XdHKTzbxCT30DbGVfF09CPN2d5bPCAsUuhVmyGfKdbEGHxQqquve0WSzQSUzCAbXywQVc8JsUqFDt6yy6AWgi5daIJACfyGONMRwsYN672ZzVomFb5NO0MgfWAJq2Bce3an7vsVEZGzi4DrnZ4RIE3nkaD73NEPJXN1PCngNPzHtXWSkmASAbEKPIVDL7f3kKQmqjB4hg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ca9bfb-f0d3-41f6-b4d0-08deeee95017
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6197.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 09:51:37.3918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhVnb+LIgj3nC5cLpG8MwqSjTC5yV2t1yCK4wmfYOE0kf3mX3W/7m2aye1DVzhm7ojGek5lz0fkaxs+xjHk+h15AkIMLMT6c/KR1lTm9mJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7842
X-Proofpoint-GUID: erOHfRzg0A1Mo5yIZgP5Myqcj57mevo5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3MyBTYWx0ZWRfX4+x+QkCn1Nof
 NhfXZZx4nVxfJysyIaKSRBCNojqcQ+y0XZC+BmiTm2nEEwMdmNOQ5eGLdIyfmFobWB+5nM81Ks4
 6oqilkGo3EvFOkMHKdwLhICdY+5MMnAKeexEcEglNJX/Ny3Uq8K5RKsn008dHGQ/5WTBXmQ6VPq
 ww92WyHfueegrteJ00DN+kF+c1L2Hgg/KCynAdLMn3wvqtc5Kd+7TnYN/gvVyvCiYNhHRs/ByFh
 Mv/xkhpRCx+xHsL8hObQyWVSGJE/Pj9f3tvYDqb1z2UsZ8PNSCLYxl1xe+vVXi36hNg5GXFwBMk
 8D/8fH9SbNN8A1ujCu+m2p5N62oBbZboc7sI4L2h7Zsfjc3zVJ7I093VlLB1rQNOpp9eM8YSuUk
 r071cVS59M3hzZhK6MU3HjUxc30tEsbgvQAx0hv1k61jhfv/kArSCtXrktzO4spWEb6HQmSFLsK
 t7W5GsZTuk6g7R7lJ9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3MyBTYWx0ZWRfX3I+O9XKiylCo
 If+iweuJGjRH3scmGg/n3XDiPL33IZVFjsZEFtbkP7mDIbV1T7t27jz4ZGS1eumU8YFzp1dhnuf
 8jMw85oFFUS9r0gUX+7GSZ6LEVFWOjo=
X-Proofpoint-ORIG-GUID: erOHfRzg0A1Mo5yIZgP5Myqcj57mevo5
X-Authority-Analysis: v=2.4 cv=DuhmPm/+ c=1 sm=1 tr=0 ts=6a6c702b cx=c_pps
 a=jcumTT0saVzx4HVuorHqQw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=P7j1cJWRIrBSRYB-Q1AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

This call allows a guest to ask the hypervisor which of its (guest
physical) memory ranges were already zeroed out by the hypervisor, which
means there's no need for the guest to zero them out again at boot.

To do so, we have to track what memory is not zero any more. The
conservative estimate for this is to consider all memory that we ever
touched to not be zero any more. To track this, we introduce a new
bitmap, independent of the existing dirty tracking maps.
This is for several reasons:
* Dirty memory tracking bitmaps are always allocated. This is wasteful
  when we only want this bitmap for one specific use case.
* Dirty memory tracking is tightly aligned with target page sizes. We
  want to track at a much coarser granularity, which reduces the bitmap
  size, and will also make our hypercall reply have fewer fragmented
  areas, without losing too much of the benefit.

Note that there are limitations of what we track: we only track initial
memory. Memory hotplugged later will not be tracked, and so never
reported as pre-zeroed. We also don't track non-zero memory over
migrations. Both of these are fine with respect to the use case: Windows
only enquires about zeroed memory relatively early during boot, where
both of these operations are uncommon. For those cases, we simply report
"memory is not pre-zeroed".

Finally, we can't track memory that the VM itself touched. For
this, we use a new KVM ioctl that tracks memory mapped in by the guest.
This enlightnement depends on its availability, and returns areas marked
as untouched by both QEMU and KVM.

NOTE: the KVM capability and ioctl numbers may change until the KVM side
is settled.

Signed-off-by: Florian Schmidt <flosch@nutanix.com>
---
 docs/system/i386/hyperv.rst      |   7 ++
 hw/hyperv/hyperv.c               | 178 ++++++++++++++++++++++++++++++-
 include/hw/hyperv/hyperv-proto.h |  11 ++
 include/hw/hyperv/hyperv.h       |   8 ++
 include/system/physmem.h         |   8 ++
 linux-headers/linux/kvm.h        |  15 +++
 system/memory.c                  |   7 +-
 system/physmem.c                 |  50 +++++++++
 target/i386/cpu.c                |   2 +
 target/i386/cpu.h                |   1 +
 target/i386/kvm/hyperv-proto.h   |   5 +
 target/i386/kvm/hyperv.c         |   8 ++
 target/i386/kvm/kvm.c            |  79 ++++++++++++++
 13 files changed, 375 insertions(+), 4 deletions(-)

diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
index a1985dc418..84b438ac8c 100644
--- a/docs/system/i386/hyperv.rst
+++ b/docs/system/i386/hyperv.rst
@@ -266,6 +266,13 @@ Existing enlightenments
   provide any useful new functionality, but it's required to be enabled to use
   any extended hypercalls.
 
+``hv-boot-zeroed-mem``
+  Enables the HvExtCallGetBootZeroedMemory hypercall. This allows a Windows
+  guest to inquire which memory has already been zeroed out by the host and
+  thus doesn't need to be zeroed out at boot again.
+
+  Requires: ``hv-ext-query-caps``
+
 Supplementary features
 ----------------------
 
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 3dcf23ba53..058c55eb4b 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -12,7 +12,10 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "system/address-spaces.h"
+#include "system/kvm.h"
 #include "system/memory.h"
+#include "system/physmem.h"
+#include "system/runstate.h"
 #include "exec/target_page.h"
 #include "exec/cpu-common.h"
 #include "linux/kvm.h"
@@ -24,10 +27,13 @@
 #include "qemu/queue.h"
 #include "qemu/rcu.h"
 #include "qemu/rcu_queue.h"
+#include "hw/core/boards.h"
 #include "hw/hyperv/hyperv.h"
 #include "qom/object.h"
 #include "target/i386/kvm/hyperv-proto.h"
 
+#define HV_BOOT_ZEROED_PAGE_SHIFT 9
+
 struct SynICState {
     DeviceState parent_obj;
 
@@ -714,7 +720,7 @@ uint16_t hyperv_ext_hcall_query_caps(uint64_t sup, uint64_t outgpa, bool fast)
     }
 
     len = sizeof(*supported);
-    supported = cpu_physical_memory_map(outgpa, &len, 1);
+    supported = physical_memory_map(outgpa, &len, 1);
     if (!supported || len < sizeof(*supported)) {
         ret = HV_STATUS_INSUFFICIENT_MEMORY;
         goto cleanup;
@@ -725,8 +731,151 @@ uint16_t hyperv_ext_hcall_query_caps(uint64_t sup, uint64_t outgpa, bool fast)
 
 cleanup:
     if (supported) {
-        cpu_physical_memory_unmap(supported, sizeof(*supported), 1, len);
+        physical_memory_unmap(supported, sizeof(*supported), 1, len);
+    }
+    return ret;
+}
+
+struct boot_zero_opaque {
+    struct hyperv_get_boot_zeroed_memory_output *zr;
+    const unsigned long *zero_blocks;
+    const unsigned long *kvm_bitmap;
+    unsigned long num;
+    unsigned int order;
+    unsigned int count;
+};
+
+static uint64_t boot_zeroed_max_gpa;
+
+void hyperv_boot_zeroed_set_max_gpa(uint64_t max_gpa)
+{
+    boot_zeroed_max_gpa = max_gpa;
+}
+
+static bool bootzero_mem_cb(Int128 istart, Int128 ilen, const MemoryRegion *mr,
+                            hwaddr offset_in_region, void *opaque)
+{
+    struct boot_zero_opaque *p = opaque;
+    uint64_t gpa_start, len;
+    ram_addr_t ram_start;
+    unsigned long ram_pfn_start, ram_pfn_end, gpa_ram_pfn_diff;
+    unsigned long gpa_bit_start, ram_bit_start, ram_bit_end, gpa_ram_bit_diff;
+    unsigned long idx, begin, pfn_start, pfn_end;
+    unsigned long full_shift = TARGET_PAGE_BITS + p->order;
+
+    if (!memory_region_is_ram(mr)
+        || memory_region_is_rom(mr)
+        || memory_region_is_ram_device(mr)
+        || (int128_get64(ilen) == 0)) {
+        return false;
+    }
+
+    /*
+     * We iterate concurrently over p->zero_blocks, which is a ram_addr_t,
+     * and p->kvm_bitmap, which is indexed by GPA. Hence the various
+     * conversion gymnastics.
+     */
+    gpa_start = int128_get64(istart);
+    ram_start = memory_region_get_ram_addr(mr) + offset_in_region;
+    len = int128_get64(ilen);
+
+    ram_pfn_start = ram_start >> TARGET_PAGE_BITS;
+    ram_pfn_end = (ram_start + len - 1) >> TARGET_PAGE_BITS;
+    gpa_ram_pfn_diff = (gpa_start - ram_start) >> TARGET_PAGE_BITS;
+
+    gpa_bit_start = gpa_start >> (full_shift);
+    ram_bit_start = ram_start >> (full_shift);
+    ram_bit_end = MIN(((ram_start + len - 1) >> full_shift) + 1, p->num);
+    gpa_ram_bit_diff = gpa_bit_start - ram_bit_start;
+
+    idx = ram_bit_start;
+    while (idx < ram_bit_end && p->count < ARRAY_SIZE(p->zr->ranges)) {
+        while (idx < ram_bit_end &&
+               (test_bit(idx, p->zero_blocks) ||
+                test_bit(idx + gpa_ram_bit_diff, p->kvm_bitmap))) {
+            idx++;
+        }
+        if (idx == ram_bit_end) {
+            break;
+        }
+        begin = idx;
+        while (idx < ram_bit_end &&
+               !test_bit(idx, p->zero_blocks) &&
+               !test_bit(idx + gpa_ram_bit_diff, p->kvm_bitmap)) {
+            idx++;
+        }
+        pfn_start = MAX(begin << p->order, ram_pfn_start);
+        pfn_end = MIN((idx << p->order) - 1, ram_pfn_end);
+
+        p->zr->ranges[p->count].start_pfn = pfn_start + gpa_ram_pfn_diff;
+        p->zr->ranges[p->count].page_count = pfn_end - pfn_start + 1;
+        p->count++;
+    }
+
+    return p->count == ARRAY_SIZE(p->zr->ranges);
+}
+
+uint16_t hyperv_ext_hcall_get_boot_zeroed_memory(uint64_t outgpa, bool fast)
+{
+    uint16_t ret;
+    hwaddr len;
+    struct boot_zero_opaque priv = { 0 };
+    struct kvm_ever_mapped_log kvm_log = { 0 };
+    hwaddr write_len = 0;
+
+    if (fast) {
+        ret = HV_STATUS_INVALID_HYPERCALL_CODE;
+        goto cleanup;
+    }
+
+    len = sizeof(*priv.zr);
+    priv.zr = physical_memory_map(outgpa, &len, 1);
+    if (!priv.zr || len < sizeof(*priv.zr)) {
+        ret = HV_STATUS_INSUFFICIENT_MEMORY;
+        goto cleanup;
+    }
+
+    priv.zero_blocks = physical_memory_get_mapped_ranges(&priv.num, &priv.order);
+    priv.num *= BITS_PER_LONG;
+
+    kvm_log.first_granule = 0;
+    kvm_log.granule_shift = priv.order + TARGET_PAGE_BITS;
+    kvm_log.num_granules = DIV_ROUND_UP(boot_zeroed_max_gpa,
+                                        1ULL << kvm_log.granule_shift);
+    kvm_log.bitmap = g_malloc0(DIV_ROUND_UP(kvm_log.num_granules, BITS_PER_BYTE));
+    priv.kvm_bitmap = kvm_log.bitmap;
+    if (kvm_vm_ioctl(kvm_state, KVM_GET_EVER_MAPPED_LOG, &kvm_log)) {
+        error_report("failed to get EVER_MAPPED_LOG from KVM, "
+                     "first granule: 0x%" PRIx64 ", num_granules 0x%" PRIx64 ", "
+                     "granule_shift: 0x%" PRIx32 ", error '%s'",
+                     (uint64_t)kvm_log.first_granule,
+                     (uint64_t)kvm_log.num_granules,
+                     (uint32_t)kvm_log.granule_shift, strerror(errno));
+        /*
+         * At this point, we haven't written anything to the return struct
+         * yet, so returning like this is the conservative way out.
+         * Though maybe we should use an error code here? But which one?
+         */
+        ret = HV_STATUS_SUCCESS;
+        goto cleanup;
+    }
+
+    priv.zr->range_count = 0;
+    if (priv.zero_blocks) {
+        RCU_READ_LOCK_GUARD();
+        flatview_for_each_range(address_space_to_flatview(&address_space_memory),
+                                bootzero_mem_cb, &priv);
+        priv.zr->range_count = priv.count;
     }
+    write_len = sizeof(priv.zr->range_count)
+                + priv.count * sizeof(priv.zr->ranges[0]);
+    ret = HV_STATUS_SUCCESS;
+
+cleanup:
+    if (priv.zr) {
+        physical_memory_unmap(priv.zr, len, 1, write_len);
+    }
+    g_free(kvm_log.bitmap);
     return ret;
 }
 
@@ -1013,6 +1162,31 @@ uint64_t hyperv_syndbg_query_options(void)
     return msg.u.query_options.options;
 }
 
+bool hyperv_boot_zeroed_setup(void)
+{
+    static bool initialized;
+
+    if (initialized) {
+        return false;
+    }
+
+    initialized = true;
+
+    if (runstate_check(RUN_STATE_INMIGRATE)) {
+        /*
+         * We do not track zeroed memory across migrations.
+         * The hypercall is only issued early during boot, so we don't lose
+         * much by not dealing with the complication of moving the zeroed
+         * state of guest memory to the migrated instance.
+         */
+        return false;
+    }
+
+    physical_memory_init_mapped_tracker(current_machine->ram_size >> TARGET_PAGE_BITS,
+                                        HV_BOOT_ZEROED_PAGE_SHIFT);
+    return true;
+}
+
 static bool vmbus_recommended_features_enabled;
 
 bool hyperv_are_vmbus_recommended_features_enabled(void)
diff --git a/include/hw/hyperv/hyperv-proto.h b/include/hw/hyperv/hyperv-proto.h
index f1d1d2eb26..5bf5684d11 100644
--- a/include/hw/hyperv/hyperv-proto.h
+++ b/include/hw/hyperv/hyperv-proto.h
@@ -36,6 +36,7 @@
 #define HV_RETRIEVE_DEBUG_DATA                0x006a
 #define HV_RESET_DEBUG_SESSION                0x006b
 #define HV_EXT_CALL_QUERY_CAPABILITIES        0x8001
+#define HV_EXT_CALL_GET_BOOT_ZEROED_MEMORY    0x8002
 #define HV_HYPERCALL_FAST                     (1u << 16)
 
 /*
@@ -192,4 +193,14 @@ struct hyperv_retrieve_debug_data_output {
     uint32_t retrieved_count;
     uint32_t remaining_count;
 } __attribute__ ((__packed__));
+
+struct hyperv_get_boot_zeroed_memory_range {
+    uint64_t start_pfn;
+    uint64_t page_count;
+} __attribute__ ((__packed__));
+
+struct hyperv_get_boot_zeroed_memory_output {
+    uint64_t range_count;
+    struct hyperv_get_boot_zeroed_memory_range ranges[255];
+} __attribute__ ((__packed__));
 #endif
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index e29d60f565..2ab3943a03 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -102,11 +102,19 @@ uint16_t hyperv_hcall_post_dbg_data(uint64_t ingpa, uint64_t outgpa, bool fast);
  */
 uint16_t hyperv_ext_hcall_query_caps(uint64_t sup, uint64_t outgpa, bool fast);
 
+/*
+ * Process HVCALL_EXT_GET_BOOT_ZEROED_MEMORY hypercall.
+ */
+uint16_t hyperv_ext_hcall_get_boot_zeroed_memory(uint64_t outgpa, bool fast);
+
 uint32_t hyperv_syndbg_send(uint64_t ingpa, uint32_t count);
 uint32_t hyperv_syndbg_recv(uint64_t ingpa, uint32_t count);
 void hyperv_syndbg_set_pending_page(uint64_t ingpa);
 uint64_t hyperv_syndbg_query_options(void);
 
+bool hyperv_boot_zeroed_setup(void);
+void hyperv_boot_zeroed_set_max_gpa(uint64_t max_gpa);
+
 typedef enum HvSynthDbgMsgType {
     HV_SYNDBG_MSG_CONNECTION_INFO,
     HV_SYNDBG_MSG_SEND,
diff --git a/include/system/physmem.h b/include/system/physmem.h
index c47b378025..924ae9f851 100644
--- a/include/system/physmem.h
+++ b/include/system/physmem.h
@@ -103,4 +103,12 @@ bool physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
                                         ram_addr_t length);
 int ram_block_rebind(Error **errp);
 
+void physical_memory_init_mapped_tracker(unsigned long num_pages,
+                                         unsigned int order);
+
+void physical_memory_set_mapped_range(ram_addr_t addr, ram_addr_t length);
+
+const unsigned long *physical_memory_get_mapped_ranges(unsigned long *len,
+                                                       unsigned int *order);
+
 #endif
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index dd52e2a65b..7836514594 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -986,6 +986,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_EVER_MAPPED 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1655,4 +1656,18 @@ struct kvm_pre_fault_memory {
 	__u64 padding[5];
 };
 
+#define KVM_GET_EVER_MAPPED_LOG  _IOW(KVMIO,  0xd6, struct kvm_ever_mapped_log)
+
+struct kvm_ever_mapped_log {
+	__u64 first_granule;
+	__u64 num_granules;
+	__u32 granule_shift;
+	__u32 flags;
+	union {
+		void *bitmap;
+		__u64 padding;
+	};
+	__u64 reserved[4];
+};
+
 #endif /* __LINUX_KVM_H */
diff --git a/system/memory.c b/system/memory.c
index 5fc36708ec..b0295f8bd9 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2173,9 +2173,12 @@ void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
 void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
                              hwaddr size)
 {
+    ram_addr_t ramaddr;
+
     assert(mr->ram_block);
-    physical_memory_set_dirty_range(memory_region_get_ram_addr(mr) + addr,
-                                        size,
+    ramaddr = memory_region_get_ram_addr(mr);
+    physical_memory_set_mapped_range(ramaddr + addr, size);
+    physical_memory_set_dirty_range(ramaddr + addr, size,
                                         memory_region_get_dirty_log_mask(mr));
 }
 
diff --git a/system/physmem.c b/system/physmem.c
index c21ea92915..76820a2e84 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -180,6 +180,54 @@ struct DirtyBitmapSnapshot {
     unsigned long dirty[];
 };
 
+/**
+ * @mapped_blocks: pointer to the bitmap itself, may be NULL if no tracking.
+ * @mapped_blocks_num: the length of the bitmap, in sizeof(*mapped_blocks)
+ * @mapped_blocks_order: the order, in pages, i.e., 0 = 1 bit per page.
+ */
+static unsigned long *mapped_blocks;
+static unsigned long mapped_blocks_num;
+static unsigned int mapped_blocks_order;
+
+void physical_memory_init_mapped_tracker(unsigned long num_pages,
+                                         unsigned int order)
+{
+    mapped_blocks_order = order;
+    mapped_blocks_num = DIV_ROUND_UP(DIV_ROUND_UP(num_pages, 1ULL << order),
+                                                  BITS_PER_LONG);
+    mapped_blocks = g_malloc0(sizeof(*mapped_blocks) * mapped_blocks_num);
+}
+
+void physical_memory_set_mapped_range(ram_addr_t addr, ram_addr_t length)
+{
+    unsigned long first_bit, last_bit;
+    unsigned long max_bits = mapped_blocks_num * BITS_PER_LONG;
+
+    if (mapped_blocks == NULL || length == 0) {
+        return;
+    }
+
+    /*
+     * Since we don't track hotplugged memory, we may get requests to
+     * (partially or fully) set a region we don't track.
+     */
+    first_bit = addr >> (TARGET_PAGE_BITS + mapped_blocks_order);
+    if (first_bit >= max_bits) {
+        return;
+    }
+    last_bit = MIN((addr + length - 1) >> (TARGET_PAGE_BITS + mapped_blocks_order),
+                   max_bits - 1);
+    bitmap_set_atomic(mapped_blocks, first_bit, last_bit - first_bit + 1);
+}
+
+const unsigned long *physical_memory_get_mapped_ranges(unsigned long *len,
+                                                       unsigned int *order)
+{
+    *len = mapped_blocks_num;
+    *order = mapped_blocks_order;
+    return mapped_blocks;
+}
+
 static void phys_map_node_reserve(PhysPageMap *map, unsigned nodes)
 {
     static unsigned alloc_hint = 16;
@@ -3129,6 +3177,8 @@ static void invalidate_and_set_dirty(MemoryRegion *mr, hwaddr addr,
     assert(ramaddr != RAM_ADDR_INVALID);
     addr += ramaddr;
 
+    physical_memory_set_mapped_range(addr, length);
+
     /* No early return if dirty_log_mask is or becomes 0, because
      * physical_memory_set_dirty_range will still call
      * xen_modified_memory.
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ed9773ac9e..29564a3394 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10770,6 +10770,8 @@ static const Property x86_cpu_properties[] = {
                       HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
     DEFINE_PROP_BIT64("hv-ext-query-caps", X86CPU, hyperv_features,
                       HYPERV_FEAT_EXT_CALLS, 0),
+    DEFINE_PROP_BIT64("hv-boot-zeroed-mem", X86CPU, hyperv_features,
+                      HYPERV_FEAT_BOOT_ZEROED_MEMORY, 0),
     DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
                             hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
 #ifdef CONFIG_SYNDBG
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6737340766..67d569ee4d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1481,6 +1481,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define HYPERV_FEAT_TLBFLUSH_EXT        19
 #define HYPERV_FEAT_TLBFLUSH_DIRECT     20
 #define HYPERV_FEAT_EXT_CALLS           21
+#define HYPERV_FEAT_BOOT_ZEROED_MEMORY  22
 
 #ifndef HYPERV_SPINLOCK_NEVER_NOTIFY
 #define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
index 4eb2955ac5..ec38b717e4 100644
--- a/target/i386/kvm/hyperv-proto.h
+++ b/target/i386/kvm/hyperv-proto.h
@@ -94,6 +94,11 @@
 #define HV_NESTED_DIRECT_FLUSH              (1u << 17)
 #define HV_NESTED_MSR_BITMAP                (1u << 19)
 
+/*
+ * HV_EXT_CALL_QUERY_CAPABILITIES bits
+ */
+#define HV_EXT_CAP_GET_BOOT_ZEROED_MEMORY   (1u << 0)
+
 /*
  * Basic virtualized MSRs
  */
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index 807acaf6b1..dc226b4419 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -123,6 +123,14 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
                 hyperv_ext_hcall_query_caps(hv_build_ext_call_caps(CPU(cpu)),
                                             out_param, fast);
             break;
+        case HV_EXT_CALL_GET_BOOT_ZEROED_MEMORY:
+            if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_BOOT_ZEROED_MEMORY)) {
+                exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
+            } else {
+                exit->u.hcall.result =
+                    hyperv_ext_hcall_get_boot_zeroed_memory(out_param, fast);
+            }
+            break;
         default:
             exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
         }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index bc1e44c33e..1b0e0bd61e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -965,6 +965,36 @@ static bool tsc_is_stable_and_known(CPUX86State *env)
         || env->user_tsc_khz;
 }
 
+static bool find_max_gpa_cb(Int128 istart, Int128 ilen, const MemoryRegion *mr,
+                            hwaddr offset_in_region, void *opaque)
+{
+    uint64_t *max = opaque;
+    uint64_t end;
+
+    if (!memory_region_is_ram(mr)
+        || memory_region_is_rom(mr)
+        || memory_region_is_ram_device(mr)
+        || (int128_get64(ilen) == 0)) {
+        return false;
+    }
+
+    end = int128_get64(istart) + int128_get64(ilen);
+    if (end > *max) {
+        *max = end;
+    }
+    return false;
+}
+
+static uint64_t find_max_gpa(void)
+{
+    uint64_t max = 0;
+
+    RCU_READ_LOCK_GUARD();
+    flatview_for_each_range(address_space_to_flatview(&address_space_memory),
+                            find_max_gpa_cb, &max);
+    return max;
+}
+
 #define DEFAULT_EVMCS_VERSION ((1 << 8) | 1)
 
 static struct {
@@ -1144,6 +1174,14 @@ static struct {
              .bits = HV_ENABLE_EXT_HYPERCALLS}
         }
     },
+    [HYPERV_FEAT_BOOT_ZEROED_MEMORY] = {
+        .desc = "enlighten guest about pre-zeroed memory (hv-boot-zeroed-mem)",
+        .flags = {
+            {.func = HV_EXT_CALL_QUERY_CAPABILITIES, .reg = 0,
+             .bits = HV_EXT_CAP_GET_BOOT_ZEROED_MEMORY}
+        },
+        .dependencies = BIT(HYPERV_FEAT_EXT_CALLS)
+    },
 };
 
 static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max,
@@ -1379,6 +1417,11 @@ static bool hyperv_feature_supported(CPUState *cs, int feature)
             continue;
         }
 
+        if (func == HV_EXT_CALL_QUERY_CAPABILITIES) {
+            /* These do not correspond to host CPUID feature bits. */
+            return true;
+        }
+
         if ((hv_cpuid_get_host(cs, func, reg) & bits) != bits) {
             return false;
         }
@@ -1710,6 +1753,20 @@ static bool evmcs_version_supported(uint16_t evmcs_version,
         (max_version <= max_supported_version);
 }
 
+static Notifier kvm_init_ever_mapped;
+
+static void kvm_enable_ever_mapped(Notifier *notifier, void *unused)
+{
+    uint64_t max_gpa = find_max_gpa();
+
+    if (kvm_vm_enable_cap(kvm_state, KVM_CAP_EVER_MAPPED, 0, max_gpa)) {
+        error_report("Failed to enable KVM_CAP_EVER_MAPPED, max GPA: 0x%lx, "
+                     "error '%s'", max_gpa, strerror(errno));
+        exit(1);
+    }
+    hyperv_boot_zeroed_set_max_gpa(max_gpa);
+}
+
 static int hyperv_init_vcpu(X86CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
@@ -1820,6 +1877,28 @@ static int hyperv_init_vcpu(X86CPU *cpu)
         hyperv_x86_set_vmbus_recommended_features_enabled();
     }
 
+    if (cs->cpu_index == 0 &&
+        hyperv_feat_enabled(cpu, HYPERV_FEAT_BOOT_ZEROED_MEMORY)) {
+        /*
+         * This is not per-CPU, so only run it for vCPU #0.
+         * We do it here instead of earlier during general setup, since we
+         * need to know CPU features for this.
+         */
+        if (kvm_check_extension(kvm_state, KVM_CAP_EVER_MAPPED) <= 0) {
+            error_report("Can't use hv-boot-zeroed-mem without KVM-side "
+                         "support for KVM_CAP_EVER_MAPPED.");
+            return -ENOTSUP;
+        }
+        if (hyperv_boot_zeroed_setup()) {
+            /*
+             * This part, we have to defer even further, until memory is
+             * set up, but (crucially!) vCPUs have not started yet.
+             */
+            kvm_init_ever_mapped.notify = kvm_enable_ever_mapped;
+            qemu_add_machine_init_done_notifier(&kvm_init_ever_mapped);
+        }
+    }
+
     return 0;
 }
 
-- 
2.47.3

