Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791C228504D;
	Mon, 11 May 2026 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537812; cv=fail; b=VCsBHSPqwVKWPa2SrwBl+rLXdPVBZs0bHt37Tvg6s+iHsF5lqOo+w3XnAIKknaczKZzuqMRo7tWNRZonS3n6E+d/DYtThvpCS026FuBOiTnBFhvtBpLtAcGQimEC3mgA2kAA/vU0KZQPOP2RzdZNQRhkOTmCc9f7Y3ieg4sDp5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537812; c=relaxed/simple;
	bh=YaoN5iao6ZkwSXUvm6xmKhOWggMgo7xGWk6WLZ+Y6HI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Xe5q4ZPz6A8H+YhhWc6ZaWyMHADCZauEtnrsVQob7p8JUNtgKeRmXVbSqHHQpOtnufDHzEDJ08LLiCeXGypGzEy1tzm13gU/st4c0D0Fuja8pSta0vr2OofoUOPhsFE5seeoWH5+phCtAwTqQAqeaA8YLZw6QH9MbhUkYcUL9ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dt0lvDwo; arc=fail smtp.client-ip=52.101.62.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dt0lvDwo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAEE8xpIM0eMNZAYceXPMFlyCmCvv+U71Jw+1v34JmHMVuaxGuKggw59s8oVAIzyvRIxD9yjjmfWG++t5vsApF8wtMY1idf4k7saosu2asqr4U/RBaxKBIJ6E9+4EAQACUKKmeXVhaRQNAbYhex/pFFC08PiLDm0oOmbfWWrlXuhny5l5bQNFMoXEshsu+JZcsGOKaOuX2CNvGecMaGhmpqZ6smHKeT0FwoVqReXR2zNQLZrPxY2BjvolycfnJm0T8Yns1ZXQJCZqEan4XxiJv7WbwiufTmxf15rrbeSuzYIjKTsmA1jQpNad6Jj8u2ibQtk3A7buoNah9us6p2gYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwiJuPVJ/M/AA1pm4/WiIE07JUiSUSpBS3hagcgSu/U=;
 b=WDwNXfJDMz1qrcOi62KJrshRf4BLSGmuHq5dZJhRihWe6eTVozcTozt7NgJ7LlE/dh8+2+fU94KAhXpFosDtR1gemsHCcvR24+AqFFxff+7wW6S/DZTgYBbjuBqSFacBUR3VscGqYRDRtyKYpCASGA613sJX7CRH9NHBzdSOVc+LsEH5BAvRqtizwfniF36ZEF/tXQoH8WzBx4UDRXeKR1fzI6MKJ0pQhvvviKJrBzeKXU+tDuRcY2M/f7iCXrlqdPi9sdleLYjyFqdpPC4AdfKAxO+u3wkrfoFF7QfFZI4pOUKnQv2oOy+0EUqY0+oxVIbWYAyLZsRfJeBrNCiUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwiJuPVJ/M/AA1pm4/WiIE07JUiSUSpBS3hagcgSu/U=;
 b=Dt0lvDwog9SNITGpET1P5m+jEoYkB3xhTaUp3ZHpIYvEdDxNZOuNLizNiKfP31gn0ZB1MlIyG/XarEkMLYFIeboizLHH1Q9z7pV41NSrVlBOrm7dWztXiLbhz6YiWkf5Fatci7fimO+mtlPqnM6mZE61VmYz+AtYELqgAxMeEkgZMS7Fur33uRJHF3rlJuPEHU5BuJNnXWPCghth3lJbApoKvP8xWjLxq9Paeft4DrxjAmwp/YEoisr9alE1svv1180PUXXIWpMEljjZL9Zm654BIlI1ZC6d+OT0gFMY0feRBLh6/tnyo8EnApbQu+nYnCfqSbYFewPyMZVgcEyfiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 22:16:47 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 22:16:47 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	rananta@google.com
