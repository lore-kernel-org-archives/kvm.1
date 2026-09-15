Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7426A4B270B
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789512692; cv=fail; b=k+Rb7gOaQhZRfnd4cDdef2EkGigTibanzYye9LI9yH47NP6b02F6lE5kKKh/AHKtOhOufVNXsS1OiMCs2m1Y6JQ5JY0yolgurUfIRMzol5vbuwctwutm1zhh1pBVDJJ1vJKOxtQ44QAmhg7TEktsWroEQ2eTLyAQuaBXV8WBcEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789512692; c=relaxed/simple;
	bh=W0gKTSDlTU7g0yGeeXNdzahtFLh1mFS+SuLhJgMbnqQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vaeq9Kf/FhVLHR6QRoHqSWvEG+dc/ENudMHSyPV7ydihLE1OKi33mjwXtOQcpzGDT1vmWipVtZQcrBcV1FXPMf0isobS+T/JKOeI7ENyW0ypce2zFCnxl3U45V/Rl4dwxnE8bFbU0j1vAV8Bbmg8yNhPhpnazi/f9wWcL/Ohlsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5jPF/Pny; arc=fail smtp.client-ip=40.107.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5jPF/Pny"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvUeq6ABLg3GrtOnJiexgyQ39Lc5t3N31C0f/2mTLzqvgwem0iSrrldz08UZJ3ySguv6q/aF/NSJkISH15OIjLEgreUyJun/H0D6AIXHE4ymnt6X6RzlQXMWtFp7CVMd4qAd2TspzLiw66nnHuDocrM468HnkUFswe0NuGIZjwAdxS5J2DhNCbTv3i3IFHN7yiXYT9BiKDXv8euo+PtSQEq5I/+UH6VPiJVcjUS8dgNPzrqBhWmZcn0YcPOd7HVUWc4UvPtawhzjRxy+TtFvYHlbRyk6WPft02sSqnCki74KBdEYg3omztw2p8b9lG4TV7RW0NVTXGCo+T1kooRqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkkhrwnE5NC7pRjS8dNbWVI1jJ83X6TAb8fzPmTRHoE=;
 b=F39krbLqGn3oFXXpH0VLneyvOFWvPax2KHvxY9XNCa5kzOQfDU1fWsIfvzizeyLzmNjdIrjDFt/CGUoaS7rt1oTVBK+mm7pnVxqDWjzSxZHyXmTRjv0ECeT8LZmUWbz33rs4f1iiF8xR+IyTPZ0ieRPAbx9409WWNPDPzNboOqaBKjLDjUXb1Mra8QiVzaQ8mNb8FZSkoXKeK6tALyZ7/ZF4PyaoEkhq2+wqGmxAI+pVsnLnor9damngCxi7ruBSOoyfrZbafaH/WPHBqmXki/U6q6XwV+5NJ6FyjRsJHKviPTVDcSZHkmM3veVDxGaEJ51LAckVsOsJAlrd5zdZdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkkhrwnE5NC7pRjS8dNbWVI1jJ83X6TAb8fzPmTRHoE=;
 b=5jPF/PnyjWyUJbqfVvXNDsjVHM7NJDJYBaMSeTkCZA94UrVdE6rvCgaQREX3UBjF4FmMJ8Y1cP82W5V/96pvKJLq09z4lbRxe7iWFSf/gYcHqU1UTCqF7p/DzVpK64QayZkr5FzAUgNlN72qyLh0t4KcZ4YA4EvVxvm1SoS3b9U=
