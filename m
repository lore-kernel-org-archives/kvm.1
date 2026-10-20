Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792519996;
	b=djj9hYwsG83u20xRpmGkyEKw8iuHB0+3RUFefMVcLauPj6pFDTLy1ufqFkgfbXdVwa9t
	 tc0xJp20OmGdQxB8sWEdvdyGHC8uYV4hdFDqPpEVqw9C/sr8omnoE+EjY2NWnWlVs+dWg
	 OOnlmh+MsuRA3iRkXB+LYpe1YL9D2fwMcY9Xti8YLxMi9zwskbHzKHhdf9iQcT7+gbuSF
	 hSf2BeEctE5Eo5kFSJcWZB/+FmKgnr9GfeXG8IrZ5biKH3/Aly6dhfHXoKKfg7iSCuUg/
	 rk1H+ly2BGNLAR0FrfLpOc+9zHBaRhsuHeL81Zz4jAEp3kBJf5p6jzMm8gLzHlBkNEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519996;
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
	bh=VaOvS2twVbKi3tyA3d7Wv4DfFe56GtGVq5wc4Ly0sBY=;
	b=UvagtkXHsHZIoLunaLohZePR0TVNAs6XGj97qXggfJh+ptnfqRDVJtw8vN9CNKYoNri1
	 19+vne5yMZm49g43snHfWVhYsw/8rz89AFXIcvbu2DzFPoDHRLCTmIbclBT4HOOIGEwH5
	 U8A9rhsJNSYPtKuy1AKG7OTLOfdUxWN3GYBI9aR9fLc9l1vjjxq8Joq4p542bKMKYnxox
	 S9YLJwJvDzLxnGqnlqGZCev+L4SJzq2Qg6inb7N0I/iyC1xECeqDKxFSXyMlyxuVtCs80
	 5+9YbWfWrQYgBezveC0bXUwhM1PJhGhTaXu1yEaqMzPcrKcIl4hso2UgZH8R+jDJMDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RZUOJATw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.28
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B655606A325
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 18:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B655606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RZUOJATw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anwk2XI8KCRwMXke72QihjJr6yPa4cG6hkkilP7xL06aNyiFoDgGXkoP61xKdyq2d5teC5GrDMVK68Va22uZ9Wmm2A9ocjOUFGpSKfkVg9+iq9RgexwPwonRRBnbb7sYbR0g/2LX8yiDkssuYLnmU877tRvyxX+9swscGpYorq/quBEjxrWrQYRZyNBho8Zv1DXVPAvaQOMAQXJkFPnQd7gXNGC0qbwoRV3laV6kQmmKg6PInwlxVrpPLdOz8Rcawr44iVdVESGChGQ35L5mPdUDu0Qnh4rJ6y/phuFBZ7udmg7y41w5OE4YzYZjwfpw0CqK8MhygtFNDgj8QEJWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaOvS2twVbKi3tyA3d7Wv4DfFe56GtGVq5wc4Ly0sBY=;
 b=mhw6UX3wasOmRnBGvwrnOdAKSZbQUWmY6t2KT54zKcVol4Un6TJOAbp+ZK0FgZEO9m1ssAsGqxMTCOLBCVCguqfau5/+OXtKza3ugTZyt1WyeM8vwW/F1Nu2/gefcrsCjz/dK/jQFBdIZLmxDhPM1vfh/vur5NDKx+dn3NtZa1a3eCSn4c+SJk+G3Taw50KL4YUrRiZ/ImHFjF36ZVWYOakdYcpSHUv5dKanMlA/VJKMxqawfBV2WyumrnZacnKXYydiViCHDVBnGFtGH8L2HTO0mLw5ZZ9xcohkuzyGqx7W/h7CkbSIfol39w8bhBz4Cz/tJeSlhqfuhw/pbwF+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaOvS2twVbKi3tyA3d7Wv4DfFe56GtGVq5wc4Ly0sBY=;
 b=RZUOJATwdUn+Z3qNPwnXPu5m8DeMFsjLP08xEk7zjIuo5fMJ1MN3DDJE4dNhNu1gWmc+TsRuMQxRoLLu0TZZ4cr5cCOO/nrFot8VBx48GHUPExmDrjx1fIAx5zghQLA6SYyx6Loi1zxuaxBKtuIRkZvPZx5tzY7XRS7G1GnaqiQ=
