Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A621B352022;
	Tue, 15 Sep 2026 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459741; cv=fail; b=u3FVIKL7/hPN0Rd6IHP+/fqPVxIT7J0a8SKYZ8NI5MXqOr9L4eTZkxdiwTCFZLGxagMmuMpcx5XitY2/iBJFf4ugB3Kv7xSmaPh0iISabpLEibO6KVEK4HVmQKolH3r2kpipGtcaGZkP+t2rtRKE/Cv7/dnoAdz/WIWIGDAs9to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459741; c=relaxed/simple;
	bh=+GHNE8KGySNueGcn4ejPc3de+Cvn72kdINTlkwQDqK0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mXa8+hHv1pcIo9JkPZ3N1qoc57NGGYI8qRXzjMqN+4EB9ogw3A1eThhdBnkNgK22k3A26I/wLigeIFsMYBFjMcdPxD8cbVyDX6zimn5osiO5lKmlB1vnL6OO7xdrJrx4QDb2PCW4ckkAjJ12uMIogDLqqqzGkCVlFNVhekmSWZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=48Ikfnlv; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="48Ikfnlv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YB2oukKdcmWm+gJfgMhcqjH/Y1ySisp05rfB9zCcaQ+xb/+QVdLWHyDJs+Rn9ZbivdZ/E7OSldvDurGD3UhyuzcAj9FBgLV4B1LZr14Oqa89Vg6jN0ohPKmUBmSrwKY6xM1wEQmIZPwPWMp5Kv0PO3equpBmUnvc/jZ/A1OdgLKwYziVRQWrhbI3UTSFtw2Aj7RByVK33ljrNQKhfFkzFMRUbcWLG3yHQxKjkWrjqw1tyiS9q0WND0N+EK5lg1PLPcLPfbAv/gkK3r+zNcqAImdqzhhqW+W5dJ2Ibwm46zAEJYSnYsw3AeUf9NkDsdWE8C6sE82rfOztIyN3B5dkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erO90DAZx/FQpDKp2w6qza/sj84B3T5g4TkV8LUOJDM=;
 b=LV40UvJK5PlIUXleZOMocwJOoRKcieOImhCvyIa2T9oJ0+pSivpz+A/J9SNTxbPOMMJNC6HiDkMdvC7LWBFBSPm+ln3Uek1BA8JBzTkZ4Yb5/WxXu0QxiNbDDwbec2W9OexKJvNJzwhlFQiEcjmjLsjGDymQV5j0LgwrUCsqhVL4EnAktphRzIXdMgqKd3s8GBWpO9Q+E/ygKPuggmqPmFqhsW/QSaU2KXCYKMRyDUrTDNe5THD8C2zJTui0yd8Lw+FBqDyPPpI36VXqJ1ssCzaru70/xDo3KhFjB5ekQfJe1C6/sy/gzSowrPA3AiJat6AwXU8uv19HkgPvT5ftgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erO90DAZx/FQpDKp2w6qza/sj84B3T5g4TkV8LUOJDM=;
 b=48IkfnlvLHmo7PztEqLBaQaW9HU9SSgoXfUjluwWtjOQMZ0N6pSONKN+lCJ3TBNcQLw+zx0WngtD13opjK3FDPZ6cB5CeDpNZPiP7vVYa57+pLW/Xowtv/TbFrDUHSxhpYBwRio2lNal26R8yU3ws8D9Oki6fm+SEU58l5Fb/po=
