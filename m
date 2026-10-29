Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793314937;
	b=uD9oa3uB57inzpfUkzt0jhSRR4Ca1BYBbGjPz9OVpLOgfrvYf+1ifUWeVgsw+xor3Wly
	 ESMixvT6Bg2uiQhCJiuw11fYRxjTbMC9JSWtklLnek8xQoke64AEWEX0mUAqhVMT40HPs
	 KhbtcLkRmtZwrsB1kKqQkzCqfnUp16gV1pkLQKCAjdcAHkfOMysd5k3XWMX9GcGC+Ewqo
	 ozLDXq9ZcZKJhLuce7Kgo9iEWrqE+kLAbrK0VWa6ni/GKfMM340TGSPAvGItjPWyAC4Kx
	 88odo310aNzQsjPGTIoYxLdAhi8n6+uRcCilM8Acze+8qkUt8ROAKsCk8TcBQakyAuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793314937;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GZrx6eul7qIXwBnSONA+s5/t8vkBMPjoBdp91I0wiAE=;
	b=gDczLcnkfnWpSf8awtzmrKfXrXZqp/06l8JExt4kIIrWtgFyQhDnc+zlbQcOmfa0jrqK
	 llfRIXFHjMcdIB4FvB5LTki+8QZ4yiW6wtKja8LVd3rzKVYDO45gMxu2X4W3zoQ3YTdkk
	 c1y3EIsPmPYY1v2tACc62Q1xW3D55ePprYNpVy2B3O6LgRlm3KlGO+jGGLyWAB9gO25by
	 +rkQhm76mmHyZGXy19elTbl+qvsLmd573dM0mmVBx7AXR0Kp/5+/04MNgv0bE/0Zbity+
	 R+CULqQv+mw/LWL66B7V6cVjryuXcXYUj+JNzWTqfNJ6ZZ/rmhQ+L3hDCq6yAGViMFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=w6Oyymua;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.67
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012067.outbound.protection.outlook.com [40.93.195.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C1606A31A
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 23:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F4C1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=w6Oyymua
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqY7sMtpjhngGT7E2hAwaX60YawTaTR5yWk9o3Ay3UG7e0ZK2/rBaeQGlM41lfwWxGUS6UM6Up5rLqMIgXhBAczt4Ie2Slh/HAk5dUbCKIdFshB5Gnb9QJiPdahTSM989I/2Aj8w1nkpUYK4fUpCTjcFMKl5ly/SZhjn1BVqQItZS0+YYgAii1ZTgllQQ1GzwsPeHh4AaQw4r52IX538a63IGvGs++/+SkiOZWY4yUfTNpWpF1O+zr7WqswwVg1s96pQulV9DdjMi8T1Yh9KmfUEk5uKi2vOqy3HDGArqCwRrDmYAH8sVNynhgd49eZwKfGiLEb83DrJ2LDt0EQBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZrx6eul7qIXwBnSONA+s5/t8vkBMPjoBdp91I0wiAE=;
 b=OPTwbizVVpxceZjRorHJO2rfzoP4aKaM/yL9Gyspxujhbg6VGg/x/IhqJoJCidGKU5PaVUG8xzKzN4NZB7l6oh/zDb65Z/nHw/uaCGS1YDMfrEeK0nItS3Q+YtADklcVj9FLFe5yYlJrCxDsUxa/x1dSwTGHuF1UOszSgNZb1dF0xM3YcKOl0gJt/Ac77nTKjSxpAlnp8xdRmPNFnNTWEgZ5D0cKJiTKkx+wkBYPiR3nSchkQhy205/n6E9TImZJTOtFIS7+4hurBVeHPCNbcg8egeRhnuxp1Fxvr8QHxuVgx1rfjZOcoudJCnlv2SYSvYT5t19gzNjRtgXiE0Rd3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZrx6eul7qIXwBnSONA+s5/t8vkBMPjoBdp91I0wiAE=;
 b=w6Oyymua/NTtAKAFpMHIY1CjMHcEmogO2wit6/Ia3FgyFGgqLyI37FAmzQmx53LUIW7UwN2n5uZtyFrIlJ8CfYiSNl3+Cj336/anJIYSRaJHpBUIV9Vcd18k6gXUX/pRCPsFcJY/1hlivlCCOjOI8AFR8q1EY9Y0A4eI1dAPHn4=
Received: from BY3PR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:39b::29)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 23:02:10 +0000
Received: from BY1PEPF0002696B.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::4d) by BY3PR05CA0054.outlook.office365.com
 (2603:10b6:a03:39b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.4 via Frontend Transport; Thu, 29
 Oct 2026 23:02:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002696B.mail.protection.outlook.com (10.167.244.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 23:02:10 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 18:02:10 -0500
Date: Thu, 29 Oct 2026 18:01:53 -0500
From: Michael Roth <michael.roth@amd.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Mathieu Poirier <mathieu.poirier@linaro.org>, Kohei Enju
	<enju.kohei@fujitsu.com>, <gshan@redhat.com>, <berrange@redhat.com>,
	<kchamart@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<peter.maydell@linaro.org>, <mst@redhat.com>, <cohuck@redhat.com>,
	<pbonzini@redhat.com>, <eblake@redhat.com>, <armbru@redhat.com>,
	<lorenzo.pieralisi@linaro.org>, <qemu-devel@nongnu.org>,
	<qemu-arm@nongnu.org>, <kvm@vger.kernel.org>
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
Message-ID: <x72wavbe4mfl4ccbusjpb424m4mribably2cko6rbhemea7xtc@t7xrxvyzv3zo>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
 <arI197vJkW75p50c@lpieralisi>
 <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain>
 <ataBkrIvULJXj4v6@p14s>
 <atdKSwvu_uldqwlz@red-moon>
 <atekhR1Wz03nUCHB@p14s>
 <fgmu2cuxx2n2cuxqeotas2iu43jk7aou3hldhw4757x4jyv6np@snsceczzajcy>
 <auC28TE3QWlU0Pcm@red-moon>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <auC28TE3QWlU0Pcm@red-moon>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002696B:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d50d64-2041-41f6-334a-08df3610a9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|7416014|376014|30052699003|82310400026|261026121527099003|11063799006|56012099006|4143699003|261009223027099003|261009221227099003|261022105027099003|10067099003|261022075727099003|261021121427099003|22082099003|18002099003|261021123027099003|6133799003|13003099007|261028144727099003|261026140227099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	JFyvZotOi8wRJDp6BHrt2F6Ml2anub+8Y63rBVyaZFQdMBlVT29afo/WB0/KOXKtTDfxw2u06ea3KntowQQylz1gUhXcwGEXE0w/dEmSu+heEP7CQgdAb6ihwoXso1u+w1a9bBLqfgkSrmSZ2N+fIgI8vqKXn4Gw77/Wk//YIpHEroR9Nqp3k8K+LxOwn8Z+47xWJfKBZnkWnI6uahY+XoBmmqInbWgeRQ90MFdO6HeRBRSaWnLpJsFWa65AiKXT0PIn8W2AOqZ4QW91RFBJBau5eApBNZP/0Kvh+EcxVxpj/P0pe/zmNwMKjol/DogUqmKqAxrptgaSZRYIK44FgWrWwk2VdMyuiR8KjNN5Hjg1/Z9+uJfGKxy9vMdszMMw9S9wDd8S2tgdgbbbib54vIXXrpH4G6MFqhGwu+Oiv36XSd/nqg8eLFislJY+AYNVxL5A/r37Jw4h9Pv0r48cVOrD8bdMPSfpz/7foTPFFiNWfS/37ear6ebmG2p6LCsO1FeXLlivG++gxQUejiI6mTi9CyZHLi74kgFLtK06VTvpY1iQvk0BNogJyFR/lwjlRIG5JgHod9B/rwOPZOMVbMNUED2csO6oirR0CYLhhoA+WB0u0ckEdOMLHh53p8Pq2ca4lCxP/nPSzGO6SPfVLvvsVsAu8oAhIJA5rjf8cOI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(7416014)(376014)(30052699003)(82310400026)(261026121527099003)(11063799006)(56012099006)(4143699003)(261009223027099003)(261009221227099003)(261022105027099003)(10067099003)(261022075727099003)(261021121427099003)(22082099003)(18002099003)(261021123027099003)(6133799003)(13003099007)(261028144727099003)(261026140227099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X25j8xGrkAm/RvmaTgWHct3i+1BJBkKUni4ySPRbbWXLEbkuDs0CqoVkSWU45s7tPA4R1S4ZbIBLuuof1EbotM1zt0x7Erfna94Dea9Xqsz+ZpeEV4Ebv97DCXBPcHYaRBe8WwocB0Kygi2XF/5s87rzlR2d1ccw9PoHUiUXKdqVeU7GcNZIHubrwXi4Yyr6ryJxyi4Mv7LEY4wehpXZTk7ODAMN5XwA3P2vQDwgoPXavtm6uHmSecAI5xHgsJFw/OcJCKkeyAi1slnNLQbrQREB0cwTi2lsY5xCFwnCGoy1YuC6ewilSX7KLGXjgaoGD2NTbj+2AViDZVLgm0/wlIWdDkeLxqKUpGyOKXmmY+cyK5dpV6mgL64Cxkoglgm01usN/r/UKslX8xMh2MiZyvkZ9W/S+2XCHhP2jbmSt0cI6HdZ2p4Zkuy/+IpOWJbm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 23:02:10.6354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d50d64-2041-41f6-334a-08df3610a9e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0002696B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977

On Tue, Oct 27, 2026 at 03:36:33PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Oct 20, 2026 at 01:12:45PM -0500, Michael Roth wrote:
> > On Tue, Oct 20, 2026 at 11:27:33AM -0600, Mathieu Poirier wrote:
> > > On Tue, Oct 20, 2026 at 01:02:35PM +0200, Lorenzo Pieralisi wrote:
> > > > On Mon, Oct 19, 2026 at 02:46:10PM -0600, Mathieu Poirier wrote:
> > > > > On Thu, Sep 24, 2026 at 12:12:35PM +0900, Kohei Enju wrote:
> > > > > > On 09/22 10:01, Lorenzo Pieralisi wrote:
> > > > > > > On Tue, Sep 15, 2026 at 04:27:21PM -0500, Michael Roth wrote:
> > > > > > > > On Thu, Sep 03, 2026 at 01:35:50PM -0600, Mathieu Poirier wrote:
> > > > > > > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > > > 
> > > > > > > > > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > > > > > > > > support the Arm Realm Management Extension (RME). It is instantiated by
> > > > > > > > > passing on the command-line:
> > > > > > > > > 
> > > > > > > > >   -M virt,confidential-guest-support=<id>
> > > > > > > > >   -object rme-guest,id=<id>
> > > > > > > > > 
> > > > > > > > > This is only the skeleton. Support will be added in following patches.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > > > > ---
> > > > > > > > >  docs/system/confidential-guest-support.rst |  1 +
> > > > > > > > >  qapi/qom.json                              | 13 +++++++
> > > > > > > > >  target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
> > > > > > > > >  target/arm/meson.build                     |  5 ++-
> > > > > > > > >  4 files changed, 60 insertions(+), 1 deletion(-)
> > > > > > > > >  create mode 100644 target/arm/kvm-rme.c
> > > > > > > > > 
> > > > > > > > > diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> > > > > > > > > index 562a7c3c2852..abb56923ad13 100644
> > > > > > > > > --- a/docs/system/confidential-guest-support.rst
> > > > > > > > > +++ b/docs/system/confidential-guest-support.rst
> > > > > > > > > @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
> > > > > > > > >  * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
> > > > > > > > >  * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> > > > > > > > >  * AWS Nitro Enclaves (see :doc:`nitro`)
> > > > > > > > > +* Arm Realm Management Extension (RME)
> > > > > > > > >  
> > > > > > > > >  Other mechanisms may be supported in future.
> > > > > > > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > > > > > > index 776b13027fd8..52997c29a32d 100644
> > > > > > > > > --- a/qapi/qom.json
> > > > > > > > > +++ b/qapi/qom.json
> > > > > > > > > @@ -1288,6 +1288,17 @@
> > > > > > > > >    'data': { '*pretty': 'bool',
> > > > > > > > >              '*close-action': 'MonitorQMPCloseAction' } }
> > > > > > > > >  
> > > > > > > > > +##
> > > > > > > > > +# @RmeGuestProperties:
> > > > > > > > > +#
> > > > > > > > > +# Properties for rme-guest objects.
> > > > > > > > > +#
> > > > > > > > > +# Since: 11.1
> > > > > > > > > +##
> > > > > > > > > +{ 'struct': 'RmeGuestProperties',
> > > > > > > > > +  'base': 'ConfidentialGuestSupportProperties',
> > > > > > > > 
> > > > > > > > Just FYI, based on input from Markus I'm planning to drop this
> > > > > > > > ConfidentialGuestSupportProperties base type from my series
> > > > > > > > since it's probably only SNP/TDX that need to be able to switch
> > > > > > > > it on/off, whereas this series appears to use/require it from
> > > > > > > > the start.
> > > > > > > > 
> > > > > > > > I'm not exactly sure what it will look like for v3 yet, but if you
> > > > > > > > were based on v2 you'd instead probably just do the following in the
> > > > > > > > instance_init function for your rme-guest instance:
> > > > > > > > 
> > > > > > > >   cgs->allow_convert_in_place = true;
> > > > > > > >   cgs->convert_in_place = true;
> > > > > > > > 
> > > > > > > > rather than exposing it as a cmdline option.
> > > > > > > 
> > > > > > > Yep, it won't be an option for CCA Realms anyway since that will be
> > > > > > > the baseline.
> > > > > > 
> > > > > > IIUC, in-place conversion requires RAM backed by a shared/mappable
> > > > > > guest_memfd. If in-place conversion is always enabled for CCA Realms,
> > > > > > could QEMU also select the equivalent of
> > > > > > 
> > > > > >   -object memory-backend-guest-memfd,id=ram0,size=...,share=on
> > > > > > 
> > > > > > automatically for the default RAM, so that specifying the RAM size with
> > > > > > `-m` is sufficient?
> > > > > 
> > > > > Are you suggesting that on Arm, we completely get rid of 
> > > > 
> > > > Nit: obviously on Arm rme-guest configs.
> > > 
> > > Indeed.
> > > 
> > > > 
> > > > >     -object memory-backend-guest-memfd,id=ram0,size=$(RAMSIZE),share=on
> > > > 
> > > > If that's what we want to make a default, I guess we ought to override
> > > > create_default_memdev for arm machines + rme-guest configs ?
> > > > 
> > > > Pros and cons ? I am not sure how well received is setting implicit defaults
> > > > for specific machine configs and what that really buys us eventually.
> > > 
> > > I agree, this entails a fair amount of changes for cosmetic gains only.
> > 
> > I think it will also add some uneccessary confusion. For instance, based
> > on Paolo's feedback[1], we will likely not expose any sort of option to
> 
> I think that [1] is:
> 
> https://lore.kernel.org/kvm/866179b6-8303-4c30-aa59-005fa4554362@redhat.com
> 
> for completeness.

Yes, sorry, I should know better by now that adding citations before
adding the links is a bad idea.

> 
> > switch between in-place/out-of-place conversion for SNP/TDX, but instead
> > just use whatever mode the KVM module was actually configured to use.
> > 
> > For in-place conversion, it actually doesn't seem too bad to hook into
> > create_default_memdev to have it default to memory-backend-memfd.
> > However, currently, it used backend-file/backend-ram depending on other
> 
> "it used" - can I ask what "it" refers to please ?

"it used" -> "QEMU uses" is what I meant.

> 
> > options, and those options are applicable to out-of-place conversion as
> > well where e.g. maybe the user wants to use file-backed hugetlb memory
> > for their shared memory. So we wouldn't want to change the behavior for
> > out-of-place.
> 
> So, here you are saying that basically a sensible default for out-of-place
> might not work for convert-in-place and therefore it does not make much
> sense to have a default that does/doesn't work depending on how KVM is
> configured.
> 
> > But then, for in-place, if we default to a different backend then stuff
> > like mem-path=... parameters for out-of-place invocations will then
> > become silently ignored, or we will need to generate an error for those,
> > which works against the idea of having a common cmdline that "just
> > works" for in-place/out-of-place.
> 
> Yes that makes sense.
> 
> > If we (users, management/libvirt, etc.) consolidate around specifying the
> > memfd backend for confidential VMs, then we can have a "default" that is
> > more consistent between in-place vs. out-of-place, which i think is more
> > beneficial than trying to consolidate around a syntacticly simpler
> > cmdline that might not behave as expected when switching between
> > older/newer kernels which may or may not have in-place support.
> 
> Can you elaborate on this Michael please ? In particular in relation to a more
> consistent "default" for in-place/out-of-place, are you referring to defining
> a -object memfd option that works for both in-place and out-of-place ? Isn't
> that the case already with your latest v3 (and the VMM detecting the KVM
> underlying config ie in-place vs out-of-place) ?

To clarify, what I mean is that if we all CoCo platforms use a similar
command-line like:

  qemu-system-<arch> -object memory-backend-memfd,...

then that would be consistent not only across all CoCo platforms (for
currently implementations anyway...) that support only in-place
conversion, but it would also be consistent across CoCo platforms that
support both in-place/out-of-place (SNP/TDX). There seems to be a desire
for the latter based on Paolo's comments (thanks for fixing the
references).

If however we introduce some syntactic sugar to have it handled
automatically by -m / create_default_memdev(), then any users who
previously ran SNP/TDX for out-of-place conversion with something like:

  qemu-system-x86_64 -m <size> -machine ...,mem-path=/path/to/hugetlb
  
would break/misbehave if we enabled in-place conversion. And that's okay,
but it makes clear that using -m comes with a number of restrictions in
the case of in-place-conversion (e.g. mem-path not supported), that aren't
restrictions for out-of-place-conversion, and that can cause some
confusion if we don't document it appropriately.

I don't have any strong objection to that, but it's just trickier to
document/explain, whereas if we all just generally agree to use:

  qemu-system-<arch> -object memory-backend-memfd,...

a lot of this ambiguity goes away. So I prefer specifying the backend
explicitly, especially since guest-memfd is a well-understood commonality
for CoCo VMs and we can concentrate our documentation and how we expose
that to management/libvirt through this same backend.

That said, there's no reason we can't also have -m "Do the right thing"
for in-place conversion, I just don't think we should lean on that too
heavily in our documentation/management tooling, and keep it as more of
a 'shortcut' for non-production use-cases if we decide it's worth
adding.

Thanks,

Mike

> 
> > So, a longwinded "I agree" from me as well.
> > 
> > Thanks,
> > 
> > Mike
> 
> Thanks,
> Lorenzo
> 
> > > 
> > > > 
> > > > > or simply to get rid of "size=$(RAMSIZE)" in the above because it is redundant
> > > > > with "-m $(RAMSIZE)"?
> > > > > 
> > > > > Gavin and Michael, what is your take on that suggestion?
> > > > 
> > > > Yes please any feedback on this is welcome.
> > > > 
> > > > Thanks,
> > > > Lorenzo
> > > > 
> > > > > Thanks,
> > > > > Mathieu
> > > > > 
> > > > > > 
> > > > > > Thanks,
> > > > > > Kohei
> > > > > > 
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Lorenzo
> > > > > > > 
> > > > > > > > Thanks,
> > > > > > > > 
> > > > > > > > Mike
> > > > > > > > 
> > > > > > > > > +  'data': {} }
> > > > > > > > > +
> > > > > > > > >  ##
> > > > > > > > >  # @ObjectType:
> > > > > > > > >  #
> > > > > > > > > @@ -1346,6 +1357,7 @@
> > > > > > > > >      { 'name': 'pr-manager-helper',
> > > > > > > > >        'if': 'CONFIG_LINUX' },
> > > > > > > > >      'qtest',
> > > > > > > > > +    'rme-guest',
> > > > > > > > >      'rng-builtin',
> > > > > > > > >      'rng-egd',
> > > > > > > > >      { 'name': 'rng-random',
> > > > > > > > > @@ -1427,6 +1439,7 @@
> > > > > > > > >        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> > > > > > > > >                                        'if': 'CONFIG_LINUX' },
> > > > > > > > >        'qtest':                      'QtestProperties',
> > > > > > > > > +      'rme-guest':                  'RmeGuestProperties',
> > > > > > > > >        'rng-builtin':                'RngProperties',
> > > > > > > > >        'rng-egd':                    'RngEgdProperties',
> > > > > > > > >        'rng-random':                 { 'type': 'RngRandomProperties',
> > > > > > > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > > > > > > new file mode 100644
> > > > > > > > > index 000000000000..42e1d1e7b859
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/target/arm/kvm-rme.c
> > > > > > > > > @@ -0,0 +1,42 @@
> > > > > > > > > +/*
> > > > > > > > > + * QEMU Arm RME support
> > > > > > > > > + *
> > > > > > > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > > > > + *
> > > > > > > > > + * Copyright Linaro 2026
> > > > > > > > > + */
> > > > > > > > > +
> > > > > > > > > +#include "qemu/osdep.h"
> > > > > > > > > +
> > > > > > > > > +#include "hw/core/boards.h"
> > > > > > > > > +#include "hw/core/cpu.h"
> > > > > > > > > +#include "kvm_arm.h"
> > > > > > > > > +#include "migration/blocker.h"
> > > > > > > > > +#include "qapi/error.h"
> > > > > > > > > +#include "qom/object_interfaces.h"
> > > > > > > > > +#include "system/confidential-guest-support.h"
> > > > > > > > > +#include "system/kvm.h"
> > > > > > > > > +#include "system/runstate.h"
> > > > > > > > > +
> > > > > > > > > +#define TYPE_RME_GUEST "rme-guest"
> > > > > > > > > +OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > > > > > > > > +
> > > > > > > > > +struct RmeGuest {
> > > > > > > > > +    ConfidentialGuestSupport parent_obj;
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > > > > > > > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > > > > > > > > +                                          { TYPE_USER_CREATABLE }, { })
> > > > > > > > > +
> > > > > > > > > +static void rme_guest_class_init(ObjectClass *oc, const void *data)
> > > > > > > > > +{
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static void rme_guest_init(Object *obj)
> > > > > > > > > +{
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static void rme_guest_finalize(Object *obj)
> > > > > > > > > +{
> > > > > > > > > +}
> > > > > > > > > diff --git a/target/arm/meson.build b/target/arm/meson.build
> > > > > > > > > index 0369f96b4cc6..9d322a7aad28 100644
> > > > > > > > > --- a/target/arm/meson.build
> > > > > > > > > +++ b/target/arm/meson.build
> > > > > > > > > @@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
> > > > > > > > >  arm_common_system_ss.add(files(
> > > > > > > > >    'arm-qmp-cmds.c',
> > > > > > > > >  ))
> > > > > > > > > -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> > > > > > > > > +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> > > > > > > > > +  'hyp_gdbstub.c',
> > > > > > > > > +  'kvm.c',
> > > > > > > > > +  'kvm-rme.c'))
> > > > > > > > >  arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
> > > > > > > > >  
> > > > > > > > >  arm_user_ss.add(files('cpu.c'))
> > > > > > > > > -- 
> > > > > > > > > 2.43.0
> > > > > > > > > 
> > > > > > > > > 