Received: from MN2PR01CA0040.prod.exchangelabs.com (2603:10b6:208:23f::9) by
 CY1PR12MB9625.namprd12.prod.outlook.com (2603:10b6:930:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 18:13:01 +0000
Received: from MN7PEPF0000014D.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::93) by MN2PR01CA0040.outlook.office365.com
 (2603:10b6:208:23f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 18:13:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN7PEPF0000014D.mail.protection.outlook.com (10.167.254.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 18:13:01 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 13:13:00 -0500
Date: Tue, 20 Oct 2026 13:12:45 -0500
From: Michael Roth <michael.roth@amd.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Kohei Enju
	<enju.kohei@fujitsu.com>, <gshan@redhat.com>, <berrange@redhat.com>,
	<kchamart@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<peter.maydell@linaro.org>, <mst@redhat.com>, <cohuck@redhat.com>,
	<pbonzini@redhat.com>, <eblake@redhat.com>, <armbru@redhat.com>,
	<lorenzo.pieralisi@linaro.org>, <qemu-devel@nongnu.org>,
	<qemu-arm@nongnu.org>, <kvm@vger.kernel.org>
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
Message-ID: <fgmu2cuxx2n2cuxqeotas2iu43jk7aou3hldhw4757x4jyv6np@snsceczzajcy>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
 <arI197vJkW75p50c@lpieralisi>
 <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain>
 <ataBkrIvULJXj4v6@p14s>
 <atdKSwvu_uldqwlz@red-moon>
 <atekhR1Wz03nUCHB@p14s>
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
In-Reply-To: <atekhR1Wz03nUCHB@p14s>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014D:EE_|CY1PR12MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: f643022a-732b-4a5a-0897-08df2ed5c712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|36860700016|7416014|376014|23010399003|82310400026|1800799024|4143699003|11063799006|56012099006|261009223027099003|261009221227099003|10067099003|22082099003|18002099003|6133799003|3023799007|27256017;
X-Microsoft-Antispam-Message-Info:
	JvGZXNbq25KKDzB0FeG5pNVpzccqY+v+0+RdWNuNQOyk36HKHQ+xHRE6z8Bs28GEJlhYpKgnoNCIKtgnw4mT441L3jcJqx07Q+ze60CX462+5kPnSMrR/6dn06GbhhdJo++6KNXeSBbPwiy7N6xzNnK+DvaMqUrpP10WD1yh4/m0i6b/C5Mu85HnLumWuTUydNn3fr3u3uWFjV+BiMg0uEp4qTvTGBmWildN5UFQx5qcnhzPOEE1l/mt+UMUXojPuAyfo9x+i9no2HnsexWAWvabEX5PAHn8TWLAS8L1o3zLtiUPwDVI2OQoV3efl711/NwBhhwRQaFFwI5OEaOJsJ9He92I7Cu/Imx5atNjkBQhH2j4S+dkSVIeRvRgOvUNc2IUhZEMGS/uD9iB5j8ZBc4bZOo+kCkqDcm2012hzJ++zm1wLuCZ85dNukZppaLZSJHovM+XhyQROsODvGRiyop2KeothUU2d3+5lVUiey3T7/yTxg+uGGJT56cqsBwrQmEvH8pfXfSdywzTA12qGSteQ9ROT6Hm3RbJDT5A+4I+5GR93/yJbNZtjdHUlpIIUj+MwU+wF3E8AXw8u5XTFJ01pjYYO5DtmLy6v26O2ny5KpGxt01RgLDgB0jr1mbpjzX8Ymq6kGZyY9vTo7AYYhCGMw7nhnHkPYxSwU8fBiXPoTk7FkF7GRFrJnmwjpn+z8nH23raWeMFzSVSEbZrXGocEVbkq6CtmEFew+nVikdvQ3Iic/AZsDS35b5Mh8s3
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(36860700016)(7416014)(376014)(23010399003)(82310400026)(1800799024)(4143699003)(11063799006)(56012099006)(261009223027099003)(261009221227099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XWtz9eycPLAEcsNGeyJlJwq31T6Ved/crOOoNBKwZsL3aWTkT826qK4YpsBBqlKsF1bXBIFB2ImkQiAZU+1jZEJmmz/Gybm/fdL2Am/uMxImaDtgc/Ez+j5zAlyPZDYXfFFmO8rePdNnTM4LGbW/wN+s7ww2Uf2En2oQLBFZ3MMjdhGZhccqVvPwK09CJ7dkyuD20ZgndO/IAGZV0cVCT0hmzaqM1MJj77yPcqp/gq0xlVg7C9la0ul/uXc/U8HFq8BTUC3+KNafTaUU6UI4XH9FtsdfuC1SdarmcwbiZs51xaQMriCnwtYJpyhmQHq/frm7yqThQZDwvGvypBQstyRV7NarSixDofAGqAowORMFSRuOnSo9bnbyAge2snDD+sumrTRA6UEuMmrom936FIqI5WDdwvVOljhG0vjZ84OAfJdKLMgFAm2q+M7G3KQr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 18:13:01.2205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f643022a-732b-4a5a-0897-08df2ed5c712
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN7PEPF0000014D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9625

On Tue, Oct 20, 2026 at 11:27:33AM -0600, Mathieu Poirier wrote:
> On Tue, Oct 20, 2026 at 01:02:35PM +0200, Lorenzo Pieralisi wrote:
> > On Mon, Oct 19, 2026 at 02:46:10PM -0600, Mathieu Poirier wrote:
> > > On Thu, Sep 24, 2026 at 12:12:35PM +0900, Kohei Enju wrote:
> > > > On 09/22 10:01, Lorenzo Pieralisi wrote:
> > > > > On Tue, Sep 15, 2026 at 04:27:21PM -0500, Michael Roth wrote:
> > > > > > On Thu, Sep 03, 2026 at 01:35:50PM -0600, Mathieu Poirier wrote:
> > > > > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > 
> > > > > > > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > > > > > > support the Arm Realm Management Extension (RME). It is instantiated by
> > > > > > > passing on the command-line:
> > > > > > > 
> > > > > > >   -M virt,confidential-guest-support=<id>
> > > > > > >   -object rme-guest,id=<id>
> > > > > > > 
> > > > > > > This is only the skeleton. Support will be added in following patches.
> > > > > > > 
> > > > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > > ---
> > > > > > >  docs/system/confidential-guest-support.rst |  1 +
> > > > > > >  qapi/qom.json                              | 13 +++++++
> > > > > > >  target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
> > > > > > >  target/arm/meson.build                     |  5 ++-
> > > > > > >  4 files changed, 60 insertions(+), 1 deletion(-)
> > > > > > >  create mode 100644 target/arm/kvm-rme.c
> > > > > > > 
> > > > > > > diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> > > > > > > index 562a7c3c2852..abb56923ad13 100644
> > > > > > > --- a/docs/system/confidential-guest-support.rst
> > > > > > > +++ b/docs/system/confidential-guest-support.rst
> > > > > > > @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
> > > > > > >  * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
> > > > > > >  * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> > > > > > >  * AWS Nitro Enclaves (see :doc:`nitro`)
> > > > > > > +* Arm Realm Management Extension (RME)
> > > > > > >  
> > > > > > >  Other mechanisms may be supported in future.
> > > > > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > > > > index 776b13027fd8..52997c29a32d 100644
> > > > > > > --- a/qapi/qom.json
> > > > > > > +++ b/qapi/qom.json
> > > > > > > @@ -1288,6 +1288,17 @@
> > > > > > >    'data': { '*pretty': 'bool',
> > > > > > >              '*close-action': 'MonitorQMPCloseAction' } }
> > > > > > >  
> > > > > > > +##
> > > > > > > +# @RmeGuestProperties:
> > > > > > > +#
> > > > > > > +# Properties for rme-guest objects.
> > > > > > > +#
> > > > > > > +# Since: 11.1
> > > > > > > +##
> > > > > > > +{ 'struct': 'RmeGuestProperties',
> > > > > > > +  'base': 'ConfidentialGuestSupportProperties',
> > > > > > 
> > > > > > Just FYI, based on input from Markus I'm planning to drop this
> > > > > > ConfidentialGuestSupportProperties base type from my series
> > > > > > since it's probably only SNP/TDX that need to be able to switch
> > > > > > it on/off, whereas this series appears to use/require it from
> > > > > > the start.
> > > > > > 
> > > > > > I'm not exactly sure what it will look like for v3 yet, but if you
> > > > > > were based on v2 you'd instead probably just do the following in the
> > > > > > instance_init function for your rme-guest instance:
> > > > > > 
> > > > > >   cgs->allow_convert_in_place = true;
> > > > > >   cgs->convert_in_place = true;
> > > > > > 
> > > > > > rather than exposing it as a cmdline option.
> > > > > 
> > > > > Yep, it won't be an option for CCA Realms anyway since that will be
> > > > > the baseline.
> > > > 
> > > > IIUC, in-place conversion requires RAM backed by a shared/mappable
> > > > guest_memfd. If in-place conversion is always enabled for CCA Realms,
> > > > could QEMU also select the equivalent of
> > > > 
> > > >   -object memory-backend-guest-memfd,id=ram0,size=...,share=on
> > > > 
> > > > automatically for the default RAM, so that specifying the RAM size with
> > > > `-m` is sufficient?
> > > 
> > > Are you suggesting that on Arm, we completely get rid of 
> > 
> > Nit: obviously on Arm rme-guest configs.
> 
> Indeed.
> 
> > 
> > >     -object memory-backend-guest-memfd,id=ram0,size=$(RAMSIZE),share=on
> > 
> > If that's what we want to make a default, I guess we ought to override
> > create_default_memdev for arm machines + rme-guest configs ?
> > 
> > Pros and cons ? I am not sure how well received is setting implicit defaults
> > for specific machine configs and what that really buys us eventually.
> 
> I agree, this entails a fair amount of changes for cosmetic gains only.

I think it will also add some uneccessary confusion. For instance, based
on Paolo's feedback[1], we will likely not expose any sort of option to
switch between in-place/out-of-place conversion for SNP/TDX, but instead
just use whatever mode the KVM module was actually configured to use.

For in-place conversion, it actually doesn't seem too bad to hook into
create_default_memdev to have it default to memory-backend-memfd.
However, currently, it used backend-file/backend-ram depending on other
options, and those options are applicable to out-of-place conversion as
well where e.g. maybe the user wants to use file-backed hugetlb memory
for their shared memory. So we wouldn't want to change the behavior for
out-of-place.

But then, for in-place, if we default to a different backend then stuff
like mem-path=... parameters for out-of-place invocations will then
become silently ignored, or we will need to generate an error for those,
which works against the idea of having a common cmdline that "just
works" for in-place/out-of-place.

If we (users, management/libvirt, etc.) consolidate around specifying the
memfd backend for confidential VMs, then we can have a "default" that is
more consistent between in-place vs. out-of-place, which i think is more
beneficial than trying to consolidate around a syntacticly simpler
cmdline that might not behave as expected when switching between
older/newer kernels which may or may not have in-place support.

So, a longwinded "I agree" from me as well.

Thanks,

Mike

> 
> > 
> > > or simply to get rid of "size=$(RAMSIZE)" in the above because it is redundant
> > > with "-m $(RAMSIZE)"?
> > > 
> > > Gavin and Michael, what is your take on that suggestion?
> > 
> > Yes please any feedback on this is welcome.
> > 
> > Thanks,
> > Lorenzo
> > 
> > > Thanks,
> > > Mathieu
> > > 
> > > > 
> > > > Thanks,
> > > > Kohei
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Lorenzo
> > > > > 
> > > > > > Thanks,
> > > > > > 
> > > > > > Mike
> > > > > > 
> > > > > > > +  'data': {} }
> > > > > > > +
> > > > > > >  ##
> > > > > > >  # @ObjectType:
> > > > > > >  #
> > > > > > > @@ -1346,6 +1357,7 @@
> > > > > > >      { 'name': 'pr-manager-helper',
> > > > > > >        'if': 'CONFIG_LINUX' },
> > > > > > >      'qtest',
> > > > > > > +    'rme-guest',
> > > > > > >      'rng-builtin',
> > > > > > >      'rng-egd',
> > > > > > >      { 'name': 'rng-random',
> > > > > > > @@ -1427,6 +1439,7 @@
> > > > > > >        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> > > > > > >                                        'if': 'CONFIG_LINUX' },
> > > > > > >        'qtest':                      'QtestProperties',
> > > > > > > +      'rme-guest':                  'RmeGuestProperties',
> > > > > > >        'rng-builtin':                'RngProperties',
> > > > > > >        'rng-egd':                    'RngEgdProperties',
> > > > > > >        'rng-random':                 { 'type': 'RngRandomProperties',
> > > > > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..42e1d1e7b859
> > > > > > > --- /dev/null
> > > > > > > +++ b/target/arm/kvm-rme.c
> > > > > > > @@ -0,0 +1,42 @@
> > > > > > > +/*
> > > > > > > + * QEMU Arm RME support
> > > > > > > + *
> > > > > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > > + *
> > > > > > > + * Copyright Linaro 2026
> > > > > > > + */
> > > > > > > +
> > > > > > > +#include "qemu/osdep.h"
> > > > > > > +
> > > > > > > +#include "hw/core/boards.h"
> > > > > > > +#include "hw/core/cpu.h"
> > > > > > > +#include "kvm_arm.h"
> > > > > > > +#include "migration/blocker.h"
> > > > > > > +#include "qapi/error.h"
> > > > > > > +#include "qom/object_interfaces.h"
> > > > > > > +#include "system/confidential-guest-support.h"
> > > > > > > +#include "system/kvm.h"
> > > > > > > +#include "system/runstate.h"
> > > > > > > +
> > > > > > > +#define TYPE_RME_GUEST "rme-guest"
> > > > > > > +OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > > > > > > +
> > > > > > > +struct RmeGuest {
> > > > > > > +    ConfidentialGuestSupport parent_obj;
> > > > > > > +};
> > > > > > > +
> > > > > > > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > > > > > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > > > > > > +                                          { TYPE_USER_CREATABLE }, { })
> > > > > > > +
> > > > > > > +static void rme_guest_class_init(ObjectClass *oc, const void *data)
> > > > > > > +{
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void rme_guest_init(Object *obj)
> > > > > > > +{
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void rme_guest_finalize(Object *obj)
> > > > > > > +{
> > > > > > > +}
> > > > > > > diff --git a/target/arm/meson.build b/target/arm/meson.build
> > > > > > > index 0369f96b4cc6..9d322a7aad28 100644
> > > > > > > --- a/target/arm/meson.build
> > > > > > > +++ b/target/arm/meson.build
> > > > > > > @@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
> > > > > > >  arm_common_system_ss.add(files(
> > > > > > >    'arm-qmp-cmds.c',
> > > > > > >  ))
> > > > > > > -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> > > > > > > +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> > > > > > > +  'hyp_gdbstub.c',
> > > > > > > +  'kvm.c',
> > > > > > > +  'kvm-rme.c'))
> > > > > > >  arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
> > > > > > >  
> > > > > > >  arm_user_ss.add(files('cpu.c'))
> > > > > > > -- 
> > > > > > > 2.43.0
> > > > > > > 
> > > > > > > 