Subject: [PATCH v2 0/2] vfio: Fix racy bitfields and tighten struct layout
Date: Mon, 11 May 2026 16:16:01 -0600
Message-ID: <20260511221609.3837652-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:1ca::17) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 59327761-4f2c-466f-3876-08deafaafdf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5dJf0s4IjHJ5tqvS5DUoE1mURMAYYNLjVmqI1ZMtDdge+tx3+rooj0DRPla+/MrYTucECiCD88uAXkKDp6dEHFDKsZYQvFKOsRxbzXuRHQ2cX7sIRvuHZKcZngUyVJTfgpqG/xONsdhcbFF6BpeySrahIrfhOym12wkkudxFqKOsDWrZWBTu99t1sIXsPG3bN7DX0P4yPD/1V4WpCDdkat9AMZSZA4KjySG94px9ed1QAwMrYvuEBCMKHRDc5pZ7QkpqwEtkXokAJSEc0fZp0b8Jo1QzU2wtS2DoH33IdpR91g6na0K7Fi55AWJAxAkgFVjszxU50qHYbmfoxoJEVrOJiXZVdOjYD1ag2+Dvdgco7qV2Vq7ddmCjdEZUMvamLaSyZsO5rHR+wU1+iT03d2tjedpqahtdhSjxkH++4eXU6C7J0Sgt7i78d0z/7TP9OAOYlizTG7JdeDjeWkQCzHDErcyVwHCrSyb8bkMREKCECcjgGF98CjlJOsE6fXPiV9Y+v49YxDsozL6DBVjdbCwgQj7EOj9qKo+qmft/5cRsQ8kzW1ZTKNSTvqGKdb7H5mg4L1kjK0/gTDNmenquYWuDA5uFXFloW/nW8TD77lc5nK+eHnwELKrIb0qyoIYQu+GtOvWxjlTSufKNRWYPBM6o10v9tUYaEcnVED4x4NxuxSmt/EGy46o6qtFcrOSr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SaCJ34XnX9aT81ZJilZ7vQML8+fXrAe0cjxKLaYe+6EsxZC2soOgbRN17nHs?=
 =?us-ascii?Q?5senrPcnsvDeFkUorRkQNTCofThfrLMDDYrDDjr3y1PXfhZpY5Prd1McFly0?=
 =?us-ascii?Q?eegqqJn8CcEfDGr9P2K5GIJ6Hnqq7nOF0axe31klnoS2B+ZurFl79KSZe+Hy?=
 =?us-ascii?Q?OOQWm9bPpL/NhajzNG2NL+oMtVHvmvRkJGuke9TED4aLHHoImd9lrbHqw2Oj?=
 =?us-ascii?Q?TbHKoyYUisB60IkSlpFJRDkiAk2di15BDzuwRf4CfQaxYBfiDfCqk6QyLQUb?=
 =?us-ascii?Q?WHPzfHluhjJfgczw/xZSNLEnNcho6HnGCuj/oTb/csdSgEjDxEm+2poB3nMM?=
 =?us-ascii?Q?PvdA1aSf8T5LtuF1D9WD6utzSu1jobQ+XHTy6NlmN3YlAiuyGE1NerMzGtRB?=
 =?us-ascii?Q?tRlBB0bBjNtoP9/Qlis+PoiflkNhFnXmV9p1WEJNWy0hZ7pHxSNNLWiUJeD8?=
 =?us-ascii?Q?Nyn0k60+cM0O0S3C8mGAMx26FC4E//oTFaEDcnjF3D2yLzHT+R7RubcBiNQk?=
 =?us-ascii?Q?3IG6BuO1sBw63xnyIa0rUO+ZB+uEZexsU1QXgsv02aYAzIxh7pYhl9bhjjMW?=
 =?us-ascii?Q?Ad+0mut090zhmlftwZZrvX2QCV+/YuOwwQzKUt3fXu57mKROpo8jUDbsDlkZ?=
 =?us-ascii?Q?Jiv6YtNPnvi2ry2xSB8UvPbJdqCyMQ6p7xghfbBYCpNjm5qGh5EANT0trGNJ?=
 =?us-ascii?Q?XsvQQdEaRBb+mUndSjGVO473QKPqb829CHeyxMz3uNSmLk1wYFNR9YXw7YPZ?=
 =?us-ascii?Q?RT9xDgWP2A1ADxCuDFX8VF9Qr3FNFI1u4Jpri+fsz7cAT/DLF0R/ZljiKqBI?=
 =?us-ascii?Q?G3tEP8DbW22fUXUA/kUIQNysbTz2g+UlQw5FabkZe0xtG950lLS6MEUHVVIV?=
 =?us-ascii?Q?9T+tw1se2zui4dV5cD/ED2cVymsSOtShRmnC8wQVASrAKsi+9R20GXIvAErY?=
 =?us-ascii?Q?wLf2LJSqtklsJcB8LfNbVNaDMjEq6XFih9dyFARtWA8SNvrk1HyNjuMt7P0w?=
 =?us-ascii?Q?3U9+OTYpXzCsVXE6ykqclx0hT/sAq7yYZi8s3lV1s7Tdxg0oVSF+UsnVBiFa?=
 =?us-ascii?Q?VGg6go2urFxUu7oObM7LeNHhM58pwA5btSwhQmgBT4AHcCvR6cr4fBc+nWD9?=
 =?us-ascii?Q?nngPAh1erOfEMfbwJUe7bw6+V6+U00ogF4BU1WAXGAcFKj3/+DYjL37xeMRl?=
 =?us-ascii?Q?ZFDcNqVLYSZsp5HxFsJM1+RaHX1AAgAvzO2Ppk/Ln1JEHLddjkzHhaUG5nXK?=
 =?us-ascii?Q?jP0Qz1W6UFMuTlxdKQ2Zdrx9NYAWDV39Q0APxDnqCTxoM8YIPFAeUtITB+FU?=
 =?us-ascii?Q?iR1rs4SitvhlcS5QMeSKabWC8zjftd7AREZcvRPbR/zi0lpnGkmSY9R54Pz1?=
 =?us-ascii?Q?0tMgWF7nh+qR/Gjl130WWtFweFrbwcsASvgcJRy+1UiyVijKeYJz66F895B1?=
 =?us-ascii?Q?J6bg6btRsvuoI/QgWZJu1kDzwMiCbTn7f4geaNB4fFJH6On7g0dK3ZLCYzli?=
 =?us-ascii?Q?4441TlVOmtX8sbZRdP+7vK4LZTQSYVVyFWghId6DfPQ6IdQQAsJmDOiUrMuD?=
 =?us-ascii?Q?9Bq2C1I1BgzM0asUzdo3KSP1WDfZvs7+1Mc4m1XCqsPwT5zpF42bBe3X8mFc?=
 =?us-ascii?Q?0v1pmDIjlfIxxs/FUuNKWZt8mb8GP36+eZb42so0OzlyO4U+KZop6NJ/QZUK?=
 =?us-ascii?Q?blMN2fasaWyXHgjordDNZyjxd5jf7H9hPITACdgKiuMEHNsH5h3YvoYVC6IZ?=
 =?us-ascii?Q?yY3tQNUCOg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59327761-4f2c-466f-3876-08deafaafdf6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 22:16:47.5473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugMQQeXV63exXiBr3xmKeXuyH7Q3gzCgtCWbnkxzni53Eg+/i+4Wfk/WzJ5tfrkoytLkr4yRICCIF6cCfyHrYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321

A recent patch[1] proposed by Raghavendra triggered a Sashiko
review[2] flagging that the proposed new bitfield shares storage
with neighbors and that concurrent updates via RMW may clobber
adjacent fields.

Auditing bitfield users in vfio_pci_core_device finds several
pre-existing fields with the same hazard, and an analogous pattern
in mlx5_vhca_page_tracker / mlx5vf_pci_core_device.  This series
splits all such fields out of their shared storage words, resolving
the existing cases.

v2: Uncouple from Raghavendra's patch so that Sashiko can apply
    and review (new field dropped), we can handle merge on commit.

Thanks,
Alex

[1] https://lore.kernel.org/all/20260504224142.1041477-1-rananta@google.com/
[2] https://sashiko.dev/#/patchset/20260504224142.1041477-1-rananta@google.com

Alex Williamson (2):
  vfio/pci: Fix racy bitfields and tighten struct layout
  vfio/mlx5: Fix racy bitfields and tighten struct layout

 drivers/vfio/pci/mlx5/cmd.h   | 8 ++++----
 include/linux/vfio_pci_core.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.51.0