Received: from PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 08:08:56 +0000
Received: from PH0PR12MB7010.namprd12.prod.outlook.com
 ([fe80::dd46:c4c5:9616:daad]) by PH0PR12MB7010.namprd12.prod.outlook.com
 ([fe80::dd46:c4c5:9616:daad%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 08:08:56 +0000
From: "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>, "alex@shazbot.org"
	<alex@shazbot.org>, "anthony.pighin@nokia.com" <anthony.pighin@nokia.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] vfio/pci: Block for the upstream bridge lock in
 vfio_pci_core_disable()
Thread-Topic: [RFC PATCH] vfio/pci: Block for the upstream bridge lock in
 vfio_pci_core_disable()
Thread-Index: AQHdP2lw1+9ZgmhK+U+Sv9OKt/HLbrbPUrQw
Date: Tue, 15 Sep 2026 08:08:56 +0000
Message-ID:
 <PH0PR12MB7010CE4CF2192FED40DF5B6289BA2@PH0PR12MB7010.namprd12.prod.outlook.com>
References: <20260908080946.2235849-1-YuanShang.Mao@amd.com>
In-Reply-To: <20260908080946.2235849-1-YuanShang.Mao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: alex@shazbot.org,anthony.pighin@nokia.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-15T08:03:59.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7010:EE_|CH3PR12MB7740:EE_
x-ms-office365-filtering-correlation-id: 53b27926-d06b-48c8-bd82-08df13009707
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 H7Em6bjTl0zh4Yhb4L3v3MGBrYxLlwYiPKG+isPcOXlXvPJKFIJxZvoWtANRn8myhpxa/zxIhVecss3OuAa04TUBECJVBS8DoxBCFwTdTEfKHWci9TiEwmJZGGGXk0Kiluep4jmQuiIykJ92fZ7B2og6MM/NiJUYThPBuDXNIwDgNQu1yFQUX+mDhAmlmLJ263oMXbCt0NZ+YG7Mrd/kjt+yTs4X8YCLEB0dh6UxMMA+p7NCStVh1U6r6NQEwhE8IwUfPE1sGsIeILUN34MkozoQQqpEOqHRW5USD8D/MgklKjBI6e4sPz16mUL/MXaARG1e6Cx73w9Q1eIUXI6iaIz8Q+mFKDeLfWJDH/9aa8V9CUcqzxNrTeI8Zu520mv5TtIGlVSrPdlhh5Lb+KR1ysCkWlNbwmBJ+G+4dbIFcJsvuw3HrNAF3vkqkyqXTZCc1ixGhJrvw/2qqi/oVO5FS4KCtqgJF54yjyAepbDAV4eo39UPRh0WwEgXpO1Id2hAqh0hXxxjo43Joc68b+maU0GRziFmlBKbomN9/BeuVstPQdf7krPPgJB4OrUzjvSXQuQmTmIjjbpZF6kZXBTiBpTUOyU26TwBqMGtEtJMgasUSQvADiSaLW0axaAgV5U/xRFzVzdnoFm1udsbEAETgAHkgWX9ivWSuMIhefAegKAxoSMK6QO90C8sV2vvWt+j6OKkqRIu2bj2MccqNMpJiMcry8KG+Rk66PsJb06U35k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7010.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f7I868crD2SAHHjzDXxw4nThvrxwaS+iTzDgA4AMk4gzOGXUqtkY3/Xo+iX/?=
 =?us-ascii?Q?Ru7OH/Uzl5g8g00dJtc44W20YakdzR5GXiFYZygQeynUHO1Lq+p1NF4SgjMp?=
 =?us-ascii?Q?xWRSlvqf0sP0dnGWLNLNHfFEx+cHeQaqdm5PSlaI2FmXK+JbT/NIfLVoZ+j6?=
 =?us-ascii?Q?Up8UVsPGbHNUe5hon2X+mPBqHjSMFlPAOmXh+QHckF2u2dmy+8o3M64Imoqj?=
 =?us-ascii?Q?xquH0n7qj3ol0KX1w4GSOEk54sUik+uZ30SOEtN/wUMbmF67irFUXGSgskKt?=
 =?us-ascii?Q?8mM6W6xxEgrBRhIb7FENdRjNG9BbYWKvNambWySJSjBzSvgYZBECluWtJcXr?=
 =?us-ascii?Q?lGMk3QZGz0cbdqx6g3UZvCzNmwPH2bc+mLU5WHfykjyjtMowft5sHMf4bWtp?=
 =?us-ascii?Q?okqKpm9ToAhOFDClAo/Q2oiZG+UFbcC6CYxLBRFK7+OqwpRZEUH7UCB6BpcL?=
 =?us-ascii?Q?cchcdRi5XYSWONmcGRyQpcsWxy25r8pf+I12xOP888ICksbzVceH15+6aR2X?=
 =?us-ascii?Q?omFfxHaFry1Xsd/41CzL+rIzi7QuzPBNF/CF1lNMqYcfHm+ryPts0t/wF2xG?=
 =?us-ascii?Q?LVXdO7PegbKuS22VRMT+gZMCY8B6e4Tlo9gGczMYJescxWVrNTyW74eUIlik?=
 =?us-ascii?Q?DPVSa1fWawvaf0QPA6tuUwRi9njAvNsQWEUyoTwsl6/sLVsi98L9G/McBAvg?=
 =?us-ascii?Q?WpWv2jyunUB69qrl4rE0ZhSHSRkxolq4SiTeEwE/dH4X+NnMWOQeTrYiOvlw?=
 =?us-ascii?Q?MBbMPEidRfCp7uM4bfcQLpVhqthhSJDbXGtSNsG14olJD1nD+RD3V2XHWscZ?=
 =?us-ascii?Q?3K+qjskTofGZciPR/NwiNiGARL+klEc+qerOhuQQpCDpJBB1YxZG3SWZIwgD?=
 =?us-ascii?Q?lRvpHsBO2iAagb55YVVFkPvJ27azNhNK7EFuuRR80w18JJhPUp/9G+Xk/pct?=
 =?us-ascii?Q?IEDRDD1sqVW1DeD7K3gTW4bWe0gwLmMAXsw8ul4NpBmlmNbnP7gxZGszer+y?=
 =?us-ascii?Q?lal/GMFvI1R61nBj+dxAJOor4akk/M25blyQStbL8uphhdj38/dgLxuOEYF9?=
 =?us-ascii?Q?1WcAq7YYJEuyZi5D0mGtQCqgY1FUNFqVLeXrbcQWWSBgUxew8P6s/niBb6yA?=
 =?us-ascii?Q?k+lsNxihawZe3tdBkgpbYXIf/oxYB6ca5xaYfvJbPuqkwW9z2uFS5Bds+ynp?=
 =?us-ascii?Q?yRhWFiw7g4ClE5iHv6BYddOq8EgficUu3od1Pj7fqK42lo2GrJpk+4AlS3b2?=
 =?us-ascii?Q?EwosLfT3gyP4Y1CDL+LR9gWtmEqAB2x2HcVyikNCgjRuObNorcvxxP+LKUq/?=
 =?us-ascii?Q?3wOqnZW1OvFD+0K1ymszRoPYEg68BHL+83gnY5MkvaOUE1sJAYh//TqSaUs5?=
 =?us-ascii?Q?1A86vMTu7+h6WaLMy02qYVVd2txAE3WNkD8P5rgegPUHgzEAxD5PRl1FrmHS?=
 =?us-ascii?Q?8O8aQjGATkbNh5r0S4poP0i1txsDPHzPPz5ZvFFPwVXHkns0b0TqrNLhUiv7?=
 =?us-ascii?Q?O7bm84eQAv5CTbuay1TX/J2AUdcl/cCvpjv6AbJK90+J6KF4GQJ4nJv3Va82?=
 =?us-ascii?Q?UPTlzTAdHLUh6Mv3a3T5JT7VChh7U6+sSUP80vzptLOk6zNvaQEbAKtYGVvl?=
 =?us-ascii?Q?2Hpj/X2qCwHsqFrUEcfWHX0w1hKSJtUeUC/oTmsgXLO7mf1exhZk/KWn8tn/?=
 =?us-ascii?Q?MAD7/IC8eXfpIBlEj3N3Qr/TUe/oT+UBEcMwo/j9AqZdigmT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7010.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b27926-d06b-48c8-bd82-08df13009707
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 08:08:56.4410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mP4ZLscZXQzFoswwmB6JWt8TUoz+FKAGyKmZkvkSPoSLs0azXIFu+nv9Lw8lEdsz3CIRtreSnPoW6wkLK227sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740

AMD General

Hi @alex@shazbot.org, @anthony.pighin@nokia.com,

Just following up on the RFC below. Have you had a chance to take a look?
I'd appreciate any feedback on the proposed blocking bridge lock approach.
Thanks!

Best Regards,
Celine Zhang
-----Original Message-----
From: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Sent: Tuesday, September 8, 2026 4:10 PM
To: alex@shazbot.org; anthony.pighin@nokia.com
Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org; Zhang, Tiantian (Cel=
ine) <Tiantian.Zhang@amd.com>
Subject: [RFC PATCH] vfio/pci: Block for the upstream bridge lock in vfio_p=
ci_core_disable()

An upstream bridge is shared by every function below it, so taking it with =
pci_dev_trylock() makes the release-time reset fail whenever two functions =
under the same bridge are released at the same time.  One wins the trylock =
and resets; the others take the goto and are handed back to the next user w=
ithout ever being reset.  Nothing is logged.

This is easy to hit with SR-IOV, where all VFs of a device sit behind the s=
ame bridge.  Releasing just two VFs concurrently is already enough; which o=
ne wins the trylock is random between runs.

Take the bridge lock blocking instead.  The lock order (bridge, then
device) matches pci_bus_lock(), which takes both blocking.  The trylock on =
the device itself is left alone.

Concurrent releases now serialise their resets, so a teardown of many funct=
ions under one bridge pays one FLR settling time per function.

Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disa=
ble()")
Cc: stable@vger.kernel.org
Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
Hi Alex, Anthony,

Sending this as an RFC because I would like to know whether the approach is=
 acceptable before going further.

I hit this with SR-IOV: all VFs of a device share one upstream bridge, so w=
hen several VFs are released at the same time only one of them wins the try=
lock and gets reset.  The rest silently skip the reset.  Two concurrent rel=
eases are enough to reproduce it here.

My question is whether taking the bridge lock blocking is safe.  I have run=
 this without problems, but I do not fully understand what the trylock on t=
he bridge was protecting against -- 962ae6892d8b added it to silence the un=
locked-SBR warning, and it is not obvious to me whether blocking there can =
deadlock.  If there is a path I am missing, I would rather hear it now.

An alternative would be to keep the trylock but at least log when the reset=
 is skipped, since today it is completely silent.

Not yet tested under lockdep; I am setting that up.

 drivers/vfio/pci/vfio_pci_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_c=
ore.c
index 362c375a0579..8966a5bea406 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -790,8 +790,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_device =
*vdev)
         */
        if (vdev->reset_works) {
                bridge =3D pci_upstream_bridge(pdev);
-               if (bridge && !pci_dev_trylock(bridge))
-                       goto out_restore_state;
+               if (bridge)
+                       pci_dev_lock(bridge);
                if (pci_dev_trylock(pdev)) {
                        if (!__pci_reset_function_locked(pdev))
                                vdev->needs_reset =3D false;
@@ -801,7 +801,6 @@ void vfio_pci_core_disable(struct vfio_pci_core_device =
*vdev)
                        pci_dev_unlock(bridge);
        }

-out_restore_state:
        pci_restore_state(pdev);
 out:
        pci_disable_device(pdev);
--
2.25.1