Received: from DS7PR03CA0337.namprd03.prod.outlook.com (2603:10b6:8:55::25) by
 DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Tue, 15 Sep 2026 22:51:22 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:8:55:cafe::23) by DS7PR03CA0337.outlook.office365.com
 (2603:10b6:8:55::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 22:51:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Tue, 15 Sep 2026 22:51:21 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 17:51:21 -0500
Date: Tue, 15 Sep 2026 17:50:37 -0500
From: Michael Roth <michael.roth@amd.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <berrange@redhat.com>, <kchamart@redhat.com>,
	<pierrick.bouvier@oss.qualcomm.com>, <peter.maydell@linaro.org>,
	<mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
	<eblake@redhat.com>, <armbru@redhat.com>, <lorenzo.pieralisi@linaro.org>,
	<gshan@redhat.com>, <enju.kohei@fujitsu.com>, <qemu-devel@nongnu.org>,
	<qemu-arm@nongnu.org>, <kvm@vger.kernel.org>
Subject: Re: [RFC v4 10/24] target/arm/kvm-rme: Keep track of images loaded
 in Realm memory
Message-ID: <e3cpd54xpkgonmn4rziolhqvdkge5ke5mhi3cx57j3cfcc7qwd@eq7btw5en54c>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-11-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260903193611.1058589-11-mathieu.poirier@linaro.org>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 960d0389-ccea-419f-7b51-08df137bdce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|7416014|376014|10067099003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	0xN6+jJ1HYHfoH3ngtUiY3fe08cNtq7b7oZHPJ1v8O3OntnvcpXpVCuSVK3xZSIdv1H2Wl2Fe/YOlRrRF1SQyHU3Z4QU4/i15USk11CIoR6I5q6VfKbPtDZ9nXo4Utcd3U784L+RMHbgMK4CsXokEzqmXoAnLMfCtbmFwqFe3XKnITMqhdLovil6bYfybz5vIhIzyH0Zyro3UeW3up5uSkSnmT+hpX2QlSKavhteqeES/UCCu7UkbX7gwsuc77AyhCbFe6X5jA/IF+XKGHpPHSlZUwVCL9FsfD1HClHRIEazN8Sk+8+c5yHJAzlHOFiKfsG75cK0qr3aJHvEXOqJiX+c+w+piNmoNAUc6VN0qWxTfm5IBChh3vzJ+krohIccQuZBX/0wdo1sL4PJ1JDF1xGPk7NmmjRYexzO+fFkZZwvaaWj+oMjUHDTztyf7VGDPWk1QyEeEq7+XnSUNVmWbnzDdtfhuq5EfPraKJ2gUiJZ4VGnmMwzzAEMCRzSYBdPfwakzd3qRJ1f9Wu9I6RX9nUf/FvOMzb3jiPwJUHpsujzEB37nlf+xgNeeSFK3gvnZp/LepAFOlWZ6jVlUDQV6I36+3nFlZ/QgpVM9/JfZvo+ObhHOfmnFGJ7FbeFEylg1zUynRIvFvjkF5FTyPoBcEBw+M/Z+Ghg1HkmjMXEy3riyTqJUE/E90unDNAFkXmLo0FhPCPE+syFz7An0l6wBw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(7416014)(376014)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OyfNsspkV6GQi5tYYfk5lCUUwxWRqNXzOv4OoYZNCPXb+4BnzBN2z7TxFfBLZLCdVTnJeNC9WCjWzx15hYl/j1pHuuxvJy1EfIoj7yqBIkV1KbKIcfuyAEbWj6L/KPgQbm627BJje0FcbAoMWsGN8Qtvtv74T5scY6+h16RH2gPqqbcZJaqphLGiYi4N0tqOBrlT+v7Y9zKcp0wZ+sygN8reGgXxJCWVaIp5hUbVHzWoxbsJzEExkxt+z8b4FW/a00HN7HXE3M+2J6HDSQUI7GdkI0acYWIi9N1KoYGm+9O+jCtNXoyS0D3rhZTv65SeAJ7AE+gBvQuLBmsKmuuqvAT0GeO+WGwnx5BMaD61mLZO+yyC3qyb2kfLeRypiTo/OE0kNmMiK1XozyapaQpfx01gOgmvtvsvcPP7OWXScHKD09PYXW7kYmyIFlZOD3Pj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 22:51:21.7147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 960d0389-ccea-419f-7b51-08df137bdce1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622

On Thu, Sep 03, 2026 at 01:35:57PM -0600, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Add a Rom notifier to keep track of binary blobs loaded in Realm memory.
> That way we can deterministically calculate the Realm Initial Measurement (RIM).
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  target/arm/kvm-rme.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index f7c2cc786e2c..9985f5daba89 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -10,6 +10,7 @@
>  
>  #include "hw/core/boards.h"
>  #include "hw/core/cpu.h"
> +#include "hw/core/loader.h"
>  #include "kvm_arm.h"
>  #include "migration/blocker.h"
>  #include "qapi/error.h"
> @@ -22,8 +23,18 @@
>  #define TYPE_RME_GUEST "rme-guest"
>  OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
>  
> +#define RME_PAGE_SIZE qemu_real_host_page_size()
> +
> +typedef struct {
> +    hwaddr base;
> +    hwaddr size;
> +    uint8_t *data;
> +} RmeRamRegion;
> +
>  struct RmeGuest {
>      ConfidentialGuestSupport parent_obj;
> +    Notifier rom_load_notifier;
> +    GSList *ram_regions;
>  };
>  
>  OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> @@ -41,6 +52,44 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
>      kvm_mark_guest_state_protected();
>  }
>  
> +static gint rme_compare_ram_regions(gconstpointer a, gconstpointer b)
> +{
> +    const RmeRamRegion *ra = a;
> +    const RmeRamRegion *rb = b;
> +
> +    g_assert(ra->base != rb->base);
> +    return ra->base < rb->base ? -1 : 1;
> +}
> +
> +static void rme_rom_load_notify(Notifier *notifier, void *data)
> +{
> +    RmeRamRegion *region;
> +    RomLoaderNotifyData *rom = data;
> +
> +    if (rom->addr == -1) {

Are these entries also added via the rom_reset() path in the previous
patch? If so, wouldn't it be better to filter them out there?

Also, if that's where these entries are added, then it looks like we
might call address_space_flush_icache_range() with this -1 addr before
adding it to the notifier list. Is that expected?

-Mike

> +        /*
> +         * These blobs (ACPI tables) are not loaded into guest RAM at reset.
> +         * Instead the firmware will load them via fw_cfg and measure them
> +         * itself.
> +         */
> +        return;
> +    }
> +
> +    region = g_new0(RmeRamRegion, 1);
> +    region->base = rom->addr;
> +    region->size = rom->len;
> +    region->data = rom->data;
> +
> +    /*
> +     * The Realm Initial Measurement (RIM) depends on the order in which we
> +     * initialize and populate the RAM regions. To help a verifier
> +     * independently calculate the RIM, sort regions by GPA.
> +     */
> +    rme_guest->ram_regions = g_slist_insert_sorted(rme_guest->ram_regions,
> +                                                   region,
> +                                                   rme_compare_ram_regions);
> +}
> +
>  static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
>  {
>      KVMState *s = KVM_STATE(current_accel());
> @@ -58,6 +107,9 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
>      error_setg(&rme_mig_blocker, "RME: migration is not implemented");
>      migrate_add_blocker(&rme_mig_blocker, &error_fatal);
>  
> +    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
> +    rom_add_load_notifier(&rme_guest->rom_load_notifier);
> +
>      /*
>       * The realm activation is done last, when the VM starts, after all images
>       * have been loaded and all vcpus finalized.
> -- 
> 2.43.0
> 
> 
